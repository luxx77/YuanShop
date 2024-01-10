import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/widgets/pop_leading.dart';
import 'package:hh_express/features/components/widgets/svg_icons.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/modal_sheets.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';

class ProductsByCategoryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProductsByCategoryAppBar({super.key});
  @override
  Size get preferredSize => Size.fromHeight(52.h);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 52.h,
      margin: EdgeInsets.only(top: AppSpacing.topPad),
      padding: AppPaddings.horiz_16,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        boxShadow: AppColors.appBarShadow,
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const PopLeadingIconButton(),
          Text(
            context.l10n.category,
            style: theme.textTheme.titleMedium,
          ),
          MyImageIcon(
            path: AssetsPath.filterIcon,
            contSize: 26.sp,
            iconSize: 19.sp,
            onTap: () {
              ModelBottomSheetHelper.showFilterSheet();
            },
          ),
        ],
      ),
    );
  }
}
