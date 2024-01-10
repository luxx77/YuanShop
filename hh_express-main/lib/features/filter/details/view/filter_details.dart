import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hh_express/features/filter/bloc/filter_bloc.dart';
import 'package:hh_express/features/filter/components/prop_widegets/filter_color.dart';
import 'package:hh_express/features/filter/components/prop_widegets/filter_prop_widget.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/models/property/property_model.dart';
import 'package:hh_express/settings/consts.dart';

class FilterDetailsScreen extends StatelessWidget {
  const FilterDetailsScreen({
    super.key,
    required this.model,
  });
  final PropertyModel model;
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FilterBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(model.name),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.darkBlue,
          ),
          iconSize: 23.sp,
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Padding(
        padding: AppPaddings.all_16,
        child: BlocBuilder<FilterBloc, FilterState>(
          bloc: bloc,
          builder: (context, state) {
            return Wrap(
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              spacing: 10.w,
              children: model.values
                  .map(
                    (e) => model.isColor ?? false
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
      ).toSingleChildScrollView,
    );
  }
}
