import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/helpers/modal_sheets.dart';

class PhotoSenderWidget extends StatelessWidget {
  const PhotoSenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 1,
      splashColor: Colors.transparent,
      iconSize: 22.h,
      icon: Icon(
        Icons.linked_camera_outlined,
      ),
      onPressed: () {
        ModelBottomSheetHelper.showCameraOrGallerySelector(context);
      },
    );
  }
}
