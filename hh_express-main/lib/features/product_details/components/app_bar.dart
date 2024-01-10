import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hh_express/features/components/widgets/svg_icons.dart';
import 'package:hh_express/features/favors/bloc/favors_bloc.dart';
import 'package:hh_express/features/product_details/bloc/product_details_bloc.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/models/cart/cart_product_model/cart_product_model.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';

class ProdDetailsAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ProdDetailsAppBar({
    super.key,
  });
  Size get preferredSize => Size.fromHeight(52.h);

  @override
  State<ProdDetailsAppBar> createState() => _ProdDetailsAppBarState();
}

class _ProdDetailsAppBarState extends State<ProdDetailsAppBar> {
  late final cubit = context.read<ProductDetailsBloc>();
  bool isFavor = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: AppSpacing.topPad),
      height: 52.h,
      padding: AppPaddings.horiz_16,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        boxShadow: AppColors.appBarShadow,
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              appRouter.currentContext.pop();
            },
            child: Container(
              height: double.infinity,
              width: 24.sp,
              alignment: Alignment.center,
              child: FittedBox(
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: theme.iconTheme.color,
                ),
              ),
            ),
          ),
          Text(
            context.l10n.aboutProd,
            style: theme.textTheme.titleMedium,
          ),
          BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
            bloc: cubit,
            builder: (context, state) {
              if (state.state != ProdDetailsAPIState.success)
                return SizedBox.square(dimension: 30.sp);
              isFavor = state.product!.isFavorite;
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: AppColors.transparent,
                  side: BorderSide.none,
                  disabledBackgroundColor: AppColors.white,
                  shape: const CircleBorder(),
                  padding: AppPaddings.all_5,
                  minimumSize: const Size(0, 0),
                  maximumSize: Size(35.w, 35.h),
                  backgroundColor: AppColors.white,
                  foregroundColor: Colors.grey.withOpacity(0.1),
                ),
                child: MyImageIcon(
                  path: isFavor ? AssetsPath.favorFilled : AssetsPath.favorIcon,
                  color: isFavor ? AppColors.mainOrange : AppColors.darkBlue,
                  contSize: 24.sp,
                  iconSize: 19.w,
                ),
                onPressed: () async {
                  final prod = state.product!;
                  final model = CartProductModel(
                    isFavorite: prod.isFavorite,
                    description: prod.description,
                    discountPrice: prod.discount,
                    id: prod.id,
                    image: prod.images.first,
                    name: prod.name,
                    price: prod.price,
                    salePrice: prod.salePrice,
                  );

                  /// switch favor returns isFavor after request and "null" if request was failed
                  final val =
                      await context.read<FavorsCubit>().switchFavor(model);
                  if (val != null) {
                    setState(() {
                      state.product!.isFavorite = val;
                    });
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
