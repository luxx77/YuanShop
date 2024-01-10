import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hh_express/features/home/bloc/home_bloc.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/theme.dart';

class DeliveryWidget extends StatelessWidget {
  const DeliveryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final models = context.read<HomeBloc>().state.deliveryInfo;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppPaddings.bottom12_top20.add(AppPaddings.horiz_16),
          child: Text(
            models?.title ?? '',
            style: AppTheme.titleMedium14(context),
          ),
        ),
        ...List.generate(
          models?.data.length ?? 0,
          (index) {
            final e = models!.data[index];
            return Padding(
              padding: AppPaddings.vertic_8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 9.w),
                    child: SizedBox.square(
                      dimension: AppSpacing.getTextHeight(12),
                      child: FittedBox(
                        alignment: Alignment.center,
                        child: SvgPicture.network(
                          e.icon,
                          placeholderBuilder: (context) {
                            return SizedBox.square(
                                dimension: AppSpacing.getTextHeight(12));
                          },
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      e.text,
                      style: AppTheme.bodyMedium12(context),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
