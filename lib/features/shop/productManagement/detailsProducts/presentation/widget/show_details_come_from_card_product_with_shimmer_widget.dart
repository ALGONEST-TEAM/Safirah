import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../../../core/widgets/shimmer_widget.dart';
import '../state_mangment/riverpod_details.dart';
import 'image_show_in_details_come_from_card_widget.dart';
import 'number_of_image_widget.dart';

class ShowDetailsComeFromCardProductWithShimmerWidget extends StatelessWidget {
  ShowDetailsComeFromCardProductWithShimmerWidget({
    super.key,
    required this.image,
    required this.price,
    required this.name,
  });

  final List<String> image;
  final String name;
  final dynamic price;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer(
        builder: (context, ref, child) {
          var indexColorImage = ref.watch(changeIndexOfColorImageProvider);
          var indexImage = ref.watch(showNumberOfScrollImageProvider);

          return Column(
            children: [
              ImageShowInDetailsComeFromCardWidget(
                productData: image,
                indexColorImage: indexColorImage,
              ),
              NumberOfImageWidget(
                numImageAndIndex: "${image.length} / ${indexImage ?? 1}",
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(12.sp),
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeTextWidget(
                      text: name,
                      colorText: AppColors.fontColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                      maxLines: 2,
                    ),
                    4.verticalSpace,
                    PriceAndCurrencyWidget(
                      price: price.toString(),
                      fontSize1: 16.sp,
                      fontSize2: 13.sp,
                      textWeight1: FontWeight.w600,
                      textWeight2: FontWeight.w600,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    14.verticalSpace,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerWidget(
                          child: Container(
                            width: 100.w,
                            color: Colors.grey.withOpacity(0.5),
                            child: const AutoSizeTextWidget(text: ''),
                          ),
                        ),
                        4.verticalSpace,
                        ShimmerWidget(
                          child: Container(
                            width: double.infinity,
                            height: 20,
                            child: AutoSizeTextWidget(
                              text: '',
                            ),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                    14.verticalSpace,
                    Column(
                      children: [
                        ShimmerWidget(
                          child: Container(
                            width: 100.w,
                            color: Colors.grey.withOpacity(0.5),
                            child: const AutoSizeTextWidget(text: ''),
                          ),
                        ),
                        12.verticalSpace,
                      ],
                    ),
                    Wrap(
                      spacing: 6.0.w,
                      runSpacing: 6.0.h,
                      children: [
                        Container(
                          width: 20.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.05),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 20.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.05),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 20.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.05),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 20.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.05),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    14.verticalSpace,
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
