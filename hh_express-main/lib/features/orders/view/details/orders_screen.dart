import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_express/features/categories/view/body.dart';
import 'package:hh_express/features/orders/view/cubit/order_details_cubit.dart';
import 'package:hh_express/features/orders/view/details/orders_app_bar.dart';
import 'package:hh_express/features/orders/view/details/order_details_body.dart';
import 'package:hh_express/helpers/modal_sheets.dart';
import 'package:hh_express/settings/enums.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
    required this.ordersLength,
    required this.uuid,
  });
  final String uuid;
  final int ordersLength;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderDetailsCubit()..init(uuid),
      child: WillPopScope(
        onWillPop: () async {
          return ModelBottomSheetHelper.doPop();
        },
        child: Scaffold(
          appBar: const OrderDetailsAppBar(),
          body: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
            builder: (context, state) {
              final apiState = state.apiState;
              if (apiState == APIState.init) return SizedBox();
              if (apiState == APIState.error) return CategoryErrorBody();
              return OrderDetailsBody(
                orderLength: ordersLength,
                model: state.model,
              );
            },
          ),
        ),
      ),
    );
  }
}
