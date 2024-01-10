import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/my_text_button.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/settings/consts.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({
    super.key,
    required this.title,
    required this.onAdd,
    required this.onRemove,
    this.quantity = 0,
  });
  final int quantity;
  final String title;
  final VoidCallback onRemove;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return quantity == 0
        ? MyDarkTextButton(
            title: title,
            onTap: () {
              onAdd();
            },
          )
        : Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    onRemove();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.darkBlue,
                        width: 1.5.w,
                      ),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(6.r),
                      ),
                    ),
                    child: const FittedBox(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.remove_rounded,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.darkBlue,
                  alignment: Alignment.center,
                  child: Text(
                    '$quantity',
                    style: context.theme.textTheme.labelMedium,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    onAdd();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.darkBlue,
                        width: 1.5.w,
                      ),
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(6.r),
                      ),
                    ),
                    child: const FittedBox(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.add_rounded,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
