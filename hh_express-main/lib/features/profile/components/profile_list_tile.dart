import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/widgets/svg_icons.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({
    super.key,
    required this.iconPath,
    required this.onTap,
    required this.title,
    required this.tralling,
  });
  final String title;
  final String iconPath;
  final String tralling;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.horiz_16.copyWith(bottom: 12.h),
      child: ClipRRect(
        borderRadius: AppBorderRadiuses.border_6,
        child: Material(
          color: AppColors.lightGrey,
          child: InkWell(
            onTap: onTap,
            child: Container(
              padding: AppPaddings.all_12,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyImageIcon(
                    path: iconPath,
                    contSize: 24.sp,
                  ),
                  AppSpacing.horizontal_4,
                  Expanded(
                    flex: 4,
                    child: Text(
                      title,
                      style: AppTheme.titleLarge12(context),
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      tralling,
                      style: AppTheme.bodyMedium12(context),
                      maxLines: 1,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  AppSpacing.horizontal_8,
                  FittedBox(
                    alignment: Alignment.center,
                    child: MyImageIcon(
                      path: AssetsPath.forvardIcon,
                      contSize: 24.sp,
                      iconSize: 12.h,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
