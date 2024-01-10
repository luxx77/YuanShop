import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/settings/consts.dart';

class ProdDetailsImagePlaceHolder extends StatelessWidget {
  const ProdDetailsImagePlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.grey.withOpacity(0.1),
      child: Text(
        AssetsPath.appTitle,
        style: TextStyle(
          fontSize: 25.sp,
          color: Colors.black26,
        ),
      ),
    );
  }
}
