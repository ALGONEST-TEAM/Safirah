import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/rating_bar_widget.dart';

class EvaluationValueAndNumberOfRatingStarsWidget extends StatelessWidget {
  final dynamic rates;
  final double total;

  const EvaluationValueAndNumberOfRatingStarsWidget(
      {super.key, required this.rates, required this.total});

  @override
  Widget build(BuildContext context) {
    double tempRates = (rates * 10).truncate() / 10;

    return Row(
      mainAxisSize: MainAxisSize.max,
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
      ],
    );
  }
}
