import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/settings/consts.dart';

class RemoveSelectedWidget extends StatelessWidget {
  const RemoveSelectedWidget({
    super.key,
    this.forAll,
  });
  final bool? forAll;
  @override
  Widget build(BuildContext context) {
    final forAll = this.forAll ?? false;
    return Container(
      height: 16.sp,
      width: 16.sp,
      padding: AppPaddings.all_2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: forAll ? AppColors.darkBlue : AppColors.white,
      ),
      child: FittedBox(
        child: Icon(
          Icons.close_rounded,
          color: forAll ? AppColors.lightGrey : AppColors.mainOrange,
        ),
      ),
    );
  }
}
