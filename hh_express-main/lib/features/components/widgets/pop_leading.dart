import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/routes.dart';

class PopLeadingIconButton extends StatelessWidget {
  const PopLeadingIconButton({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return GestureDetector(
      onTap: () {
        appRouter.currentContext.pop();
      },
      child: Container(
        height: double.infinity,
        width: 26.sp,
        alignment: Alignment.center,
        child: FittedBox(
          child: Icon(
            Icons.arrow_back_rounded,
            color: theme.iconTheme.color,
          ),
        ),
      ),
    );
  }
}
