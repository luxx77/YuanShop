import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/home/view/components/product_widget.dart';
import 'package:hh_express/models/products/product_model.dart';
import 'package:hh_express/settings/consts.dart';

class HomeProdBuilder extends StatelessWidget {
  const HomeProdBuilder({
    super.key,
    this.prods,
  });
  final List<ProductModel>? prods;
  @override
  Widget build(BuildContext context) {
    final isLoading = prods == null;
    return SliverPadding(
      padding: AppPaddings.horiz_6.add(AppPaddings.top_6),
      sliver: SliverDynamicHeightGridView(
        crossAxisCount: 2,
        crossAxisSpacing: 0.w,
        mainAxisSpacing: 10.h,
        itemCount: isLoading ? 24 : prods!.length,
        builder: (context, index) {
          return HomeProdWidget(
            index: index,
            prod: isLoading ? null : prods![index],
          );
        },
      ),
    );
  }
}
