import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/online_images_widget.dart';
import '../../../../../../core/widgets/photo_view_dialog_widget.dart';


class PhotoListWidget extends ConsumerWidget {
  final List<dynamic> image;

  const PhotoListWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 230.h,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 8.h),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              PhotoViewDialogWidget.show(
                context,
                image[index].toString(),
              );
            },
            child: OnlineImagesWidget(
              imageUrl: image[index].toString(),
              size: Size(150.w, double.infinity),
              borderRadius: 8.r,
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 6.w),
        itemCount: image.length,
      ),
    );
  }
}
