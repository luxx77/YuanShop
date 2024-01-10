import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpacing {
  static SizedBox vertical_4 = SizedBox(
    height: 4.h,
  );
  static SizedBox horizontal_5_5 = SizedBox(
    width: 5.5.w,
  );
  static SizedBox vertical_7 = SizedBox(
    height: 7.h,
  );
  static SizedBox horizontal_4 = SizedBox(
    width: 4.w,
  );
  static SizedBox horizontal_5 = SizedBox(
    width: 5.w,
  );
  static SizedBox vertical_10 = SizedBox(
    height: 10.h,
  );
  static SizedBox vertical_12 = SizedBox(
    height: 12.h,
  );
  static SizedBox horizontal_12 = SizedBox(
    width: 12.w,
  );
  static SizedBox vertical_16 = SizedBox(
    height: 16.h,
  );
  static SizedBox horizontal_16 = SizedBox(
    width: 16.w,
  );
  static SizedBox horizontal_15 = SizedBox(
    width: 15.w,
  );
  static SizedBox vertical_18 = SizedBox(
    height: 18.h,
  );
  static SizedBox horizontal_18 = SizedBox(
    width: 18.w,
  );
  static SizedBox vertical_20 = SizedBox(
    height: 20.h,
  );
  static SizedBox horizontal_20 = SizedBox(
    width: 20.w,
  );
  static SizedBox vertical_24 = SizedBox(
    height: 24.h,
  );
  static SizedBox vertical_25 = SizedBox(
    height: 25.h,
  );
  static SizedBox vertical_26 = SizedBox(
    height: 26.h,
  );
  static SizedBox vertical_30 = SizedBox(
    height: 30.h,
  );
  static SizedBox vertical_40 = SizedBox(
    height: 40.h,
  );
  static SizedBox vertical_60 = SizedBox(
    height: 60.h,
  );

  static SizedBox horizontal_24 = SizedBox(
    width: 24.h,
  );
  static SizedBox vertical_8 = SizedBox(
    height: 8.h,
  );
  static SizedBox horizontal_8 = SizedBox(
    width: 8.w,
  );
  static SizedBox vertical_14 = SizedBox(
    height: 14.h,
  );
  static SizedBox vertical_15 = SizedBox(
    height: 15.h,
  );
  static SizedBox horizontal_14 = SizedBox(
    width: 14.w,
  );

  static double topPad = 0;

  static init(BuildContext context) {
    if (topPad != 0) {
      return;
    }
    final padding = MediaQuery.paddingOf(context).top;
    topPad = padding;
  }

  static double getTextHeight(num size, {FontWeight? weight}) {
    RenderParagraph renderParagraph = RenderParagraph(
      TextSpan(
        text: 'T',
        style: TextStyle(
          fontSize: size.sp,
        ),
      ),
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );
    renderParagraph.layout(BoxConstraints());
    final textHeight = renderParagraph.size.height;
    return textHeight;
  }
}
