import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/settings/consts.dart';

class MyButtonStyle extends ButtonStyle {
  const MyButtonStyle({
    this.myTextStyle,
    super.overlayColor,
  });
  final TextStyle? myTextStyle;
}

class AppTheme {
  static TextStyle titleLargeW600(BuildContext context) => Theme.of(context)
      .textTheme
      .titleLarge!
      .copyWith(fontWeight: FontWeight.w600);
  static TextStyle titleLarge12(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 12.sp);
  static TextStyle titleLarge18(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18.sp);

  static TextStyle lineThroughTitleSmall(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall!.copyWith(
          decoration: TextDecoration.lineThrough, decorationThickness: 2.sp);
  static TextStyle titleMedium16(BuildContext context, {bool? weightless}) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(
          fontSize: 16.sp,
          fontWeight: weightless != null ? FontWeight.w500 : null);
  static TextStyle displayLarge14(BuildContext context) =>
      Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 14.sp);
  static TextStyle titleSmall12(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12.sp);
  static TextStyle displayMedium12(BuildContext context) =>
      Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 12.sp);
  static TextStyle displaySmall12(BuildContext context) =>
      Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 12.sp);
  static TextStyle displayMedium14(BuildContext context) =>
      Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 14.sp);
  static TextStyle titleMedium12(BuildContext context) => Theme.of(context)
      .textTheme
      .titleMedium!
      .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w400);
  static TextStyle titleMedium14(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14.sp);

  static TextStyle bodyMedium10(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 10.sp);
  static TextStyle bodyMedium12(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 12.sp);
  static TextStyle bodyMedium14(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 14.sp,
          );
  static TextStyle bodyLargeW500(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.w500,
          );

  static final lightTheme = ThemeData(
    primaryColor: AppColors.mainOrange,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: AppColors.darkBlue,
    ),
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      color: AppColors.white,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
        color: AppColors.darkBlue,
      ),
    ),
    dialogTheme: DialogTheme(
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.mainOrange,
        fontSize: 12.sp,
      ),
    ),
    fontFamily: GoogleFonts.rubik().fontFamily,
    badgeTheme: BadgeThemeData(
      textColor: AppColors.white,
      backgroundColor: AppColors.mainOrange,
      alignment: Alignment.center,
      padding: EdgeInsets.all(3.5.h),
      textStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 8.sp,
        color: AppColors.white,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.darkBlue,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        height: 4.h,
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: AppColors.darkGrey,
      ),
      border: InputBorder.none,
      errorBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      fillColor: AppColors.lightGrey,
      prefixStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: AppColors.darkBlue,
      ),
      hintStyle: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.darkGrey,
        fontSize: 14.sp,
      ),
    ),
    hintColor: AppColors.darkGrey,
    shadowColor: AppColors.shadowColor,
    checkboxTheme: CheckboxThemeData(
      side: BorderSide(
        color: AppColors.lightGrey,
        width: 2.w,
      ),
      fillColor: MaterialStateColor.resolveWith(
        (states) {
          return states.isNotEmpty && states.last == MaterialState.selected
              ? AppColors.mainOrange
              : AppColors.white;
        },
      ),
      checkColor:
          MaterialStateColor.resolveWith((states) => AppColors.lightGrey),
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadiuses.border_4,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: MyButtonStyle(
        overlayColor: MaterialStateColor.resolveWith(
            (states) => AppColors.mainOrange.withOpacity(.15)),
        myTextStyle: TextStyle(
          fontSize: 12.sp,
          color: AppColors.mainOrange,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: AppColors.darkGrey.colorSolve,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.mainOrange,
      selectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 10.h,
        color: AppColors.mainOrange,
      ),
      unselectedLabelStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 10.h,
        color: AppColors.darkGrey,
      ),
      unselectedItemColor: AppColors.darkGrey,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 70.sp,
        color: AppColors.white,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 20.sp,
        color: AppColors.white,
      ),
      displaySmall: TextStyle(
        color: AppColors.darkGrey,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        color: AppColors.white,
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: TextStyle(
        color: AppColors.white,
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.sp,
        color: AppColors.darkBlue,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: AppColors.darkGrey,
      ),
      titleLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.darkBlue,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.darkBlue,
      ),
      bodyLarge: TextStyle(
        color: AppColors.mainOrange,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      ),
      bodySmall: TextStyle(
        color: AppColors.mainOrange,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.underline,
      ),
      labelMedium: TextStyle(
        fontSize: 14.sp,
        color: AppColors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
