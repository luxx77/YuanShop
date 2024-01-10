import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hh_express/features/categories/view/mainCategories/main_category_builder.dart';
import 'package:hh_express/features/categories/view/simpleCategories/simple_categories_builder.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/settings/consts.dart';

class CategoryBody extends StatefulWidget {
  const CategoryBody({super.key});

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  @override
  void initState() {
    // final bloc = context.read<CategoryBloc>();

    super.initState();
  }

  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MainCategoriesBuilder(),
        const SimpleCategoriesBuilder(),
      ],
    );
  }
}

class CategoryErrorBody extends StatelessWidget {
  const CategoryErrorBody({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${l10n.socketExeption}',
          textAlign: TextAlign.center,
          style: context.theme.textTheme.bodyLarge!.copyWith(
            fontSize: 19.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: double.infinity, height: 20.h),
        IconButton(
          icon: SvgPicture.asset(
            AssetsPath.reloadIcon,
            color: AppColors.darkGrey,
          ),
          onPressed: onTap,
        ),
      ],
    );
  }
}
