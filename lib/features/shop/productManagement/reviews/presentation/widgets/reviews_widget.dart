import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/rating_bar_widget.dart';
import '../../data/model/reviews_model.dart';
import 'size_linear_progress_indicator_widget.dart';

class ReviewsWidget extends StatelessWidget {
  final dynamic rates;
  final double total;
  final List<CounterModel> counter;

  const ReviewsWidget({
    super.key,
    required this.rates,
    required this.total,
    required this.counter,
  });

  @override
  Widget build(BuildContext context) {
    double tempRates = (rates * 10).truncate() / 10;

    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 1.r,
          ),
        ],
      ),
      child: Row(
        children: [
         Column(
           children: [
             AutoSizeTextWidget(
               text: tempRates.toString(),
               fontSize: 23.sp,
               maxFontSize: 30,
               fontWeight: FontWeight.bold,
             ),
             6.h.verticalSpace,
             RatingBarWidget(
               evaluation: tempRates.toDouble(),
               itemSize: 15.5.sp,
             ),
           ],
         ),
          Expanded(
            child: Column(
              children: List.generate(
                counter.length,
                (index) {
                  return SizeLinearProgressIndicatorWidget(
                    value: counter[index].value! / total,
                    sizeName: counter[index].name.toString(),
                    showTextAtTheBeginningOnly: index == 0 ? true : false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
