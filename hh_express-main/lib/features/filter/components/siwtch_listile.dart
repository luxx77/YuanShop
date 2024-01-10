import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

/// add Bloc
class FilterSwithListTile extends StatelessWidget {
  const FilterSwithListTile({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final listener = ValueNotifier<bool>(false);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: AppTheme.titleMedium16(context),
      ),
      trailing: ValueListenableBuilder(
        valueListenable: listener,
        builder: (context, value, child) {
          return CupertinoSwitch(
            value: value,
            activeColor: AppColors.mainOrange,
            trackColor: AppColors.darkGrey,
            onChanged: (value) {
              listener.value = !listener.value;
            },
          );
        },
      ),
    );
  }
}
