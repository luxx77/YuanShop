import 'package:flutter/material.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:shimmer/shimmer.dart';

/// Place holder
class MyShimerPlaceHolder extends StatelessWidget {
  const MyShimerPlaceHolder({
    super.key,
    this.height,
    this.radius,
    this.margin,
    this.child,
    this.width,
  });
  final double? height;
  final double? width;
  final BorderRadius? radius;
  final EdgeInsets? margin;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: AppDurations.duration_1500ms,
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightColor,
      child: child ??
          Container(
            margin: margin,
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: radius ?? AppBorderRadiuses.border_4,
              color: AppColors.shimmerBodyColor,
            ),
          ),
    );
  }
}
