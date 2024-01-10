import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/mainScreen/view/components/navBar/cart_icon.dart';
import 'package:hh_express/features/components/widgets/svg_icons.dart';
import 'package:hh_express/features/notifications/cubit/notification_cubit.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/settings/consts.dart';

final bodyIndex = ValueNotifier<int>(0);

class MyNavBar extends StatelessWidget {
  const MyNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).bottomNavigationBarTheme;
    final l10n = context.l10n;
    final navBarTitles = [
      l10n.home,
      l10n.video,
      l10n.category,
      l10n.cart,
      l10n.profile,
    ];
    return Container(
      width: double.maxFinite,
      height: 55.h,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppColors.navBarShaow,
      ),
      child: Row(
        children: List.generate(
          navBarTitles.length,
          (index) => index == 3
              ? CartIcon(
                  onTap: () {
                    final notifCubit = context.read<NotificationCubit>();
                    notifCubit.getNotificationsCount();
                    bodyIndex.value = index;
                  },
                )
              : InkWell(
                  onTap: () {
                    bodyIndex.value = index;
                  },
                  child: SizedBox(
                    height: 72.h,
                    width: 72.w,
                    child: Align(
                      alignment: Alignment.center,
                      child: ValueListenableBuilder(
                        valueListenable: bodyIndex,
                        builder: (context, bodyIndex, child) {
                          final isSelected = bodyIndex == index;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MyImageIcon(
                                path: AssetsPath.navBarIcons[index],
                                color: isSelected
                                    ? theme.selectedItemColor
                                    : theme.unselectedItemColor,
                                iconSize: 18.h,
                                contSize: 18.h,
                              ),
                              Text(
                                navBarTitles[index],
                                style: isSelected
                                    ? theme.selectedLabelStyle
                                    : theme.unselectedLabelStyle,
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
