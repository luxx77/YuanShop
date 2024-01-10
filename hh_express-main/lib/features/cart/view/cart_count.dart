import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/cart/cubit/cart_cubit.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/settings/consts.dart';

class CartCount extends StatefulWidget {
  const CartCount({
    super.key,
    required this.onAdd,
    required this.onRemove,
    required this.count,
  });
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final int count;
  @override
  State<CartCount> createState() => _CartCountState();
}

class _CartCountState extends State<CartCount> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(builder: (context, state) {
      return Expanded(
        flex: 5,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: AppBorderRadiuses.defBorderDark,
                borderRadius: AppBorderRadiuses.border_4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        widget.onRemove();
                      },
                      child: FittedBox(
                        child: Icon(
                          Icons.remove_outlined,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 32.w),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      widget.onAdd();
                    },
                    child: FittedBox(
                      child: Icon(
                        Icons.add_outlined,
                        color: AppColors.darkGrey,
                      ),
                    ),
                  )),
                ],
              ),
            ),
            Container(
              width: 32.w,
              padding: AppPaddings.horiz_6,
              alignment: Alignment.center,
              color: AppColors.darkGrey,
              child: FittedBox(
                child: Text(
                  '${widget.count}',
                  style: context.theme.textTheme.labelSmall,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
