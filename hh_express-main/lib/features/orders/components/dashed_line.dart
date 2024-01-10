import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/settings/consts.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({super.key, this.isLoading});
  final bool? isLoading;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.5.h,
      margin: AppPaddings.bottom_15,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Container(
          width: 5.w,
          height: 1.h,
          color:
              isLoading ?? false ? AppColors.transparent : AppColors.darkGrey,
          margin: AppPaddings.right_6,
          child: isLoading ?? false ? MyShimerPlaceHolder() : null,
        ),
      ),
    );
  }
}
