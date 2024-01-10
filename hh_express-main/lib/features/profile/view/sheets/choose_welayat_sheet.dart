import 'package:flutter/cupertino.dart';
import 'package:hh_express/features/components/widgets/sheet_titles.dart';
import 'package:hh_express/features/profile/components/sheets_list_tile.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/spacers.dart';

class ChooseWelayatSheet extends StatefulWidget {
  const ChooseWelayatSheet({super.key});
  @override
  State<ChooseWelayatSheet> createState() => _ChooseWelayatSheetState();
}

class _ChooseWelayatSheetState extends State<ChooseWelayatSheet> {
  int theWelayat = 0;
  List<String> welayats = List.empty();

  @override
  void initState() {
  

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final welayats = [
      l10n.balkan,
      l10n.ashgabat,
      l10n.ahal,
      l10n.mary,
      l10n.lebap,
      l10n.dasoguz,
    ];
    return Column(
      children: [
        BottomSheetTitle(
          title: context.l10n.welayat,
          isPadded: true,
        ),
        AppSpacing.vertical_16,
        ...List.generate(welayats.length, (index) {
          final isSelected = theWelayat == index;
          return ProfileSelectListTile(
            title: welayats[index],
            isSelected: isSelected,
            onTap: () {
              setState(() {
                theWelayat = index;
              });
            },
          );
        }),
        AppSpacing.vertical_16,
      ],
    ).toSingleChildScrollView;
  }
}
