import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/app_icons.dart';

class RatingBarWidget extends StatelessWidget {
  final double evaluation;
  final int? length;
  final double? itemSize;

  const RatingBarWidget({
    super.key,
    required this.evaluation,
    this.length,
    this.itemSize,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: evaluation,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      ignoreGestures: true,
      itemCount: length ?? 5,
      itemSize: itemSize ?? 14.sp,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 0.6.h),
          child: SvgPicture.asset(
            AppIcons.starActive,
          ),
        );
      },
      onRatingUpdate: (rating) {},
    );
  }
}
