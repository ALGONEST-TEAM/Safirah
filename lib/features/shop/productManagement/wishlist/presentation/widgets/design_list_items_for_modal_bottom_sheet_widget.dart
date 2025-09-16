import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/online_images_widget.dart';


class DesignListItemsForModalBottomSheetWidget extends StatelessWidget {
  final int listId;
  final String name;
  final String image1;
  final String image2;
  final String image3;
  final bool isLoading;

  const DesignListItemsForModalBottomSheetWidget({
    super.key,
    required this.name,
    required this.listId,
    required this.image1,
    required this.image2,
    required this.image3,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OnlineImagesWidget(
                    imageUrl: image1,
                    size: Size(26.w, 42.h),
                    borderRadius: 0,
                    logoWidth: 20.w,
                  ),
                  2.w.horizontalSpace,
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OnlineImagesWidget(
                          imageUrl: image2,
                          size: Size(26.w, 20.h),
                          borderRadius: 0,
                          logoWidth: 16.w,
                        ),
                        2.h.verticalSpace,
                        OnlineImagesWidget(
                          imageUrl: image3,
                          size: Size(26.w, 20.h),
                          borderRadius: 0,
                          logoWidth: 16.w,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              12.w.horizontalSpace,
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: AutoSizeTextWidget(
                        text: name,
                        fontSize: 10.2.sp,
                        maxLines: 2,
                      ),
                    ),
                    6.h.horizontalSpace,
                    if (isLoading)
                      SpinKitCircle(
                        color: AppColors.primaryColor,
                        size: 20.r,
                      ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: AppColors.greySwatch.shade50,
          ),
        ],
      ),
    );
  }
}
