import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/orders/components/dashed_line.dart';
import 'package:hh_express/features/orders/components/order_info_list_tile.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/models/cart/cart_model/cart_model.dart';
import 'package:hh_express/settings/consts.dart';

class CartInfoWidget extends StatelessWidget {
  const CartInfoWidget({super.key, this.model});
  final CartModel? model;
  @override
  Widget build(BuildContext context) {
    final isLoading = model == null;
    if (isLoading) return _LoadingWidget();
    final l10n = context.l10n;
    final titles = [
      '${l10n.products} (${model!.orders.length})',
      l10n.delivery,
      l10n.perKilogram,
    ];
    final content = [
      AppPaddings.thousandsSeperator(model!.total),
      AppPaddings.thousandsSeperator(model!.deliveryCost),
      AppPaddings.thousandsSeperator(model!.weightCost),
      AppPaddings.thousandsSeperator(model!.subTotal),
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
          for (int i = 0; i < 3; i++)
            OrderInfoListTile(
              title: titles[i],
              content: '${content[i]} TMT',
            ),
          DashedLine(
            isLoading: false,
          ),
          OrderInfoListTile(
            title: 'Jemi bahasy',
            content: isLoading ? null : '${content.last} TMT',
            contentBold: true,
            titleBold: true,
          )
        ],
      ),
    );
  }
}

final class _LoadingWidget extends StatelessWidget {
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
          for (int i = 0; i < 3; i++)
            OrderInfoListTile(
              title: null,
              content: null,
            ),
          DashedLine(
            isLoading: true,
          ),
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
