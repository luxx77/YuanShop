import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/settings/consts.dart';

class SheetListTileSelectedIndicator extends StatelessWidget {
  const SheetListTileSelectedIndicator({super.key, required this.isSelected});
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 20.sp,
      width: 20.sp,
      margin: AppPaddings.vertic_12,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.mainOrange : Colors.transparent,
        shape: BoxShape.circle,
        border: isSelected
            ? null
            : Border.all(
                color: AppColors.darkGrey,
                width: 2,
              ),
      ),
      alignment: Alignment.center,
      duration: AppDurations.duration_150ms,
      child: isSelected
          ? Container(
              height: 10.sp,
              width: 10.sp,
              // duration: AppDurations.duration_150ms,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white,
              ),
            )
          : null,
    );
  }
}
