import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_express/features/components/my_text_button.dart';
import 'package:hh_express/features/components/widgets/nav_bar_body.dart';
import 'package:hh_express/features/direct_order/cubit/direct_order_cubit.dart';
import 'package:hh_express/features/product_details/components/counter_button.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/modal_sheets.dart';
import 'package:hh_express/helpers/spacers.dart';

class BuyProdBottomBar extends StatelessWidget {
  const BuyProdBottomBar({super.key, required this.quantity});
  final int quantity;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<DirectOrderCubit>();
    return NavBarBody(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CounterButton(
              quantity: quantity,
              title: 'no title',
              onAdd: () {
                cubit.updateQuantity(quantity + 1);
              },
              onRemove: () {
                if (quantity == 1) {
                  ModelBottomSheetHelper.doPop();
                  return;
                }
                cubit.updateQuantity(quantity - 1);
              },
            ),
          ),
          AppSpacing.horizontal_16,
          Expanded(
            child: MyDarkTextButton(
              title: l10n.buy,
              onTap: () async {
                ModelBottomSheetHelper.doPop();
                ModelBottomSheetHelper.showAddressSelecSheet(
                    instanceUuid: cubit.state.cartModel!.uuid);
              },
            ),
          ),
        ],
      ),
    );
  }
}
