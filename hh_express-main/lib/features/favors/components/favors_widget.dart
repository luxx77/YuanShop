import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/widgets/favors_image.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/features/components/widgets/svg_icons.dart';
import 'package:hh_express/features/favors/bloc/favors_bloc.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/modal_sheets.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/models/cart/cart_product_model/cart_product_model.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';
import 'package:hh_express/helpers/routes.dart';

class FavorsWidget extends StatefulWidget {
  FavorsWidget({
    super.key,
    this.model,
    this.onWidgetTap,
  });
  final CartProductModel? model;
  final VoidCallback? onWidgetTap;
  @override
  State<FavorsWidget> createState() => _FavorsWidgetState();
}

class _FavorsWidgetState extends State<FavorsWidget> {
  late bool isFavor = widget.model?.isFavorite ?? false;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FavorsCubit>();
    final isLoading = widget.model == null;
    if (isLoading) return _LoadingWidget();
    return GestureDetector(
      onTap: widget.onWidgetTap ??
          () {
            ModelBottomSheetHelper.doPop();
            appRouter
                .push(AppRoutes.prodDetails, extra: widget.model!.id)
                .then((value) {
              if (appRouter.location != AppRoutes.mainScreen) return;
              // 3 index of favors modal sheet
              ModelBottomSheetHelper.showProfileSheets(3);
            });
          },
      child: Container(
        margin: AppPaddings.horiz16_botto10,
        height: 100.h,
        padding: AppPaddings.right_7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppBorderRadiuses.border_6,
          border: AppBorderRadiuses.defBorder,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FavorsImage(
              imgPath: widget.model?.image,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.model?.name}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.titleMedium16(context),
                  ),
                  AppSpacing.vertical_7,
                  Text(
                    '${widget.model!.salePrice} TMT',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTheme.titleMedium14(context),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.model == null) return;
                final val = await cubit.switchFavor(widget.model!);
                if (val != null) {
                  setState(() {
                    isFavor = val;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                shadowColor: AppColors.transparent,
                side: BorderSide.none,
                disabledBackgroundColor: AppColors.white,
                shape: const CircleBorder(),
                padding: AppPaddings.all_5,
                minimumSize: const Size(0, 0),
                maximumSize: Size(35.w, 35.h),
                backgroundColor: AppColors.white,
                foregroundColor: Colors.grey.withOpacity(0.1),
              ),
              child: MyImageIcon(
                path: AssetsPath.favorFilled,
                color: (cubit.isFavor(widget.model?.id ?? 0)
                      ..log(message: '${widget.model!.name}:'))
                    ? AppColors.mainOrange
                    : AppColors.darkGrey,
                contSize: 24.sp,
                iconSize: 19.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppPaddings.horiz16_botto10,
      height: 100.h,
      padding: AppPaddings.right_7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppBorderRadiuses.border_6,
        border: AppBorderRadiuses.defBorder,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const FavorsImage(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyShimerPlaceHolder(
                  height: 21.h,
                  radius: AppBorderRadiuses.border_4,
                ),
                AppSpacing.vertical_7,
                MyShimerPlaceHolder(
                  height: 21.h,
                  radius: AppBorderRadiuses.border_4,
                ),
              ],
            ),
          ),
          Padding(
            padding: AppPaddings.all_5,
            child: MyShimerPlaceHolder(
              child: MyImageIcon(
                path: AssetsPath.favorIcon,
                color: AppColors.shimmerBodyColor,
                contSize: 24.sp,
                iconSize: 19.w,
              ),
            ),
          )
        ],
      ),
    );
  }
}
