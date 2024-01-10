import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/models/videos/video_model.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:go_router/go_router.dart';

class VideoWidget extends StatelessWidget {
  const VideoWidget({super.key, required this.index, this.model});
  final int index;
  final HomeVideoModel? model;

  @override
  Widget build(BuildContext context) {
    final isLoading = model == null;
    if (isLoading) {
      return _WidgetsPlaceHolder(index: index);
    }
    return GestureDetector(
      onTap: () {
        context.pushNamed(AppRoutes.videoDetails.toRouteName,
            extra: model, queryParameters: {'index': '$index'});
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: AppPaddings.bottom_10,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: AppBorderRadiuses.border_6,
                  child: CachedNetworkImage(
                    height: index % 2 == 0 ? 205.h : 107.h,
                    fit: BoxFit.cover,
                    imageUrl: model!.product.image,
                    placeholder: (context, url) => MyShimerPlaceHolder(),
                    width: double.infinity,
                  ),
                ),
                Container(
                  margin: AppPaddings.all_6,
                  padding: AppPaddings.horiz6_vertic3,
                  decoration: BoxDecoration(
                      color: AppColors.darkBlue.withOpacity(.6),
                      borderRadius: AppBorderRadiuses.border_4),
                  child: Text(
                    model!.duration ?? '00:00',
                    style: context.theme.textTheme.labelLarge,
                  ),
                )
              ],
            ),
          ),
          Text(
            '${model!.name}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}

class _WidgetsPlaceHolder extends StatelessWidget {
  const _WidgetsPlaceHolder({
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: AppPaddings.bottom_10,
          height: index % 2 == 0 ? 205.h : 107.h,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              ClipRRect(
                borderRadius: AppBorderRadiuses.border_6,
                child: MyShimerPlaceHolder(),
              ),
              Container(
                  margin: AppPaddings.all_6,
                  decoration: BoxDecoration(
                      color: AppColors.darkBlue.withOpacity(.6),
                      borderRadius: AppBorderRadiuses.border_4),
                  child: MyShimerPlaceHolder(
                    radius: AppBorderRadiuses.border_4,
                    height: 28.h,
                    width: 55.w,
                  ))
            ],
          ),
        ),
        MyShimerPlaceHolder(
          radius: AppBorderRadiuses.border_4,
          height: 28.h,
        )
      ],
    );
  }
}
