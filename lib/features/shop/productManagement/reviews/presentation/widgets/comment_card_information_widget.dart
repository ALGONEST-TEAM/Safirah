import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/extension/string.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/rating_bar_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../data/model/review_data.dart';

class CommentCardInformationWidget extends StatelessWidget {
  final ReviewData reviews;
  final DateTime date;

  const CommentCardInformationWidget({
    super.key,
    required this.reviews,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final hasColor = (reviews.colorHex?.isNotEmpty ?? false);
    final colorName = reviews.colorName ?? '';
    final sizeValue = reviews.sizeValue?.toString() ?? '';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5.h,
                  children: [
                    AutoSizeTextWidget(
                      text: reviews.userName,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.4.sp,
                      minFontSize: 12,
                    ),
                    AutoSizeTextWidget(
                      text: DateFormat('yyyy-MM-dd', 'en').format(date),
                      fontSize: 9.4.sp,
                      colorText: AppColors.fontColor,
                    ),
                  ],
                ),
              ),
              4.w.horizontalSpace,
              RatingBarWidget(
                evaluation: (reviews.reviewValue ?? 0).toDouble(),
                itemSize: 13.sp,
              ),
            ],
          ),
          4.h.verticalSpace,
          Row(
            children: [
              if (hasColor)
                AutoSizeTextWidget(
                  text: "${S.of(context).color}: ",
                  fontSize: 10.5.sp,
                  colorText: AppColors.fontColor,
                ),
              if (hasColor)
                Container(
                  height: 12.h,
                  width: 12.w,
                  decoration: BoxDecoration(
                    color: reviews.colorHex.toString().toColor(),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              Flexible(
                child: AutoSizeTextWidget(
                  text:
                      " $colorName${colorName.isNotEmpty ? "  -  " : ''}${S.of(context).size}: $sizeValue",
                  fontSize: 10.5.sp,
                  colorText: AppColors.fontColor,
                ),
              ),
            ],
          ),
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text: reviews.comment,
            fontSize: 12.sp,
            minFontSize: 10,
            maxLines: 20,
          ),
        ],
      ),
    );
  }
}
