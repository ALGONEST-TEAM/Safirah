import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/online_images_widget.dart';

class ReviewImagesStripWidget extends StatelessWidget {
  final List<String> images;

  const ReviewImagesStripWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return SizedBox(height: 5.h);

    return SizedBox(
      height: 130.h,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(12.sp),
        itemBuilder: (context, index) {
          return OnlineImagesWidget(
            imageUrl: images[index],
            size: Size(110.w, double.infinity),
            borderRadius: 4.r,
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 6.w),
        itemCount: images.length,
      ),
    );
  }
}
