import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/features/favors/components/favors_widget.dart';
import 'package:hh_express/features/orders/view/details/orderInfo/order_info_widget.dart';
import 'package:hh_express/features/orders/view/details/orderStateWidget/order_state_widget.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/modal_sheets.dart';
import 'package:hh_express/models/cart/cart_model/cart_model.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({super.key, this.model, required this.orderLength});
  final CartModel? model;
  final int orderLength;
  @override
  Widget build(BuildContext context) {
    final isLoading = model == null;
    if (isLoading) return _LoadingBody(orderLength);
    final titlesTheme = AppTheme.titleMedium16(context);
    return ListView.custom(
      childrenDelegate: SliverChildListDelegate(
        [
          OrderStateWidget(
            models: model!.stateHistory,
          ),
          Padding(
            padding: AppPaddings.left_18.copyWith(bottom: 12.h),
            child: Text(
              context.l10n.products,
              style: titlesTheme,
            ),
          ),
          ...model!.orders
              .map(
                (e) => FavorsWidget(
                  model: e.product,
                  onWidgetTap: () {
                    ModelBottomSheetHelper.showOrderDetails(e);
                  },
                ),
              )
              .toList(),
          Padding(
            padding: AppPaddings.left_18,
            child: Text(
              'Gelmeli wagty',
              style: titlesTheme,
            ),
          ),
          OrderInfoWidget(model: model)
        ],
      ),
    );
  }
}

class _LoadingBody extends StatelessWidget {
  const _LoadingBody(this.length);
  final int length;
  @override
  Widget build(BuildContext context) {
    return ListView.custom(
      childrenDelegate: SliverChildListDelegate(
        [
          const OrderStateWidget(),
          Padding(
            padding: AppPaddings.left_18.copyWith(bottom: 12.h),
            child: MyShimerPlaceHolder(
              height: 23.h,
              margin: EdgeInsets.only(right: 260.w),
              width: 25.w,
              radius: AppBorderRadiuses.border_4,
            ),
          ),
          ...List.generate(
            length,
            (index) => FavorsWidget(),
          ),
          Padding(
            padding: AppPaddings.left_18,
            child: MyShimerPlaceHolder(
              height: 23.h,
              margin: EdgeInsets.only(right: 260.w),
              width: 25.w,
              radius: AppBorderRadiuses.border_4,
            ),
          ),
          const OrderInfoWidget()
        ],
      ),
    );
  }
}
