import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hh_express/features/filter/bloc/filter_bloc.dart';
import 'package:hh_express/features/filter/components/prop_widegets/selected_prop_widget.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/settings/consts.dart';

class SelectedFilterDetails extends StatelessWidget {
  const SelectedFilterDetails({super.key});
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FilterBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.filter),
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
            final selecteds = bloc.forHome
                ? bloc.state.homeSelecteds
                : bloc.state.prodByCatselecteds;
            return Wrap(
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              alignment: WrapAlignment.start,
              spacing: 10.w,
              children: selecteds
                  .map(
                    (e) => SelectedFilterPropWidget(value: e),
                  )
                  .toList(),
            );
          },
        ),
      ).toSingleChildScrollView,
    );
  }
}
