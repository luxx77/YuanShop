import 'package:extended_wrap/extended_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/filter/bloc/filter_bloc.dart';
import 'package:hh_express/features/filter/components/line.dart';
import 'package:hh_express/features/filter/components/prop_widegets/filter_color.dart';
import 'package:hh_express/features/filter/components/prop_widegets/filter_prop_widget.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/modal_sheets.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/models/property/property_model.dart';
import 'package:hh_express/settings/theme.dart';

class FilterPropertyBuilder extends StatelessWidget {
  const FilterPropertyBuilder({
    super.key,
    required this.prop,
  });
  final PropertyModel prop;
  @override
  Widget build(BuildContext context) {
    final buttonTheme = context.theme.textButtonTheme.style as MyButtonStyle;
    final bloc = context.read<FilterBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                prop.name,
                style: AppTheme.titleMedium16(context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            TextButton(
              onPressed: () {
                ModelBottomSheetHelper.doPop();
                appRouter
                    .push(AppRoutes.filterDetails, extra: prop)
                    .then((value) {
                  ModelBottomSheetHelper.showFilterSheet();
                });
              },
              style: buttonTheme,
              child: Text(
                context.l10n.all,
                style: buttonTheme.myTextStyle,
              ),
            )
          ],
        ),
        AppSpacing.vertical_18,
        BlocBuilder<FilterBloc, FilterState>(
          bloc: bloc,
          builder: (context, state) {
            return ExtendedWrap(
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              spacing: 10.w,
              maxLines: prop.isColor ?? false ? 1 : 2,
              children: prop.values
                  .map(
                    (e) => prop.isColor ?? false
                        ? FilterColorWidget(
                            color: e,
                            isSelected: bloc.isSelected(e.id),
                            onTap: () => bloc.switchProp(e),
                          )
                        : FilterPropWidget(
                            model: e,
                            onTap: () => bloc.switchProp(e),
                          ),
                  )
                  .toList(),
            );
          },
        ),
        FilterLine()
      ],
    );
  }
}
