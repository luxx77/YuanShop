import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/categories/view/body.dart';
import 'package:hh_express/features/components/widgets/sheet_titles.dart';
import 'package:hh_express/features/product_details/view/product_details_body.dart';
import 'package:hh_express/features/video/video_sim_prods_widget.dart';
import 'package:hh_express/features/video/sim_prods/cubit/simmilar_prods_cubit.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/helpers/widgets/sliver_pinnded_container.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';

class VideoSimmilarProdsSheet extends StatefulWidget {
  const VideoSimmilarProdsSheet(this.slug, this.id);
  final int id;
  final String slug;
  @override
  State<VideoSimmilarProdsSheet> createState() =>
      _VideoSimmilarProdsSheetState();
}

class _VideoSimmilarProdsSheetState extends State<VideoSimmilarProdsSheet> {
  final scrollController = ScrollController();
  @override
  void initState() {
    scrollController.addListener(() {
      if (cubit == null) return;
      if (scrollController.position.pixels >=
              (scrollController.position.maxScrollExtent - 30.h) &&
          scrollController.position.isScrollingNotifier.value) {
        final state = cubit!.state;
        if (state.state != ProductAPIState.success ||
            state.pagination!.currentPage == state.pagination!.lastPage) {
          return;
        }
        cubit!.loadMore();
      }
    });
    super.initState();
  }

  SimmilarProdsCubit? cubit;

  void initBloc(BuildContext ctx) {
    if (cubit != null) return;
    cubit = ctx.read<SimmilarProdsCubit>()..init();
  }

  @override
  Widget build(BuildContext ctx) {
    return Provider(
      create: (context) => SimmilarProdsCubit(widget.slug, widget.id),
      builder: (context, child) {
        initBloc(context);
        return ClipRRect(
          borderRadius: AppBorderRadiuses.border_10,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: AppBorderRadiuses.border_10,
            ),
            height:
                MediaQuery.sizeOf(context).height - 92.h - AppSpacing.topPad,
            width: double.infinity,
            child: BlocBuilder<SimmilarProdsCubit, SimmilarProdsState>(
              bloc: cubit,
              builder: (context, state) {
                final apiState = state.state;
                if (apiState == ProductAPIState.init) return SizedBox();
                if (apiState == ProductAPIState.error)
                  return CategoryErrorBody();
                if (apiState == ProductAPIState.loading) return CenterLoading();
                return CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverPinndedContainer(
                        height: AppSpacing.getTextHeight(16 + 32.sp),
                        widget: Padding(
                          padding: AppPaddings.all_16,
                          child: BottomSheetTitle(
                            title:
                                '${context.l10n.all} (${state.pagination?.count ?? 0})',
                          ),
                        ),
                      ),
                    ),
                    SliverList.builder(
                      itemCount: state.prods!.length,
                      itemBuilder: (context, index) => SimmilarVideoWidget(
                        model: state.prods![index],
                      ),
                    ),
                    if (apiState == ProductAPIState.loadingMoreError)
                      CategoryErrorBody(
                        onTap: () {
                          cubit!.loadMore();
                        },
                      ).toSliverBox,
                    if (apiState == ProductAPIState.loadingMore)
                      CenterLoading().toSliverBox
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
