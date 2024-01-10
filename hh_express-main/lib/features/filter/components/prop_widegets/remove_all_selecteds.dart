import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/filter/bloc/filter_bloc.dart';
import 'package:hh_express/features/filter/components/remove_selected_cross.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class RemoveAllSeleteds extends StatelessWidget {
  RemoveAllSeleteds({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = AppTheme.titleMedium12(context);
    final l10n = context.l10n;
    final bloc = context.read<FilterBloc>();

    return GestureDetector(
      onTap: () {
        bloc.add(ClearFilter());
      },
      child: Container(
        height: 30.sp,
        padding: AppPaddings.horiz10_vertic5,
        decoration: BoxDecoration(
          borderRadius: AppBorderRadiuses.border_6,
          color: AppColors.lightGrey,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              child: Text(
                '${l10n.removeAll}',
                style: textTheme,
              ),
            ),
            AppSpacing.horizontal_5,
            RemoveSelectedWidget(
              forAll: true,
            ),
          ],
        ),
      ),
    );
  }
}
