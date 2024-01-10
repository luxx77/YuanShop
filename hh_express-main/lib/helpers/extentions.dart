import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'dart:developer' as devtools show log;

import 'package:hh_express/helpers/routes.dart';

extension Log on Object? {
  void log({StackTrace? stackTrace, String? message}) {
    if (this is double) {
      devtools.log(appRouter.location);
    }
    devtools.log(
      '${this.toString()} ${message ?? ''}',
      stackTrace: stackTrace,
    );
  }
}

extension SliverExtentions on Widget {
  SliverToBoxAdapter toSliver() => SliverToBoxAdapter(child: this);
  void logCon(String name) async {
    '${DateTime.now()} $name'.log();
  }
}

extension L10n on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  ThemeData get theme => Theme.of(this);
}

extension FromStringtoInt on String {
  int get toInt => int.parse(this);
  String get toRouteName => replaceAll('/', '');
}

extension MaterialResolve on Color {
  MaterialStateColor get colorSolve =>
      MaterialStateColor.resolveWith((states) => this);
}

extension ToSliverBox on Widget {
  SliverToBoxAdapter get toSliverBox => SliverToBoxAdapter(child: this);
  SingleChildScrollView get toSingleChildScrollView => SingleChildScrollView(
        child: this,
      );
}

extension GetNavContext on GoRouter {
  BuildContext get currentContext =>
      routerDelegate.navigatorKey.currentContext!;
}

extension DurationExtensions on Duration {
  String get toTime {
    final formattedVal = this.toString().split('.').first;
    final data = formattedVal.split(':');
    if (data.first.toInt == 0) data.removeAt(0);

    return data.join(':');
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

typedef void OnWidgetSizeChange(Size size);
