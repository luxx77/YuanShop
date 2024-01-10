import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hh_express/features/home/view/components/search_field.dart';
import 'package:hh_express/features/components/widgets/svg_icons.dart';
import 'package:hh_express/features/mainScreen/view/components/navBar/nav_bar.dart';
import 'package:hh_express/features/notifications/cubit/notification_cubit.dart';
import 'package:hh_express/features/notifications/cubit/notification_state.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/modal_sheets.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(52.h);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = context.l10n;
    final titles = [
      l10n.home,
      l10n.video,
      l10n.category,
      l10n.cart,
      l10n.profile,
    ];
    return ValueListenableBuilder(
      valueListenable: bodyIndex,
      builder: (context, index, child) {
        return Container(
          margin: EdgeInsets.only(top: AppSpacing.topPad),
          height: 52.h,
          padding: AppPaddings.horiz_8,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            boxShadow: AppColors.appBarShadow,
            color: AppColors.white,
          ),
          child: index == 3
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(titles[index], style: textTheme.titleMedium),
                    SizedBox(
                      height: 30.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          MyImageIcon(
                            path: AssetsPath.bellIcon,
                            contSize: 24.sp,
                            iconSize: 19.2.sp,
                            onTap: () {
                              appRouter.currentContext
                                  .push(AppRoutes.notifications);
                            },
                          ),
                          BlocBuilder<NotificationCubit, NotificationState>(
                            builder: (context, state) {
                              return state.newNotificationsCount == 0
                                  ? SizedBox()
                                  : Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        height: 20.h,
                                        padding: EdgeInsets.all(3.sp),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: FittedBox(
                                            child: Text(
                                          '${state.newNotificationsCount}',
                                          style: context
                                              .theme.textTheme.displaySmall!
                                              .copyWith(
                                            color: Colors.white,
                                          ),
                                        )),
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : index != 0
                  ? Text(titles[index], style: textTheme.titleMedium)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: HomeSearchFieldDummy()),
                        Padding(
                          padding: AppPaddings.left_12,
                          child: MyImageIcon(
                            path: AssetsPath.filterIcon,
                            iconSize: 20.8.sp,
                            onTap: () =>
                                ModelBottomSheetHelper.showFilterSheet(),
                          ),
                        ),
                        IconButton(
                            splashRadius: 1,
                            splashColor: Colors.transparent,
                            iconSize: 22.sp,
                            onPressed: () {
                              appRouter.currentContext.push(AppRoutes.chat);
                            },
                            icon: Icon(Icons.chat))
                      ],
                    ),
        );
      },
    );
  }
}
