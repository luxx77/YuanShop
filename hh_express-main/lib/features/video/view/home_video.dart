import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hh_express/features/categories/view/body.dart';
import 'package:hh_express/features/components/widgets/product_pagination_bottom.dart';
import 'package:hh_express/features/video/components/video_widget.dart';
import 'package:hh_express/features/video/cubit/video_cubit.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';

class HomeVideos extends StatefulWidget {
  const HomeVideos({super.key});

  @override
  State<HomeVideos> createState() => _TestScrennStaee();
}

class _TestScrennStaee extends State<HomeVideos> {
  late final cubit = context.read<VideoCubit>()..init();

  @override
  void initState() {
    scrollController.addListener(() {
      cubit.lastPosition = scrollController.position.pixels;
      if (scrollController.position.pixels >=
              (scrollController.position.maxScrollExtent - 15.h) &&
          scrollController.position.isScrollingNotifier.value) {
        final state = cubit.state;
        if (state.apiState != ProductAPIState.success ||
            state.pagination!.currentPage == state.pagination!.lastPage) {
          return;
        }
        cubit.loadMore();
      }
    });
    super.initState();
  }

  late final scrollController =
      ScrollController(initialScrollOffset: cubit.lastPosition);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<VideoCubit, VideoState>(
        bloc: cubit,
        builder: (context, state) {
          final apiState = state.apiState;
          if (apiState == ProductAPIState.init) return SizedBox();
          if (apiState == ProductAPIState.error)
            return CategoryErrorBody(
              onTap: () {
                cubit.init();
              },
            );
          final isLoading = apiState == ProductAPIState.loading;
          return RefreshIndicator.adaptive(
            onRefresh: () async {
              cubit.init(forUpdate: true);
            },
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverPadding(
                  padding: AppPaddings.horiz_16.add(AppPaddings.vertic_12),
                  sliver: SliverMasonryGrid.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 12.h,
                    childCount: isLoading ? null : state.models.length,
                    itemBuilder: (context, index) {
                      return VideoWidget(
                        index: index,
                        model: isLoading ? null : state.models[index],
                      );
                    },
                  ),
                ),
                ProductPaginationBottom(
                  isLastPage: state.pagination?.currentPage ==
                      state.pagination?.lastPage,
                  state: state.apiState,
                  onErrorTap: () => cubit.loadMore(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
