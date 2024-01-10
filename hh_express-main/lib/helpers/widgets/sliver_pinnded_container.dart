import 'package:flutter/material.dart';

class SliverPinndedContainer extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;
  final Color? color;
  final EdgeInsets? margin;

  SliverPinndedContainer({
    required this.widget,
    required this.height,
    this.margin,
    this.color,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
      ),
      width: double.infinity,
      height: height,
      child: widget,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
