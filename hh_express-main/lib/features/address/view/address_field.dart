import 'package:flutter/material.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/address/cubit/address_cubit.dart';
import 'package:hh_express/features/auth/components/auth_field.dart';
import 'package:hh_express/features/components/my_text_button.dart';
import 'package:hh_express/features/components/widgets/sheet_titles.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/overlay_helper.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/models/addres/address_model.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';
import 'package:hh_express/settings/theme.dart';

class AddressField extends StatefulWidget {
  const AddressField({super.key, required this.model});
  final AddressModel? model;
  @override
  State<AddressField> createState() => _AddressFieldState();
}

class _AddressFieldState extends State<AddressField> {
  @override
  void initState() {
    if (widget.model != null) {
      final splittedList = List.from(widget.model!.address.split(' '));
      theWelayat =
          widget.model != null ? splittedList.last : context.l10n.ashgabat;
      splittedList.removeLast();
      controller.text = splittedList.join(' ');
    }

    super.initState();
  }

  late final controller = TextEditingController();
  late final cubit = context.read<AddressCubit>();
  final _key = GlobalKey();
  double kbHeight = 0;

  late String theWelayat = context.l10n.ashgabat;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return KeyboardSizeProvider(
      smallSize: 400,
      child: Column(
        children: [
          BottomSheetTitle(
            title: l10n.address,
            isPadded: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AuthField(
                  keyboardType: TextInputType.text,
                  label: l10n.address,
                  controller: controller,
                ),
              ),
              Padding(
                padding: AppPaddings.horiz_10.copyWith(bottom: 30.h),
                child: Material(
                  color: AppColors.lightGrey,
                  borderRadius: AppBorderRadiuses.border_6,
                  child: InkWell(
                    borderRadius: AppBorderRadiuses.border_6,
                    onTap: () async {
                      await showWelayatSelector(_key.currentContext!, kbHeight,
                          (val) => theWelayat = val);
                      setState(() {});
                    },
                    child: Container(
                      key: _key,
                      padding:
                          EdgeInsets.symmetric(vertical: 15.h, horizontal: 5.w),
                      height: 48.h,
                      width: 90.w,
                      decoration: BoxDecoration(
                        borderRadius: AppBorderRadiuses.border_6,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: FittedBox(
                              child: Text(
                                theWelayat,
                                style: AppTheme.titleMedium12(context),
                              ),
                            ),
                          ),
                          AppSpacing.horizontal_4,
                          Icon(
                            Icons.keyboard_arrow_down_sharp,
                            color: AppColors.darkBlue,
                            size: 18.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: AppPaddings.horiz_16.copyWith(bottom: 16.h, top: 10.h),
            child: MyDarkTextButton(
              title: l10n.save,
              onTap: () async {
                final model = widget.model;
                if (controller.text.length < 5) {
                  SnackBarHelper.showTopSnack(
                      'Address Must be at least 5 letters', APIState.error);
                  return;
                }
                if (model == null) {
                  final data =
                      await cubit.create('${controller.text}. $theWelayat');
                } else {
                  final data = await cubit
                      .update(model.update('${controller.text}. $theWelayat'));
                }
                Navigator.pop(context);
              },
            ),
          ),
          Consumer<ScreenHeight>(
            builder: (context, value, child) {
              kbHeight = value.keyboardHeight;
              return SizedBox(
                height: value.keyboardHeight,
              );
            },
          ),
        ],
      ),
    ).toSingleChildScrollView;
  }
}

Future<void> showWelayatSelector(
    BuildContext context, double kbHeight, onSelect<String> onSelect) async {
  final mqWidth = MediaQuery.sizeOf(context);
  final position =
      (context.findRenderObject() as RenderBox).localToGlobal(Offset.zero);
  final l10n = context.l10n;
  final welayats = [
    l10n.ashgabat,
    l10n.ahal,
    l10n.mary,
    l10n.lebap,
    l10n.dasoguz,
  ];
  return await showMenu<void>(
      context: context,
      position: RelativeRect.fromLTRB(position.dx,
          kbHeight == 0 ? position.dy : kbHeight, mqWidth.width, 0),
      items: welayats
          .map(
            (e) => PopupMenuItem(
              textStyle: AppTheme.titleMedium12(context),
              value: e,
              onTap: () => onSelect(e),
              child: Text(e),
            ),
          )
          .toList());
}

typedef onSelect<T> = T Function(T val);
