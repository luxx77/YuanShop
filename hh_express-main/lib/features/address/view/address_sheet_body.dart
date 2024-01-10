import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/address/cubit/address_cubit.dart';
import 'package:hh_express/features/address/view/address_list_tile.dart';
import 'package:hh_express/features/categories/view/body.dart';
import 'package:hh_express/features/product_details/view/product_details_body.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';
import 'package:hh_express/settings/theme.dart';

class AddressSheetBody extends StatefulWidget {
  const AddressSheetBody({super.key, required this.forComplite});
  final bool forComplite;
  @override
  State<AddressSheetBody> createState() => _AddressSheetBodyState();
}

class _AddressSheetBodyState extends State<AddressSheetBody> {
  late final cubit = context.read<AddressCubit>();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200.h,
      child: BlocBuilder<AddressCubit, AddressState>(
        bloc: cubit,
        builder: (context, state) {
          if (state.state == AddressApiState.init) return SizedBox();
          if (state.state == AddressApiState.error)
            return CategoryErrorBody(
              onTap: () {
                cubit.init();
              },
            );
          if (state.state == AddressApiState.loading) return CenterLoading();
          if (state.state == AddressApiState.unAuthorized)
            return _centerText(context.l10n.unauthorized);
          if (state.models.isEmpty) return _centerText(context.l10n.empty);

          return ListView.builder(
            padding: AppPaddings.bottom_10,
            itemCount: state.models.length,
            itemBuilder: (context, index) {
              return AddressListTile(
                onTap: () {
                  if (!widget.forComplite) return;
                  cubit.selectedAddresIndex = index;
                  setState(() {});
                },
                forComplite: widget.forComplite,
                isSelected: index == cubit.selectedAddresIndex,
                model: state.models[index],
              );
            },
          );
        },
      ),
    );
  }
}

Widget _centerText(String message) {
  return Builder(builder: (context) {
    return Center(
      child: Text(
        message,
        style: AppTheme.bodyMedium14(context),
      ),
    );
  });
}
