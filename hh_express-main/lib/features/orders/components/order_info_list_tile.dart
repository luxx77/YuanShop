import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/components/widgets/place_holder.dart';
import 'package:hh_express/features/product_details/components/color_builder.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class OrderInfoListTile extends StatelessWidget {
  const OrderInfoListTile({
    super.key,
    required this.title,
    required this.content,
    this.contentBold,
    this.titleBold,
  });
  final String? title;
  final String? content;
  final bool? titleBold;
  final bool? contentBold;

  bool get isColor {
    return content?.startsWith('http') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final isLoading = title == null;
    content.log();
    if (isLoading) return _LoadingWidget();
    return Padding(
      padding: titleBold != null || contentBold != null
          ? EdgeInsets.zero
          : AppPaddings.bottom_15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$title',
            // overflow: TextOverflow.ellipsis,

            textAlign: TextAlign.start,
            style: titleBold ?? false ? theme.titleLarge : theme.displaySmall,
          ),
          AppSpacing.horizontal_8,
          isColor
              ? ProdColorWidget(
                  onTap: () {},
                  color: content,
                  isSelected: false,
                )
              : Expanded(
                  child: Text(
                    '$content',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: contentBold ?? false
                        ? theme.bodyLarge
                        : AppTheme.bodyMedium14(context),
                  ),
                ),
        ],
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.bottom_15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyShimerPlaceHolder(
            width: 115.w,
            height: 18.h,
            radius: AppBorderRadiuses.border_4,
          ),
          AppSpacing.horizontal_8,
          MyShimerPlaceHolder(
            width: 70.w,
            height: 18.h,
            radius: AppBorderRadiuses.border_4,
          )
        ],
      ),
    );
  }
}
