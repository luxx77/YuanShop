import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/categories/view/body.dart';
import 'package:hh_express/features/components/widgets/product_pagination_bottom.dart';
import 'package:hh_express/features/home/view/components/product_builder.dart';
import 'package:hh_express/features/more_simmilar_products/cubit/more_sim_prods_cubit.dart';
import 'package:hh_express/settings/enums.dart';

class MoreSimProdsBody extends StatefulWidget {
  const MoreSimProdsBody({super.key});

  @override
  State<MoreSimProdsBody> createState() => _MoreSimProdsBodyState();
}

class _MoreSimProdsBodyState extends State<MoreSimProdsBody> {
  final scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          (scrollController.position.maxScrollExtent - 15.h)) {
        final state = cubit.state;
        if (state.apiState != ProductAPIState.success) {
          return;
        }
        cubit.loadMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  late final cubit = context.read<MoreSimProdsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoreSimProdsCubit, MoreSimProdsState>(
      builder: (context, state) {
        final apiState = state.apiState;
        if (apiState == PaginatedApiState.init) return SizedBox();
        if (apiState == PaginatedApiState.error) return CategoryErrorBody();
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            await cubit.init(forUpdate: true);
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              HomeProdBuilder(
                prods: state.products,
              ),
              ProductPaginationBottom(
                isLastPage:
                    state.pagination?.currentPage == state.pagination?.lastPage,
                state: state.apiState,
                onErrorTap: () => cubit.loadMore(),
              )
            ],
          ),
        );
      },
    );
  }
}
