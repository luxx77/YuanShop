import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hh_express/features/address/addres_read_sheet.dart';
import 'package:hh_express/features/address/view/address_field.dart';
import 'package:hh_express/features/chat/bloc/chat_bloc.dart';
import 'package:hh_express/features/chat/bloc/chat_events.dart';
import 'package:hh_express/features/direct_order/cubit/direct_order_cubit.dart';
import 'package:hh_express/features/direct_order/view/direct_order_body.dart';
import 'package:hh_express/features/favors/view/favors_body.dart';
import 'package:hh_express/features/filter/components/sheet_body.dart';
import 'package:hh_express/features/order_history/view/screens/orders_sheet_body.dart';
import 'package:hh_express/features/product_details/view/modalSheet/product_modal_body.dart';
import 'package:hh_express/features/profile/view/sheets/change_lang_sheet.dart';
import 'package:hh_express/features/video/sim_prods/sim_prods_sheet.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/models/addres/address_model.dart';
import 'package:hh_express/models/cart/cart_order_model/cart_order_model.dart';
import 'package:hh_express/models/cart/cart_update/cart_update_model.dart';
import 'package:image_picker/image_picker.dart';

class ModelBottomSheetHelper {
  static bool _sheetShown = false;
  static BuildContext? _currentContext;

  /// this fuck pops ModalSheet if its shown and return value for WillPopScoup Widget
  static bool doPop() {
    if (_sheetShown) {
      Navigator.pop(_currentContext!);
      return false;
    }
    return true;
  }

  static Future<void> showFilterSheet() async {
    _sheetShown = true;
    await showModalBottomSheet(
      context: appRouter.currentContext,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      builder: (context) {
        _currentContext = context;
        return const FilterSheetBody();
      },
    );
    _sheetShown = false;
  }

  static Future<void> showLangSheet() async {
    _sheetShown = true;
    await showModalBottomSheet(
      context: appRouter.currentContext,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      builder: (context) {
        _currentContext = context;
        return const ChangeLangSheet();
      },
    );

    _sheetShown = false;
  }

  static Future<void> showBuyProd(CartUpdateModel model) async {
    _sheetShown = true;
    await showModalBottomSheet(
      context: appRouter.currentContext,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      builder: (context) {
        _currentContext = context;
        return BlocProvider(
          create: (context) => DirectOrderCubit()..init(model),
          child: DirectOrderSheetBody(model: model),
        );
      },
    );

    _sheetShown = false;
  }

  static Future<void> showOrderDetails(CartOrderModel model) async {
    _sheetShown = true;
    await showModalBottomSheet(
      context: appRouter.currentContext,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      builder: (context) {
        _currentContext = context;
        return SizedBox(height: 700.h, child: BuyProdSheetBody(model: model));
      },
    );
    _sheetShown = false;
  }

  static Future<void> showProfileSheets(int index) async {
    List<Widget> _profileSheets = [
      SizedBox(),
      AddressReadSheet(),
      OrdersSheetBody(),
      FavorsBody(),
      ChangeLangSheet(),
    ];
    await showModalBottomSheet(
      context: appRouter.currentContext,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      builder: (context) {
        _sheetShown = true;
        _currentContext = context;
        return _profileSheets[index];
      },
    );
    _sheetShown = false;
  }

  static Future<void> showAddressSelecSheet({String? instanceUuid}) async {
    final context = appRouter.currentContext;
    await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      builder: (context) {
        _sheetShown = true;
        _currentContext = context;
        return AddressReadSheet(
          instanceUuid: instanceUuid,
          forComplete: true,
        );
      },
    );
    _sheetShown = false;
  }

  static Future<void> showAddressUpdateSheet(AddressModel? model) async {
    final context = appRouter.currentContext;
    await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      builder: (context) {
        _sheetShown = true;
        _currentContext = context;
        return AddressField(
          model: model,
        );
      },
    );
    _sheetShown = false;
  }

  static Future<void> showCameraOrGallerySelector(BuildContext context) async {
    final bloc = BlocProvider.of<ChatBloc>(context);
    bool? isFromCamera;
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            10,
          ),
        ),
      ),
      context: context,
      builder: (ctx) {
        _sheetShown = true;
        return Container(
          padding: EdgeInsets.all(20.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                padding: EdgeInsets.all(5.sp),
                child: IconButton(
                  onPressed: () async {
                    isFromCamera = true;
                    Navigator.of(ctx).pop();
                  },
                  icon: Icon(
                    Icons.camera_outlined,
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
                child: VerticalDivider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                padding: EdgeInsets.all(5.sp),
                child: IconButton(
                  onPressed: () async {
                    isFromCamera = false;
                    Navigator.of(ctx).pop();
                  },
                  icon: Icon(
                    Icons.image_outlined,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    if (isFromCamera != null) {
      final image = await ImagePicker().pickImage(
        source: isFromCamera! ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50,
      );
      if (image != null) {
        bloc.add(
          SendMessageEvent(
            file: image,
          ),
        );
        if (appRouter.location != AppRoutes.chat) {
          context.push(AppRoutes.chat);
        }
      }
    }
    _sheetShown = false;
    HapticFeedback.vibrate();
  }

  static Future<void> showVideoSimmilarProds(String slug, int id) async {
    _sheetShown = true;
    await showModalBottomSheet(
      context: appRouter.currentContext,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.r),
          topRight: Radius.circular(10.r),
        ),
      ),
      builder: (ctx) {
        _currentContext = ctx;
        return VideoSimmilarProdsSheet(slug, id);
      },
    );
    _sheetShown = false;
  }
}
