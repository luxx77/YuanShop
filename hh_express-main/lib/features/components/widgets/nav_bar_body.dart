import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/settings/consts.dart';

class NavBarBody extends StatelessWidget {
  const NavBarBody({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppPaddings.horiz16_vertic12,
      height: 72.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: AppColors.navBarShaow,
      ),
      child: child,
    );
  }
}
