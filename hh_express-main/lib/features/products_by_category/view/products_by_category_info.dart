import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/categories/bloc/category_bloc.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class ProductsByCategoryInfo extends StatelessWidget {
  const ProductsByCategoryInfo({
    super.key,
    this.subTitle,
    this.title,
    this.total,
  });
  final String? title;
  final int? total;
  final String? subTitle;
  @override
  Widget build(BuildContext context) {
    final catState = context.read<CategoryBloc>().state;
    final l10n = context.l10n;
    final isLoading = total == null;
    return SliverPadding(
      padding: EdgeInsets.only(
        left: 16.w,
        top: 10.h,
        bottom: 15.h,
      ),
      sliver: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading
              ? MyShimerPlaceHolder(
                  height: 20.h,
                  width: 144.w,
                  margin: AppPaddings.vertic_4,
                )
              : Text(
                  catState.mains![catState.activIndex!].name,
                  style: AppTheme.titleLarge18(context),
                ),
          isLoading
              ? MyShimerPlaceHolder(
                  height: 15.h,
                  width: 66.w,
                )
              : Text(
                  '$title',
                  style: AppTheme.bodyLargeW500(context),
                ),
          AppSpacing.vertical_4,
          isLoading
              ? MyShimerPlaceHolder(
                  height: 15.h,
                  width: 83.w,
                )
              : Text(
                  '$total ${l10n.products.toLowerCase()}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
        ],
      ).toSliverBox,
    );
  }
}
