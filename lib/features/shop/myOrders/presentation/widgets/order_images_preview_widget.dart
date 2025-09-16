import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';

class OrderImagesPreviewWidget extends StatelessWidget {
  final List<String> images;

  const OrderImagesPreviewWidget({
    super.key,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }
    if (images.length <= 2) {
      return ListView.separated(
        scrollDirection: Axis.horizontal,
        reverse: Directionality.of(context) == TextDirection.ltr ? false : true,
        itemCount: images.length,
        separatorBuilder: (_, __) => 4.w.horizontalSpace,
        itemBuilder: (context, index) {
          return OnlineImagesWidget(
            imageUrl: images[index],
            size: Size(84.w, double.infinity),
          );
        },
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 4.w,
        children: [
          Container(
            width: 50.w,
            height: 84.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: AutoSizeTextWidget(
              text: "+${images.length - 2}",
              fontSize: 12.4.sp,
              colorText:AppColors.whiteColor,
            ),
          ),
          ...images.take(2).map(
                (url) => Flexible(
                  child: OnlineImagesWidget(
                    imageUrl: url,
                    size: Size(84.w, double.infinity),
                  ),
                ),
              ),
        ],
      );
    }
  }
}
