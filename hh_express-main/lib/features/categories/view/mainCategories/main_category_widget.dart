import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/categories/bloc/category_bloc.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/models/categories/category_model.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class MainCategoriesWidget extends StatelessWidget {
  const MainCategoriesWidget({
    super.key,
    required this.isSelected,
    required this.model,
  });

  final CategoryModel? model;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CategoryBloc>();

    /// isLoading
    if (model == null) {
      return _LoadingWidget();
    }
    return GestureDetector(
      onTap: () {
        final state = bloc.state;
        final itSelf = state.mains![state.activIndex!].slug == model!.slug;
        if (itSelf) {
          return;
        }
        bloc.add(ChangeCategory(slug: model!.slug));
      },
      child: Container(
        width: 76.w,
        padding: AppPaddings.horiz_10half,
        margin: AppPaddings.top_6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: model!.image,
              placeholder: (context, url) => MyShimerPlaceHolder(
                height: 55.h,
                width: 55.h,
                radius: BorderRadius.circular(100.r),
              ),
              errorWidget: (context, url, error) {
                return Container(
                  height: 55.sp,
                  width: 55.sp,
                  alignment: Alignment.center,
                  padding: AppPaddings.all_2,
                  decoration: const BoxDecoration(
                    color: AppColors.lightGrey,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.image_outlined),
                );
              },
              fit: BoxFit.contain,
              alignment: Alignment.center,
              imageBuilder: (context, imageProvider) => Container(
                height: 55.sp,
                width: 55.sp,
                alignment: Alignment.center,
                padding: AppPaddings.all_2,
                decoration: const BoxDecoration(
                  color: AppColors.lightGrey,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: context.theme.scaffoldBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image(
                      image: imageProvider,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            AppSpacing.vertical_10,
            Container(
              alignment: Alignment.topCenter,
              height: (AppSpacing.getTextHeight(10) * 2),
              child: Text(
                '${model!.name}',
                style: AppTheme.bodyMedium10(context),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              margin: AppPaddings.vertic_4,
              width: double.infinity,
              height: 2.h,
              decoration: BoxDecoration(
                borderRadius: AppBorderRadiuses.border_2,
                color: isSelected ? AppColors.black : Colors.transparent,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76.w,
      padding: AppPaddings.horiz_10half,
      margin: AppPaddings.top_6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 55.sp,
            width: 55.sp,
            padding: AppPaddings.all_2,
            decoration: const BoxDecoration(
              color: AppColors.lightGrey,
              shape: BoxShape.circle,
            ),
            child: MyShimerPlaceHolder(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.shimmerBodyColor,
                ),
              ),
            ),
          ),
          AppSpacing.vertical_10,
          ...List.generate(
            2,
            (index) => Container(
              margin: AppPaddings.vertic_2,
              height: 12,
              child: MyShimerPlaceHolder(
                radius: AppBorderRadiuses.border_2,
              ),
            ),
          ),
          AppSpacing.vertical_4,
        ],
      ),
    );
  }
}

//  CircleAvatar(
//                 backgroundColor: AppColors.transparent,
//                 foregroundColor: AppColors.transparent,
//                 foregroundImage: hasError
//                     ? AssetImage('assets/images/app_icon.png')
//                     : CachedNetworkImageProvider(
//                         model.image,
//                         errorListener: () {
//                           // set error image
//                           'Imageerror'.log();
//                           hasError = true;
//                           setState(() {});
//                         },
//                       ) as ImageProvider,
//                 child: MyShimerPlaceHolder(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.shimmerBodyColor,
//                     ),
//                   ),
//                 ),
//               ),
