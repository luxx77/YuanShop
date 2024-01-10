import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/cart/cubit/cart_cubit.dart';
import 'package:hh_express/features/components/my_text_button.dart';
import 'package:hh_express/features/components/widgets/nav_bar_body.dart';
import 'package:hh_express/features/product_details/bloc/product_details_bloc.dart';
import 'package:hh_express/features/product_details/components/counter_button.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/modal_sheets.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/models/cart/cart_update/cart_update_model.dart';
import 'package:hh_express/settings/enums.dart';

class ProdDetailsBottomBar extends StatefulWidget {
  const ProdDetailsBottomBar({
    super.key,
    required this.id,
  });
  final int id;

  @override
  State<ProdDetailsBottomBar> createState() => _ProdDetailsBottomBarState();
}

class _ProdDetailsBottomBarState extends State<ProdDetailsBottomBar> {
  int quantity = 0;
  late final prodBloc = context.read<ProductDetailsBloc>();
  late final cartCubit = context.read<CartCubit>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        if (state.state != ProdDetailsAPIState.success)
          return Container(
            height: 72.h,
            color: Colors.transparent,
          );
        return NavBarBody(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MyDarkTextButton(
                  title: l10n.buy,
                  onTap: () {
                    if (prodBloc.isUnauthorized() ||
                        prodBloc.isNotAllPropsSelected()) return;
                    ModelBottomSheetHelper.showBuyProd(prodBloc.getUpdateModel);
                    return;
                  },
                ),
              ),
              AppSpacing.horizontal_16,
              Expanded(
                child: CounterButton(
                  quantity: quantity,
                  title: l10n.addToCart,
                  onAdd: () async {
                    if (prodBloc.isUnauthorized() ||
                        prodBloc.isNotAllPropsSelected()) return;
                    final updated = await cartCubit.cartUpdate(
                      CartUpdateModel(
                        productId: widget.id,
                        properties: state.selectedProps.values.toList(),
                        quantity: quantity + 1,
                      ),
                    );
                    if (updated) {
                      quantity++;
                      setState(() {});
                    }
                  },
                  onRemove: () async {
                    final updated = await cartCubit.cartUpdate(
                      CartUpdateModel(
                        productId: widget.id,
                        properties: state.selectedProps.values.toList(),
                        quantity: quantity - 1,
                      ),
                    );
                    if (updated) {
                      quantity--;
                      setState(() {});
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
