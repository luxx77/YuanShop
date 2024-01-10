import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hh_express/features/cart/view/cart_body.dart';
import 'package:hh_express/features/categories/view/body.dart';
import 'package:hh_express/features/home/view/body.dart';
import 'package:hh_express/features/mainScreen/view/components/main_app_bar.dart';
import 'package:hh_express/features/mainScreen/view/components/navBar/nav_bar.dart';
import 'package:hh_express/features/profile/view/profile_body.dart';
import 'package:hh_express/features/video/view/home_video.dart';
import 'package:hh_express/helpers/confirm_exit.dart';
import 'package:hh_express/helpers/modal_sheets.dart';
import 'dart:developer';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  static final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: Colors.white));
    super.initState();
  }

  List<Widget>? get bodies => [
        HomeScreen(),
        HomeVideos(),
        CategoryBody(),
        CartScreen(),
        ProfileBody(),
      ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final val = ModelBottomSheetHelper.doPop();
        if (!val) {
          return false;
        }
        if (!Confirm.doPop()) {
          return false;
        }
        log('pop Scoup');
        final exit = await Confirm.confirmExit(context);
        return exit;
      },
      child: Scaffold(
        key: MainScreen.scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: MainAppBar(),
        body: ValueListenableBuilder(
          valueListenable: bodyIndex,
          builder: (contetx, val, child) {
            return bodies![val];
          },
        ),
        bottomNavigationBar: const MyNavBar(),
      ),
    );
  }
}
