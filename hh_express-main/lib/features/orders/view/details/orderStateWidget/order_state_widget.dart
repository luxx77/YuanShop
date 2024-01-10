import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/orders/view/details/orderStateWidget/state_date_wiget.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/models/cart/cart_model/cart_model.dart';
import 'package:hh_express/settings/consts.dart';

class OrderStateWidget extends StatelessWidget {
  const OrderStateWidget({
    super.key,
    this.models,
  });
  final List<OrderStateModel>? models;

  int get getColLength {
    final length = models!.length;
    if (length == 1) return 1;
    return (length / 2).round();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = models == null;
    return Container(
      margin: AppPaddings.all_16,
      padding: AppPaddings.horiz16_vertic12,
      decoration: BoxDecoration(
        borderRadius: AppBorderRadiuses.border_6,
        border: Border.all(
          color: AppColors.lightGrey,
          width: 1.5.sp,
        ),
      ),
      child: isLoading
          ? _LoadingWidget()
          : Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      getColLength,
                      (index) => OrderStateWDate(
                        model: models![index],
                        isLast: index == getColLength - 1,
                      ),
                    ),
                  ),
                ),
                AppSpacing.horizontal_12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      getColLength,
                      (index) =>
                          index == getColLength - 1 && models!.length % 2 == 1
                              ? SizedBox(
                                  height: AppSpacing.getTextHeight(12 * 2),
                                )
                              : OrderStateWDate(
                                  model: models![getColLength + index],
                                  isLast: index == getColLength - 1,
                                ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _LoadingWidget extends StatefulWidget {
  const _LoadingWidget();

  @override
  State<_LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<_LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              3,
              (index) => Padding(
                padding: index == 1 ? AppPaddings.vertic_24 : EdgeInsets.zero,
                child: OrderStateWDate(
                  isLast: index == 2,
                ),
              ),
            ),
          ),
        ),
        AppSpacing.horizontal_12,
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              3,
              (index) {
                return index == 2
                    ? SizedBox(
                        height: AppSpacing.getTextHeight(12 * 2),
                      )
                    : Padding(
                        padding: index == 1
                            ? AppPaddings.vertic_24
                            : EdgeInsets.zero,
                        child: OrderStateWDate(
                          isLast: index == 2,
                        ),
                      );
              },
            ),
          ),
        ),
      ],
    );
  }
}
