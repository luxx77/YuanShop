import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/categories/view/body.dart';
import 'package:hh_express/features/components/widgets/product_pagination_bottom.dart';
import 'package:hh_express/features/home/bloc/home_bloc.dart';
import 'package:hh_express/features/home/view/components/product_builder.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    bloc = context.read<HomeBloc>()..init();
    scrollController = ScrollController(initialScrollOffset: bloc.lastPosition);
    scrollController.addListener(() {
      bloc.lastPosition = scrollController.position.pixels;
      if (scrollController.position.pixels >=
              (scrollController.position.maxScrollExtent - 15.h) &&
          scrollController.position.isScrollingNotifier.value) {
        final state = bloc.state;
        if (state.state != ProductAPIState.success ||
            state.pagination!.currentPage == state.pagination!.lastPage) {
          return;
        }
        bloc.loadMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  late final HomeBloc bloc;
  late final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        if (state.state == ProductAPIState.init) {
          return SizedBox();
        }
        if (state.state == ProductAPIState.error) {
          return CategoryErrorBody(
            onTap: () {
              bloc.init();
            },
          );
        }
        return RefreshIndicator.adaptive(
          onRefresh: () async {
            await bloc.init(forUpdate: true);
          },
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPadding(
                padding: AppPaddings.bottom_10,
                sliver: HomeProdBuilder(
                  prods: state.prods,
                ),
              ),
              ProductPaginationBottom(
                isLastPage:
                    state.pagination?.currentPage == state.pagination?.lastPage,
                state: state.state,
                onErrorTap: () => bloc.loadMore(),
              )
            ],
          ),
        );
      },
    );
  }
}
