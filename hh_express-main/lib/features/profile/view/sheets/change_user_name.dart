import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_size/flutter_keyboard_size.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/auth/components/auth_field.dart';
import 'package:hh_express/features/components/my_text_button.dart';
import 'package:hh_express/features/components/widgets/sheet_titles.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';

class ChangeUserNameSheet extends StatefulWidget {
  const ChangeUserNameSheet({super.key});
  @override
  State<ChangeUserNameSheet> createState() => _ChangeUserNameSheetState();
}

class _ChangeUserNameSheetState extends State<ChangeUserNameSheet> {
  final controller = TextEditingController();

  @override
  void dispose() {
    
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return KeyboardSizeProvider(
      smallSize: 400,
      child: Column(
        children: [
          BottomSheetTitle(
            title: l10n.userName,
            isPadded: true,
          ),
          AppSpacing.vertical_40,
          AuthField(
            keyboardType: TextInputType.text,
            label: l10n.name,
            controller: controller,
          ),
          Padding(
            padding: AppPaddings.horiz_16.copyWith(bottom: 16.h, top: 10.h),
            child: MyDarkTextButton(
              title: context.l10n.save,
              onTap: () async {
                Navigator.pop(context);
              },
            ),
          ),
          Consumer<ScreenHeight>(
            builder: (context, value, child) {
              return SizedBox(
                height: value.keyboardHeight,
              );
            },
          ),
        ],
      ).toSingleChildScrollView,
    );
  }
}
