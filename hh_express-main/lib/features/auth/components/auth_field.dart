import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class AuthField extends StatefulWidget {
  const AuthField({
    super.key,
    required this.controller,
    required this.label,
    required this.keyboardType,
  });
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  final border = OutlineInputBorder(
      borderRadius: AppBorderRadiuses.border_6, borderSide: BorderSide.none);

  bool? passWordShown;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = context.l10n;
    final hasPrefix = widget.label == l10n.phoneNumber;
    final forPassWord = widget.label == l10n.password;
    if (passWordShown == null) {
      passWordShown = forPassWord;
    }

    return Container(
      height: 48.h,
      alignment: Alignment.center,
      margin: AppPaddings.horiz_16.copyWith(bottom: 30.h),
      child: TextField(
        focusNode: FocusNode(),
        controller: widget.controller,
        autocorrect: false,
        buildCounter: (context,
            {currentLength = 0, isFocused = false, maxLength = 5}) {
          return null;
        },
        style: AppTheme.titleMedium12(context),
        keyboardType: widget.keyboardType,
        maxLength: hasPrefix ? 8 : null,
        obscureText: passWordShown!,
        decoration: InputDecoration(
          prefixText: hasPrefix ? '+993 ' : null,
          suffix: forPassWord
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      passWordShown = !passWordShown!;
                    });
                  },
                  child: Icon(passWordShown!
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined),
                )
              : null,
          contentPadding: AppPaddings.horiz_10,
          filled: true,
          labelText: widget.label,
          fillColor: theme.inputDecorationTheme.fillColor,
          focusColor: theme.inputDecorationTheme.fillColor,
          border: border,
          enabledBorder: border,
          focusedBorder: border,
        ),
        cursorColor: AppColors.mainOrange,
      ),
    );
  }
}

void some() {
  const roswen = 'Rowsen';
  const akge = 'Akga';
  const input = 'input';
  final map = {roswen: 'musurDal', akge: 'musur'};

  print(map[input]);
}
