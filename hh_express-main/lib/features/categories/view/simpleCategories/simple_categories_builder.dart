import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/categories/bloc/category_bloc.dart';
import 'package:hh_express/features/categories/view/body.dart';
import 'package:hh_express/features/categories/view/simpleCategories/simple_categories_widget.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/models/categories/category_model.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';

class SimpleCategoriesBuilder extends StatelessWidget {
  const SimpleCategoriesBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        final slug = state.mains?[state.activIndex ?? 0].slug;
        final apiState = state.state;
        if (apiState == CategoryAPIState.error) {
          return SizedBox(width: double.infinity);
        }
        if (state.state == CategoryAPIState.errorSubs) {
          return Expanded(
            child: CategoryErrorBody(
              onTap: () {
                context.read<CategoryBloc>().add(ChangeCategory(slug: slug!));
              },
            ),
          );
        }
        return _UIBuilder(
          list: state.subs?[slug],
        );
      },
    );
  }
}

class _UIBuilder extends StatelessWidget {
  const _UIBuilder({
    this.list,
  });
  final List<CategoryModel>? list;
  @override
  Widget build(BuildContext context) {
    final isLoading = list == null;
    return Expanded(
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: isLoading ? null : list!.length,
          padding: AppPaddings.horiz12_vertic17.add(AppPaddings.top_6),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1 / 0.8,
            mainAxisSpacing: 10.h,
          ),
          itemBuilder: (context, index) {
            return SimpleCategoryWidget(
              model: isLoading ? null : list![index],
            );
          },
        ),
      ),
    );
  }
}


 

//  CustomScrollView(
//             slivers: [
//               SliverPadding(
//                 padding: AppPaddings.horiz12_vertic17.add(AppPaddings.top_6),
//                 sliver: SliverDynamicHeightGridView(
//                   crossAxisCount: 3,
//                   itemCount: 20,
//                   builder: (context, index) {
//                     return SimpleCategoryWidget(
//                       index: index - 1,
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),