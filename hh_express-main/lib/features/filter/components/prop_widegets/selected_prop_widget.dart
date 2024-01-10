import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/filter/bloc/filter_bloc.dart';
import 'package:hh_express/features/filter/components/prop_widegets/selected_color_widget.dart';
import 'package:hh_express/features/filter/components/remove_selected_cross.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/models/property/values/property_value_model.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class SelectedFilterPropWidget extends StatelessWidget {
  SelectedFilterPropWidget({
    super.key,
    required this.value,
  });
  //change it to PropValue Model
  final PropertyValue value;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FilterBloc>();
    return GestureDetector(
      onTap: () {
        bloc.add(RemoveFilterProperty(model: value));
      },
      child: Container(
        height: 30.sp,
        margin: AppPaddings.bottom_10,
        padding: AppPaddings.horiz10_vertic5,
        decoration: BoxDecoration(
          borderRadius: AppBorderRadiuses.border_6,
          color: AppColors.mainOrange,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            value.isColor
                ? SelectedFilterColorWidget(
                    color: value,
                  )
                : FittedBox(
                    child: Text(
                      '${value.value}',
                      style: AppTheme.displayMedium12(context),
                    ),
                  ),
            AppSpacing.horizontal_5,
            RemoveSelectedWidget(forAll: false),
          ],
        ),
      ),
    );
  }
}
