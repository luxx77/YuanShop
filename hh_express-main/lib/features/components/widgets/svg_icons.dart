import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hh_express/helpers/extentions.dart';

class MyImageIcon extends StatelessWidget {
  const MyImageIcon(
      {super.key,
      required this.path,
      this.iconSize,
      this.contSize,
      this.color,
      this.onTap});
  final String path;
  final double? iconSize;
  final double? contSize;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final contSize = this.contSize ?? 26.sp;
    final iconSize = this.iconSize ?? 18.2.sp;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        // color: Colors.red,
        alignment: Alignment.center,
        height: contSize,
        width: contSize,
        child: SvgPicture.asset(
          path,
          height: iconSize,
          width: iconSize,
          color: color ?? context.theme.iconTheme.color!,
        ),
      ),
    );
  }
}
