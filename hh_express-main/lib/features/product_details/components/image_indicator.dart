import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/settings/consts.dart';

class ImageIndicator extends StatefulWidget {
  const ImageIndicator(
      {super.key, required this.controller, required this.total});
  final PageController controller;
  final int total;
  @override
  State<ImageIndicator> createState() => _ImageIndicatorState();
}

class _ImageIndicatorState extends State<ImageIndicator> {
  @override
  void initState() {
    _currentIndex.value = (widget.controller.page ?? 0).round();
    widget.controller.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }

  void listener() {
    _currentIndex.value = (widget.controller.page ?? 0).round();
  }

  final _currentIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      decoration: BoxDecoration(
          color: Colors.black26, borderRadius: BorderRadius.circular(8)),
      padding: AppPaddings.all_2.add(AppPaddings.horiz_4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.total,
            (index) {
              return ValueListenableBuilder(
                valueListenable: _currentIndex,
                builder: (context, value, child) {
                  final isSelected = _currentIndex.value == index;
                  return AnimatedContainer(
                    duration: AppDurations.duration_250ms,
                    margin: AppPaddings.horiz_2.add(AppPaddings.vertic_6),
                    height: 5.sp,
                    width: 5.sp,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? AppColors.white : AppColors.darkGrey,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
