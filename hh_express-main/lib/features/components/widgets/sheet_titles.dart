import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/widgets/svg_icons.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class BottomSheetTitle extends StatelessWidget {
  const BottomSheetTitle({super.key, required this.title, this.isPadded});
  final String title;
  final bool? isPadded;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadded != null
          ? AppPaddings.horiz_16.copyWith(top: 16.h)
          : EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20.sp,
          ),
          Text(
            title,
            style: AppTheme.titleMedium16(context),
          ),
          MyImageIcon(
            path: AssetsPath.crossIcon,
            contSize: 20.sp,
            iconSize: 20.sp,
            onTap: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }
}
