import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/widgets/pop_leading.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';

class NotificationsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const NotificationsAppBar({
    super.key,
  });
  @override
  Size get preferredSize => Size.fromHeight(52.h);
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      height: 52.h..log(),
      margin: EdgeInsets.only(top: AppSpacing.topPad),
      padding: AppPaddings.horiz_16,
      decoration: BoxDecoration(
        color: theme.appBarTheme.backgroundColor,
        boxShadow: AppColors.appBarShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const PopLeadingIconButton(),
          Center(
            child: Text(
              context.l10n.notifications,
              style: theme.textTheme.titleMedium,
            ),
          ),
          SizedBox(width: 26.sp),
        ],
      ),
    );
  }
}
