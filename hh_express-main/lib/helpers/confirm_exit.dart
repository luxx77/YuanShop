import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_express/features/auth/bloc/auth_bloc.dart';
import 'package:hh_express/features/terms_of_usage/usage_terms_widget.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/settings/theme.dart';

class Confirm {
  static Future<void> onlogOut(BuildContext context) async {
    await context.read<AuthBloc>().logOut();
    Navigator.pop(_currentContext!);
  }

  static void onConfirmExit(BuildContext context) {
    Confirm.exit = true;
    Navigator.pop(_currentContext!);
  }

  static bool exit = false;
  static bool _isDialogShown = false;
  static BuildContext? _currentContext;
  static bool doPop() {
    if (_isDialogShown) {
      Navigator.pop(_currentContext!);
      return false;
    }
    return true;
  }

  static Future<bool> confirmExit(BuildContext context) async {
    exit = false;
    await showDialog(
      context: context,
      builder: (context) {
        _currentContext = context;
        _isDialogShown = true;
        return ConfirmingDialog(
          title: context.l10n.exit,
          content: context.l10n.exitConfirm,
          onConfirm: () => onConfirmExit(context),
        );
      },
    );
    _isDialogShown = false;
    return exit;
  }

  static Future<void> confirmTerms(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        _currentContext = context;
        _isDialogShown = true;
        _currentContext = context;
        return UsageTermsDialog();
      },
    );
    _isDialogShown = false;
  }

  static Future<void> showLogOutDialog(BuildContext context) async {
    final l10n = context.l10n;
    await showDialog(
      context: context,
      builder: (context) {
        _currentContext = context;
        _isDialogShown = true;
        return ConfirmingDialog(
          title: l10n.logOut,
          content: l10n.exitConfirm,
          onConfirm: () => onlogOut(context),
        );
      },
    );
    _isDialogShown = false;
  }
}

class ConfirmingDialog extends StatelessWidget {
  const ConfirmingDialog({
    super.key,
    required this.content,
    required this.title,
    required this.onConfirm,
  });
  final String title;
  final String content;
  final VoidCallback onConfirm;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textButtonTheme.style as MyButtonStyle;
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(
        title,
        style: AppTheme.bodyLargeW500(context),
      ),
      content: Text(
        content,
      ),
      actions: [
        TextButton(
          style: theme,
          onPressed: () => Navigator.pop(context),
          child: Text(
            l10n.cancle,
            style: theme.myTextStyle,
          ),
        ),
        TextButton(
          onPressed: onConfirm,
          style: theme,
          child: Text(
            l10n.exit,
            style: theme.myTextStyle,
          ),
        ),
      ],
    );
  }
}
