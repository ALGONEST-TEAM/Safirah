import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/extension/string.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../pages/news_details_page.dart';

class ShortCardOfNewsWidget extends StatelessWidget {
  final String name;
  final String date;
  final String? imageUrl;
  final int? id;
  const ShortCardOfNewsWidget({
    super.key,
    required this.name,
    required this.date,
    required this.imageUrl,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        navigateTo(context, NewsDetailsPage(id: id!));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.sp),
                  bottomLeft: Radius.circular(15.sp),
                ),
              ),
              child: OnlineImagesWidget(
                imageUrl: imageUrl != ''
                    ? imageUrl!
                    : 'https://media.istockphoto.com/id/2110310187/photo/luxury-tropical-pool-villa-at-dusk.jpg?s=1024x1024&w=is&k=20&c=FfMY-QLqiixCQprNhrs5vmHZn1_vHqxKj3CWBRQsJ9M=',
                borderRadius: 12.r,
                size: Size(90.w, 60.h),
                fit: BoxFit.cover,
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeTextWidget(
                    text: name,
                    fontSize: 11.sp,
                    maxLines: 3,
                    fontWeight: FontWeight.w500,
                  ),
                  6.verticalSpace,
                  Row(
                    children: [
                      2.horizontalSpace,
                      Expanded(
                        child: AutoSizeTextWidget(
                          text: formatDate(date),
                          fontSize: 8.6.sp,
                          minFontSize: 7,
                          colorText: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
