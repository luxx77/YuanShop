import 'package:flutter/material.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class MyDarkTextButton extends StatelessWidget {
  const MyDarkTextButton({
    super.key,
    required this.title,
    this.onTap,
    this.width,
    this.padding,
    this.child,
  });
  final String title;
  final double? width;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorderRadiuses.border_6,
      child: Material(
        color: AppColors.darkBlue,
        textStyle: AppTheme.displayLarge14(context),
        child: InkWell(
          onTap: onTap,
          child: Container(
        
            padding: padding ?? AppPaddings.vertic_15,
            alignment: Alignment.center,
            width: width,
            child: child ??
                FittedBox(
                  child: Text(
                    title,
                    style: context.theme.textTheme.labelMedium,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
