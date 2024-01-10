import 'package:flutter/material.dart';

import 'package:hh_express/features/components/widgets/sheet_titles.dart';
import 'package:hh_express/features/profile/components/sheets_list_tile.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/globals.dart';

class ChangeLangSheet extends StatelessWidget {
  const ChangeLangSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final langs = {
      'tr': l10n.turkmen,
      'ru': l10n.russian,
      'en': l10n.english,
    };
    return SingleChildScrollView(
      padding: AppPaddings.bottom_16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          BottomSheetTitle(
            title: l10n.programLang,
            isPadded: true,
          ),
          AppSpacing.vertical_16,
          ...List.generate(
            3,
            (index) {
              final myKey = langs.keys.toList()[index];
              final myLang = langs.values.toList()[index];
              return ValueListenableBuilder(
                valueListenable: locale,
                builder: (context, lang, child) {
                  final isSelected = lang == myKey;
                  return ProfileSelectListTile(
                    title: myLang,
                    isSelected: isSelected,
                    onTap: () {
                      locale.value = myKey;
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
