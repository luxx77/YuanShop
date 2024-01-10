import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_express/app/setup.dart';
import 'package:hh_express/features/auth/bloc/auth_bloc.dart';
import 'package:hh_express/features/categories/view/body.dart';
import 'package:hh_express/features/product_details/view/product_details_body.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/repositories/products/product_repo.dart';
import 'package:hh_express/settings/theme.dart';

class UsageTermsDialog extends StatefulWidget {
  const UsageTermsDialog({super.key});

  @override
  State<UsageTermsDialog> createState() => _UsageTermsDialogState();
}

class _UsageTermsDialogState extends State<UsageTermsDialog> {
  final repo = getIt<ProductRepo>();
  @override
  void initState() {
    super.initState();
  }

  late final mqSize = MediaQuery.sizeOf(context);
  late final l10n = context.l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textButtonTheme.style as MyButtonStyle;
    return AlertDialog(
      title: Text(
        l10n.termsOfUsage,
        style: AppTheme.bodyLargeW500(context),
      ),
      actions: [
        TextButton(
          style: theme,
          onPressed: () => Navigator.pop(context),
          child: Text(
            l10n.exit,
            style: AppTheme.bodyLargeW500(context),
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<AuthBloc>().confirmTerms(true);
            Navigator.pop(context);
          },
          style: theme,
          child: Text(
            l10n.confirm,
            style: AppTheme.bodyLargeW500(context),
          ),
        ),
      ],
      content: SizedBox(
        height: mqSize.height * 0.33,
        width: mqSize.width * 0.8,
        child: FutureBuilder(
          future: repo.getTermsOfUsage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return CenterLoading();
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data == null
                  ? CategoryErrorBody(
                      onTap: () => setState(() {}),
                    )
                  : Text(
                      snapshot.data!.description,
                    ).toSingleChildScrollView;
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
