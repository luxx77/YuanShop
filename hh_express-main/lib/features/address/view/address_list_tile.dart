import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/profile/components/selected_indicator.dart';
import 'package:hh_express/helpers/modal_sheets.dart';
import 'package:hh_express/models/addres/address_model.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class AddressListTile extends StatelessWidget {
  const AddressListTile({
    super.key,
    required this.model,
    required this.isSelected,
    required this.forComplite,
    required this.onTap,
  });
  final AddressModel model;
  final bool? isSelected;
  final bool forComplite;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: AppPaddings.horiz_16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // AppSpacing.horizontal_16,
            Expanded(
              child: Text(
                model.address,
                style: AppTheme.bodyMedium14(context),
                textAlign: TextAlign.start,
              ),
            ),
            forComplite
                ? SheetListTileSelectedIndicator(
                    isSelected: isSelected ?? false,
                  )
                : Material(
                    color: Colors.transparent,
                    borderRadius: AppBorderRadiuses.border_50,
                    child: InkWell(
                      borderRadius: AppBorderRadiuses.border_50,
                      onTap: () async {
                        ModelBottomSheetHelper.doPop();
                        await ModelBottomSheetHelper.showAddressUpdateSheet(
                            model);

                        /// 1 index of it self to return addres sheet back
                        ModelBottomSheetHelper.showProfileSheets(1);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        height: 20.sp,
                        width: 20.sp,
                        alignment: Alignment.center,
                        margin: AppPaddings.all_12,
                        child: FittedBox(
                          child: Icon(
                            Icons.edit_note_sharp,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

// class UpdatePopupButton extends StatefulWidget {
//   const UpdatePopupButton({super.key, required this.model});
//   final AddressModel model;
//   @override
//   State<UpdatePopupButton> createState() => _UpdatePopupButtonState();
// }

// class _UpdatePopupButtonState extends State<UpdatePopupButton> {
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton(
//       child: 
//       color: AppColors.mediumGrey,
//       padding: EdgeInsets.zero,
//       itemBuilder: (context) {
//         return [
//           PopupMenuItem(
//             padding: AppPaddings.horiz10_vertic5,
//             height: 0,
//             textStyle: AppTheme.bodyMedium14(context),
//             onTap: () {
//             },
//             child: Row(
//               children: [
//                 Text(
//                   'update',
//                 ),
//                 AppSpacing.horizontal_4,
//               ],
//             ),
//           ),
//         ];
//       },
//     );
//   }
// }
