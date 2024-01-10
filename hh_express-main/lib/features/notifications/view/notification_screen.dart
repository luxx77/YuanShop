import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/data/local/secured_storage.dart';
import 'package:hh_express/features/categories/view/body.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/features/notifications/cubit/notification_cubit.dart';
import 'package:hh_express/features/notifications/view/notifications_app_bar.dart';
import 'package:hh_express/features/notifications/view/widget.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    final notifCubit = context.read<NotificationCubit>();
    notifCubit.getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifCubit = context.watch<NotificationCubit>();
    return Scaffold(
      appBar: NotificationsAppBar(),
      body: LocalStorage.getToken == null
          ? Center(
              child: Text(context.l10n.unauthorized),
            )
          : notifCubit.state.apiState == APIState.error
              ? CategoryErrorBody(
                  onTap: () => notifCubit.getNotifications(),
                )
              : ListView.builder(
                  itemCount: notifCubit.state.apiState == APIState.loading
                      ? 6
                      : notifCubit.state.notifications?.length,
                  itemBuilder: (context, index) {
                    if (notifCubit.state.apiState == APIState.loading) {
                      return _LoadingWidget();
                    }
                    return NotificationWidget(
                      notif: notifCubit.state.notifications?[index],
                    );
                  },
                ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.horiz16_vertic18,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyShimerPlaceHolder(
            height: 24.sp,
            width: 24.sp,
          ),
          AppSpacing.horizontal_12,
          SizedBox(
            width: 292.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyShimerPlaceHolder(
                  height: 20.h,
                  width: 160.w,
                ),
                Padding(
                    padding: AppPaddings.vertic_8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyShimerPlaceHolder(
                          height: 20.h,
                        ),
                        MyShimerPlaceHolder(
                          height: 20.h,
                          width: 100.w,
                          margin: AppPaddings.top_6,
                        ),
                      ],
                    )),
                MyShimerPlaceHolder(
                  height: 20.h,
                  width: 140.w,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
