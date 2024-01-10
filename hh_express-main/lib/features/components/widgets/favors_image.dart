import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/settings/consts.dart';

class FavorsImage extends StatelessWidget {
  const FavorsImage({super.key, this.imgPath});
  final String? imgPath;
  @override
  Widget build(BuildContext context) {
    final isLoading = imgPath == null;
    return Container(
      height: double.infinity,
      width: 95.w,
      margin: AppPaddings.right_12,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: AppColors.lightGrey,
            width: 1.5.w,
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(5.r)),
        child: isLoading
            ? const MyShimerPlaceHolder(
                radius: BorderRadius.zero,
              )
            : CachedNetworkImage(
                imageUrl: imgPath!,
                errorWidget: (context, url, error) {
                  return Center(
                    child: Icon(
                      Icons.image_outlined,
                      color: AppColors.darkBlue,
                    ),
                  );
                },
                fit: BoxFit.cover,
                placeholder: (context, url) => const MyShimerPlaceHolder(),
              ),
      ),
    );
  }
}
