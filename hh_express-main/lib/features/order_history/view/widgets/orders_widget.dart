import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/features/orders/components/dashed_line.dart';
import 'package:hh_express/features/orders/components/order_info_list_tile.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/modal_sheets.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/models/order_history/order_history_model.dart';
import 'package:hh_express/settings/consts.dart';

class OrderHistoryWidget extends StatelessWidget {
  const OrderHistoryWidget({super.key, this.model});
  final OrderHistoryModel? model;
  @override
  Widget build(BuildContext context) {
    final isLoading = model == null;
    if (isLoading) return _LoadingWidget();
    final theme = context.theme;
    final l10n = context.l10n;

    final List<String> titles = [l10n.orderState, l10n.products, l10n.price];
    final List<String> content = [
      '${model?.statusTrans}',
      '${model?.orders.length} ${l10n.products}',
      '${model?.subTotal} TMT'
    ];
    return GestureDetector(
      onTap: () {
        ModelBottomSheetHelper.doPop();
        appRouter.currentContext.pushNamed(
          AppRoutes.orderDetails.toRouteName,
          queryParameters: {
            'uuid': model!.uuid,
            'order_length': model!.orders.length.toString(),
          },
        ).then((value) {
          //2 index of Order History modal sheet to return modal sheet back
          ModelBottomSheetHelper.showProfileSheets(2);
        });
      },
      child: Container(
        margin: AppPaddings.horiz_16.copyWith(bottom: 16.h),
        decoration: BoxDecoration(
          borderRadius: AppBorderRadiuses.border_6,
          border: Border.all(
            color: AppColors.lightGrey,
            width: 1.5.sp,
          ),
        ),
        padding: AppPaddings.all_16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: SelectableText.rich(
                TextSpan(
                    text: '${l10n.order_code}',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(color: AppColors.darkGrey),
                    children: [
                      TextSpan(
                        text: '${model?.code}',
                        style: theme.textTheme.titleLarge,
                      ),
                    ]),
                style: theme.textTheme.titleLarge,
                maxLines: 1,
              ),
            ),
            Padding(
              padding: AppPaddings.top15_bottom19,
              child: Text(
                '${model?.date}',
                style: theme.textTheme.displaySmall,
              ),
            ),
            DashedLine(
              isLoading: isLoading,
            ),
            for (int i = 0; i < 3; i++)
              OrderInfoListTile(
                title: titles[i],
                content: content[i],
                contentBold: i == 2 ? true : null,
              ),
          ],
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppPaddings.horiz_16.copyWith(bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: AppBorderRadiuses.border_6,
        border: Border.all(
          color: AppColors.lightGrey,
          width: 1.5.sp,
        ),
      ),
      padding: AppPaddings.all_16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150.w,
            child: MyShimerPlaceHolder(
              height: 18.h,
              radius: AppBorderRadiuses.border_4,
            ),
          ),
          Padding(
            padding: AppPaddings.top15_bottom19,
            child: SizedBox(
              width: 115.w,
              child: MyShimerPlaceHolder(
                height: 18.h,
                radius: AppBorderRadiuses.border_4,
              ),
            ),
          ),
          DashedLine(isLoading: true),
          for (int i = 0; i < 3; i++)
            OrderInfoListTile(
              title: null,
              content: null,
              contentBold: i == 2 ? true : null,
            ),
        ],
      ),
    );
  }
}
