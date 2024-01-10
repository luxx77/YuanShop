import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_express/features/address/cubit/address_cubit.dart';
import 'package:hh_express/features/address/view/address_sheet_body.dart';
import 'package:hh_express/features/address/view/address_sheet_title.dart';
import 'package:hh_express/features/cart/cubit/cart_cubit.dart';
import 'package:hh_express/features/components/my_text_button.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/modal_sheets.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';

class AddressReadSheet extends StatelessWidget {
  const AddressReadSheet({
    super.key,
    this.forComplete = false,
    this.instanceUuid,
  });
  final bool forComplete;
  final String? instanceUuid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddressSheetTitle(
          forComplete: forComplete,
        ),
        AppSpacing.vertical_16,
        AddressSheetBody(forComplite: forComplete),
        forComplete
            ? Padding(
                padding: AppPaddings.horiz16_vertic12,
                child: MyDarkTextButton(
                  title: context.l10n.next,
                  onTap: () async {
                    final addressCubit = context.read<AddressCubit>();
                    final selectedIndex = addressCubit.selectedAddresIndex;
                    if (selectedIndex < 0) return;
                    final addressUuid =
                        addressCubit.state.models[selectedIndex].uuid;
                    final cartCubit = context.read<CartCubit>();
                    if (instanceUuid != null) {
                      await cartCubit.completeInstance(
                          instanceUuid!, addressUuid);
                    } else {
                      await cartCubit.complete(addressUuid);
                    }
                    addressCubit.selectedAddresIndex = -1;
                    ModelBottomSheetHelper.doPop();
                  },
                ),
              )
            : AppSpacing.vertical_12
      ],
    ).toSingleChildScrollView;
  }
}
