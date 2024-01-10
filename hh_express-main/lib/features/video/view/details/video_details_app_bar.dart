import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hh_express/features/video/cubit/video_cubit.dart';
import 'package:hh_express/features/video/view/details/cubit/video_details_cubit.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';

class VideoDetailsAppBar extends StatefulWidget {
  const VideoDetailsAppBar({super.key, required this.comeBackListener});
  final VoidCallback comeBackListener;

  @override
  State<VideoDetailsAppBar> createState() => _VideoDetailsAppBarState();
}

class _VideoDetailsAppBarState extends State<VideoDetailsAppBar> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding:
            AppPaddings.horiz10_vertic5.copyWith(top: AppSpacing.topPad + 16.h),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (appRouter.location.split('?').first !=
                    AppRoutes.videoDetails) return;
                appRouter.currentContext.pop();
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: context.theme.scaffoldBackgroundColor,
                size: 28.sp,
              ),
            ),
            TextButton(
              onPressed: () async {
                final vdCubit = context.read<VideoDetailsCubit>();
                final videoCubit = context.read<VideoCubit>();
                final currentModel =
                    videoCubit.state.models[vdCubit.state.currentPage];
                if (appRouter.location.split('?').first !=
                    AppRoutes.videoDetails) return;
                context.push(AppRoutes.prodDetails,
                    extra: currentModel.product.id);
                vdCubit.changePage(-1);
                appRouter.addListener(widget.comeBackListener);
              },
              child: Text(
                context.l10n.details,
                style: context.theme.textTheme.labelLarge,
              ),
              style: ButtonStyle(
                alignment: Alignment.center,
                overlayColor: MaterialStatePropertyAll(
                  Colors.grey.withOpacity(.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
