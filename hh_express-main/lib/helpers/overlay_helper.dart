import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';
import 'package:another_flushbar/flushbar.dart';

class OverlayHelper {
  static OverlayEntry? _entry;

  static remove() {
    _entry?.remove();
  }

  static Future<void> showLoading() async {
    var ovv = Overlay.of(appRouter.currentContext);
    _entry = OverlayEntry(
      builder: (context) {
        return Scaffold(
          backgroundColor: AppColors.black.withOpacity(.5),
          body: Container(
            decoration: BoxDecoration(
              borderRadius: AppBorderRadiuses.border_6,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                ),
                GestureDetector(
                  onTap: () {
                    'GestureTap'.log();
                  },
                  child: Text(
                    context.l10n.loading,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                AppSpacing.vertical_10,
                CircularProgressIndicator(
                  color: AppColors.appOrange,
                )
              ],
            ),
          ),
        );
      },
    );
    ovv.insert(_entry!);
  }
}

class SnackBarHelper {
  static SnackBar _snackBar(String message) {
    final needMargin = appRouter.location == AppRoutes.mainScreen;
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      margin: needMargin ? EdgeInsets.only(bottom: 60.h) : EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
        ),
        padding: AppPaddings.all_12,
        child: Text(message),
      ),
    );
  }

  static void showTopSnack(String message, APIState state, {String? title}) {
    final context = appRouter.currentContext;
    topFlush(message, state, title: title).show(context);
  }

  static void showMessageSnack(String message) {
    final context = appRouter.currentContext;
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(_snackBar(message));
  }

  static Flushbar topFlush(String message, APIState state, {String? title}) {
    return Flushbar(
      margin: AppPaddings.all_12..add(AppPaddings.top_6),
      borderRadius: AppBorderRadiuses.border_8,
      flushbarPosition: FlushbarPosition.TOP,
      
      title: title,
      animationDuration: AppDurations.duration_500ms,
      duration: Duration(seconds: 2),
      messageText: Text(
        message,
        maxLines: 2,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black,
    );
  }
}
