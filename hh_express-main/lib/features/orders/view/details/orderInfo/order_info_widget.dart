import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/orders/components/dashed_line.dart';
import 'package:hh_express/features/orders/components/order_info_list_tile.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/models/cart/cart_model/cart_model.dart';
import 'package:hh_express/settings/consts.dart';

class OrderInfoWidget extends StatelessWidget {
  const OrderInfoWidget({super.key, this.model});
  final CartModel? model;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (model == null) return _LoadingWidget();
    final titles = [
      l10n.comeDate,
      l10n.uuid,
      '${l10n.products} (${model!.orders.length})',
      l10n.delivery,
      l10n.perKilogram,
    ];
    final contents = [
      model!.date,
      model!.code,
      '',
      '${model!.deliveryCost} TMT',
      '${model!.weightCost} TMT',
    ];
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
      alignment: Alignment.topRight,
      child: Column(
        children: [
          for (int i = 0; i < 2; i++)
            OrderInfoListTile(
              title: titles[i],
              content: contents[i],
            ),
          DashedLine(isLoading: false),
          for (int i = 2; i < 5; i++)
            OrderInfoListTile(
              title: titles[i],
              content: contents[i],
            ),
          DashedLine(isLoading: false),
          OrderInfoListTile(
            title: l10n.totalPrice,
            content: '${model!.subTotal} TMT',
            contentBold: true,
            titleBold: true,
          )
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();
  @override
  Widget build(BuildContext context) {
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
      alignment: Alignment.topRight,
      child: Column(
        children: [
          for (int i = 0; i < 2; i++)
            OrderInfoListTile(
              title: null,
              content: null,
            ),
          DashedLine(isLoading: true),
          for (int i = 0; i < 3; i++)
            OrderInfoListTile(
              title: null,
              content: null,
            ),
          DashedLine(isLoading: true),
          OrderInfoListTile(
            title: null,
            content: null,
            contentBold: true,
            titleBold: true,
          )
        ],
      ),
    );
  }
}
