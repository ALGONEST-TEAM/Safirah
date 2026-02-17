import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/online_images_widget.dart';

class TeamWidget extends StatelessWidget {
  final String name;
  final String image;
  final bool alignRight;
  final Size? sizeImage;
  final double? fontSize;
  final double? width;

  const TeamWidget({
    super.key,
    required this.name,
    required this.alignRight,
    required this.image,
    this.sizeImage,
    this.fontSize,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 110.w,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment:
            alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!alignRight) ...[
            OnlineImagesWidget(
              imageUrl: image,
              backgroundColor: Colors.white,
              size: sizeImage ?? Size(22.w, 22.h),
              fit: BoxFit.contain,
            ),
            6.w.horizontalSpace,
            Flexible(
              child: AutoSizeTextWidget(
                text: name,
                fontSize: fontSize ?? 11.sp,
                maxLines: 2,
                textAlign: TextAlign.start,
              ),
            ),
          ] else ...[
            Flexible(
              child: AutoSizeTextWidget(
                text: name,
                fontSize: fontSize ?? 11.sp,
                maxLines: 2,
                textAlign: TextAlign.end,
              ),
            ),
            6.w.horizontalSpace,
            OnlineImagesWidget(
              imageUrl: image,
              size: sizeImage ?? Size(22.w, 22.h),
              fit: BoxFit.contain,

            ),
          ]
        ],
      ),
    );
  }
}
