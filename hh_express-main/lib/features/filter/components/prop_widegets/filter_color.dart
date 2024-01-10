import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/models/property/values/property_value_model.dart';
import 'package:hh_express/settings/consts.dart';

/// this widget for show colors in filter
class FilterColorWidget extends StatelessWidget {
  const FilterColorWidget({
    super.key,
    required this.color,
    this.isSelected,
    this.onTap,
    this.isMargined = false,
  });
  final bool isMargined;
  final PropertyValue color;
  final bool? isSelected;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: AppPaddings.bottom_5
                .add(isMargined ? AppPaddings.horiz_10 : EdgeInsets.zero),
            child: ClipRRect(
              borderRadius: AppBorderRadiuses.border_6,
              child: CachedNetworkImage(
                imageUrl: color.icon ?? AssetsPath.exampleColor,
                height: 34.sp,
                width: 34.sp,
                placeholder: (context, url) {
                  return const MyShimerPlaceHolder();
                },
                errorWidget: (context, url, error) =>
                    const MyShimerPlaceHolder(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (isSelected ?? false)
            Icon(
              Icons.check_outlined,
              color: Colors.white,
              size: 20.sp,
            )
        ],
      ),
    );
  }
}
