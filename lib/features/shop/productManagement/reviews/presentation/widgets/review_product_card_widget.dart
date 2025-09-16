import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/online_images_widget.dart';

class ReviewProductCardWidget extends StatelessWidget {
  final String image;
  final String name;
  final String price;

  const ReviewProductCardWidget({
    super.key,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.02),
            blurRadius: 1.r,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OnlineImagesWidget(
            imageUrl: image,
            size: Size(90.w, 78.h),
            fit: BoxFit.cover,
            borderRadius: 2.r,
          ),
          12.w.horizontalSpace,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: name,
                  maxLines: 2,
                  fontSize: 12.sp,
                  minFontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
                12.h.verticalSpace,
                AutoSizeTextWidget(
                  text: price,
                  fontSize: 12.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
