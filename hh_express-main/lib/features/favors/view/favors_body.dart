import 'package:flutter/material.dart';
import 'package:hh_express/features/components/widgets/sheet_titles.dart';
import 'package:hh_express/features/favors/components/favors_builder.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/spacers.dart';

class FavorsBody extends StatelessWidget {
  const FavorsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BottomSheetTitle(
          title: context.l10n.favorites,
          isPadded: true,
        ),
        AppSpacing.vertical_10,
        const FavrosBuilder(),
      ],
    ).toSingleChildScrollView;
  }
}
