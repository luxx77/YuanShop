import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/filter/bloc/filter_bloc.dart';
import 'package:hh_express/models/property/values/property_value_model.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class FilterPropWidget extends StatelessWidget {
  FilterPropWidget({
    super.key,
    required this.model,
    this.onTap,
  });
  final PropertyValue model;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTheme.titleMedium12(context);
    final isSelected = context.read<FilterBloc>().isSelected(model.id);
    return GestureDetector(
      onTap: () {
        if (onTap == null) return;
        onTap!();
      },
      child: AnimatedContainer(
        duration: AppDurations.duration_50ms,
        height: 30.sp,
        margin: AppPaddings.bottom_10,
        padding: AppPaddings.horiz10_vertic5,
        decoration: BoxDecoration(
          borderRadius: AppBorderRadiuses.border_8,
          border: isSelected
              ? AppBorderRadiuses.appOrangetBorder
              : AppBorderRadiuses.transparentBorder,
          color: isSelected
              ? AppColors.mainOrange.withOpacity(0.13)
              : AppColors.lightGrey,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model.value,
              style: textTheme.copyWith(
                color: isSelected ? AppColors.appOrange : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
