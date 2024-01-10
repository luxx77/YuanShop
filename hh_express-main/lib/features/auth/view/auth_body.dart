import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hh_express/features/auth/bloc/auth_bloc.dart';
import 'package:hh_express/features/auth/components/auth_field.dart';
import 'package:hh_express/features/auth/components/confirm_terms%20_of_use.dart';
import 'package:hh_express/features/components/my_text_button.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/models/auth/auth_model.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class AuthBody extends StatefulWidget {
  const AuthBody({super.key, required this.forSingUp});
  final bool forSingUp;

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody>
    with SingleTickerProviderStateMixin {
  final numController = TextEditingController();
  final codeController = TextEditingController();
  final nameController = TextEditingController();
  late final tabController = TabController(length: 2, vsync: this);

  @override
  void dispose() {
    numController.dispose();
    codeController.dispose();
    nameController.dispose();
    super.dispose();
  }

  bool _loading = false;
  late final bloc = context.read<AuthBloc>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final forSingUp = widget.forSingUp;
    return Column(
      children: [
        Padding(
          padding: AppPaddings.horiz56_vertic70,
          child: Text(
            l10n.registerTitle,
            style: AppTheme.titleMedium16(context, weightless: true),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              Column(
                children: [
                  AuthField(
                    keyboardType: widget.forSingUp
                        ? TextInputType.text
                        : TextInputType.phone,
                    label: widget.forSingUp ? l10n.userName : l10n.phoneNumber,
                    controller:
                        widget.forSingUp ? nameController : numController,
                  ),
                  AuthField(
                    keyboardType: widget.forSingUp
                        ? TextInputType.phone
                        : TextInputType.text,
                    label: widget.forSingUp ? l10n.phoneNumber : l10n.password,
                    controller:
                        widget.forSingUp ? numController : codeController,
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  if (widget.forSingUp) TermsOfUseWidget(),
                ],
              ),
              Column(
                children: [
                  AuthField(
                    keyboardType: TextInputType.text,
                    label: context.l10n.password,
                    controller: codeController,
                  )
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: AppPaddings.horiz_16.copyWith(top: 21.h),
          child: MyDarkTextButton(
            title: l10n.next,
            onTap: () async {
              final number = '993${numController.text}';
              final password = codeController.text;
              final name = nameController.text == '' && !forSingUp
                  ? null
                  : nameController.text;

              final model =
                  AuthModel(entity: number, password: password, name: name);

              if (!bloc.checkName(name) || !bloc.checkNum(number)) {
                return;
              }
              if (widget.forSingUp) {
                if (!bloc.checkTerms()) return;

                if (tabController.index == 0) {
                  tabController.animateTo(1);
                  return;
                }
                if (!bloc.checkPass(password)) return;

                bloc.singUp(model).then((value) {
                  if (value) return;

                  tabController.animateTo(0);
                });
                return;
              }
              await bloc.logIn(model);
            },
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
        Padding(
          padding: AppPaddings.horiz_16.copyWith(bottom: 108.h, top: 16.h),
          child: RichText(
            text: TextSpan(
              style: AppTheme.bodyMedium14(context),
              children: [
                TextSpan(
                  text:
                      '${(!forSingUp ? l10n.createNewAcc : l10n.alreadyHaveacc)}  ',
                ),
                TextSpan(
                  text: !forSingUp ? l10n.create : l10n.logIn,
                  style: TextStyle(
                    color: AppColors.mainOrange,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      if (_loading) {
                        return;
                      }
                      context.pop();
                      context.push(AppRoutes.auth, extra: !widget.forSingUp);
                    },
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
