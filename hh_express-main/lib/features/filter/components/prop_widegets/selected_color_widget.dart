import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/models/property/values/property_value_model.dart';
import 'package:hh_express/settings/consts.dart';

class SelectedFilterColorWidget extends StatelessWidget {
  SelectedFilterColorWidget({super.key, required this.color});
  final PropertyValue color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.sp,
      width: 20.sp,
      padding: EdgeInsets.all(1.5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppBorderRadiuses.border_6,
      ),
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: AppBorderRadiuses.border_4,
        child: CachedNetworkImage(
          imageUrl: color.icon ?? AssetsPath.exampleColor,
          width: double.infinity,
          height: double.infinity,
          placeholder: (context, url) {
            return const MyShimerPlaceHolder();
          },
          errorWidget: (context, url, error) => const MyShimerPlaceHolder(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
