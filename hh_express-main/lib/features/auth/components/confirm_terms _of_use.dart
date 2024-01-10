import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/auth/bloc/auth_bloc.dart';
import 'package:hh_express/helpers/confirm_exit.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';

class TermsOfUseWidget extends StatefulWidget {
  TermsOfUseWidget({super.key});
  @override
  State<TermsOfUseWidget> createState() => _TermsOfUseWidgetState();
}

class _TermsOfUseWidgetState extends State<TermsOfUseWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<AuthBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1.3,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Checkbox(
                value: state.termsConfirmed,
                onChanged: (value) {
                  bloc.confirmTerms(value ?? false);
                  setState(() {});
                },
              );
            },
          ),
        ),
        AppSpacing.horizontal_4,
        Text.rich(
          TextSpan(
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
            children: [
              TextSpan(
                text: (context.l10n.termsAccept.split(' ')..removeLast())
                        .join(' ') +
                    ' ',
              ),
              TextSpan(
                text: (context.l10n.termsAccept.split(' ').last),
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    Confirm.confirmTerms(context);
                  },
                style: TextStyle(
                    color: AppColors.mainOrange,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationThickness: 1.5.h,
                    fontSize: 14.sp),
              )
            ],
          ),
        )
      ],
    );
  }
}
