import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hh_express/app/app.dart';
import 'package:hh_express/app/setup.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/settings/consts.dart';

void main() async {
  configureDependencies(getIt);

  final mySystemTheme = SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark);

  SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
  runZonedGuarded(() async {
    await WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return runApp(const MyApp());
  }, (error, stack) {
    'RunZoneError \nerror:${error}\nstackTrace:$stack'.log();
    // Restart.restartApp();
    exit(0);
  });
}
