import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/models/cart/cart_model/cart_model.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class OrderStateWDate extends StatelessWidget {
  const OrderStateWDate({super.key, this.model, required this.isLast});
  final OrderStateModel? model;
  final bool isLast;
  @override
  Widget build(BuildContext context) {
    final isLoading = model == null;
    if (isLoading) return _LoadingWidget();
    final theme = Theme.of(context).textTheme;
    final height = AppSpacing.getTextHeight(12);
    return Padding(
      padding: isLast ? EdgeInsets.zero : AppPaddings.bottom_28,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: height * 1.6,
            alignment: Alignment.center,
            padding: AppPaddings.all_4,
            margin: AppPaddings.right_6,
            decoration: BoxDecoration(
              color: model!.completed_at != null
                  ? AppColors.green
                  : AppColors.lightGrey,
              shape: BoxShape.circle,
            ),
            child: FittedBox(
              child: Icon(
                model!.completed_at != null ? Icons.check_rounded : Icons.close,
                color: AppColors.lightGrey,
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    model!.state,
                    maxLines: 1,
                    style: AppTheme.titleLarge12(context),
                  ),
                ),
                FittedBox(
                  child: Text(
                    model?.completed_at ?? '00.00.0/00:00',
                    maxLines: 1,
                    style: theme.titleSmall,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final height = AppSpacing.getTextHeight(12);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        MyShimerPlaceHolder(
          height: height * 1.6,
          child: Container(
            height: height * 1.6,
            width: height * 1.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.shimmerBodyColor,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              2,
              (index) => MyShimerPlaceHolder(
                height: height,
                margin: AppPaddings.horiz_8.copyWith(top: 2.h, bottom: 2.h),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
