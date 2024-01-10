import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/features/components/widgets/sheet_titles.dart';
import 'package:hh_express/features/orders/components/dashed_line.dart';
import 'package:hh_express/features/orders/components/order_info_list_tile.dart';
import 'package:hh_express/features/product_details/view/modalSheet/bottom_bar.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/models/bill_moedl.dart';
import 'package:hh_express/models/cart/cart_order_model/cart_order_model.dart';
import 'package:hh_express/settings/consts.dart';

class BuyProdSheetBody extends StatelessWidget {
  const BuyProdSheetBody({super.key, this.bill, required this.model});

  final BillModel? bill;
  final CartOrderModel model;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        BottomSheetTitle(
            title: bill == null ? l10n.details : l10n.buy, isPadded: true),
        AppSpacing.vertical_10,
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 260.h,
                  width: double.infinity,
                  margin: AppPaddings.horiz_16.add(AppPaddings.vertic_15),
                  child: ClipRRect(
                    borderRadius: AppBorderRadiuses.border_6,
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          const MyShimerPlaceHolder(),
                      height: 260.h,
                      fit: BoxFit.cover,
                      imageUrl: model.product.image,
                    ),
                  ),
                ),
                _ProdBuyInfo(bill, model)
              ],
            ),
          ),
        ),
        if (bill != null) BuyProdBottomBar(quantity: model.quantity),
      ],
    );
  }
}

class _ProdBuyInfo extends StatelessWidget {
  const _ProdBuyInfo(this.bill, this.model);

  final BillModel? bill;
  final CartOrderModel model;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final billTitles = [
      '${l10n.products} (${model.quantity})',
      l10n.delivery,
      l10n.perKilogram,
      l10n.totalPrice,
    ];
    final billInfo = [
      '${bill?.total} TMT',
      '${bill?.delivery_cost} TMT',
      '${bill?.weight_cost} TMT',
      '${bill?.sub_total} TMT',
    ];
    return Container(
      margin: AppPaddings.all_16.copyWith(top: 0),
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
          OrderInfoListTile(
            title: l10n.prodName,
            content: model.product.name,
          ),
          ...(model.propertyValues ?? [])
              .map(
                (e) => OrderInfoListTile(
                  title: e.property,
                  content: e.icon != null ? e.icon : e.value,
                ),
              )
              .toList(),
          if (bill != null) const DashedLine(isLoading: false),
          if (bill != null)
            for (int i = 0; i < billInfo.length; i++)
              OrderInfoListTile(
                title: billTitles[i],
                content: billInfo[i] ?? '',
              ),
          if (bill != null) const DashedLine(isLoading: false),
          if (bill != null)
            OrderInfoListTile(
              title: billTitles.last,
              content: billInfo.last,
              contentBold: true,
              titleBold: true,
            )
        ],
      ),
    );
  }
}
