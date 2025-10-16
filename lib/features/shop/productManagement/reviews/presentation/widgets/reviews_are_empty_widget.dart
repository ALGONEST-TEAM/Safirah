import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';

class ReviewsAreEmptyWidget extends StatelessWidget {
  const ReviewsAreEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 6.h,
        children: [
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Icon(
                  Icons.star_outline_sharp,
                  size: 38.sp,
                  color: AppColors.primaryColor,
                );
              },
            ),
          ),
          AutoSizeTextWidget(
            text: S.of(context).noReviewsForThisProduct,
            fontSize: 16.sp,
          ),
        ],
      ),
    );
  }
}
