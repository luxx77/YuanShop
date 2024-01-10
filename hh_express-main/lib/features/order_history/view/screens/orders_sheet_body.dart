import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/categories/view/body.dart';
import 'package:hh_express/features/components/widgets/sheet_titles.dart';
import 'package:hh_express/features/order_history/cubit/order_history_cubit.dart';
import 'package:hh_express/features/order_history/view/widgets/orders_widget.dart';
import 'package:hh_express/features/product_details/view/product_details_body.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';

class OrdersSheetBody extends StatelessWidget {
  const OrdersSheetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomSheetTitle(
          title: context.l10n.myOrders,
          isPadded: true,
        ),
        Container(
          padding: AppPaddings.vertic_10,
          height: 434.h,
          width: double.infinity,
          alignment: Alignment.center,
          child: OrderHistoryBuilder(),
        ),
      ],
    ).toSingleChildScrollView;
  }
}

class OrderHistoryBuilder extends StatefulWidget {
  const OrderHistoryBuilder({super.key});

  @override
  State<OrderHistoryBuilder> createState() => _OrderHistoryBuilderState();
}

class _OrderHistoryBuilderState extends State<OrderHistoryBuilder> {
  late final cubit = context.read<OrderHistoryCubit>()..init(forUpdate: true);
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (scrollController.position.maxScrollExtent - 30.h) &&
          scrollController.position.isScrollingNotifier.value) {
        final state = cubit.state;
        if (state.apiState != OrderHistoryAPIState.success ||
            state.pagination!.currentPage == state.pagination!.lastPage) {
          return;
        }
        cubit.loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
      bloc: cubit,
      builder: (context, state) {
        final apiState = state.apiState;
        if (apiState == OrderHistoryAPIState.init) return SizedBox();
        if (apiState == OrderHistoryAPIState.error)
          return CategoryErrorBody(
            onTap: () => cubit.init(),
          );
        if (apiState == OrderHistoryAPIState.unauthorized)
          return Center(
            child: Text(
              context.l10n.unauthorized,
            ),
          );
        if (apiState == OrderHistoryAPIState.success && state.models.isEmpty)
          return Center(
            child: Text(
              context.l10n.empty,
            ),
          );
        final isLoading = apiState == OrderHistoryAPIState.loading;
        return RefreshIndicator(
          onRefresh: () async => cubit.init(forUpdate: true),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              AppSpacing.vertical_10.toSliverBox,
              SliverList.builder(
                itemCount: isLoading ? 10 : state.models.length,
                itemBuilder: (context, index) {
                  return OrderHistoryWidget(
                    /// condition to show loading
                    model: isLoading ? null : state.models[index],
                  );
                },
              ),
              if (apiState == OrderHistoryAPIState.errorMore)
                CategoryErrorBody(
                  onTap: () {
                    cubit.loadMore();
                  },
                ).toSliverBox,
              if (apiState == OrderHistoryAPIState.loadingMore)
                CenterLoading().toSliverBox
            ],
          ),
        );
      },
    );
  }
}
