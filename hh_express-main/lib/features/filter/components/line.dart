import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/settings/consts.dart';

class FilterLine extends StatelessWidget {
  const FilterLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5.h, bottom: 32.h),
      color: AppColors.lightGrey,
      height: 1.sp,
    );
  }
}
