import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/text_form_field.dart';
import '../../../../../../generated/l10n.dart';

class AddRatingAndCommentWidget extends StatelessWidget {
  final double countEvaluation;
  final TextEditingController commentController;

  final ValueChanged<double> onRatingUpdate;

  const AddRatingAndCommentWidget(
      {super.key,
      required this.commentController,
      required this.countEvaluation,
      required this.onRatingUpdate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AutoSizeTextWidget(
          text: S.of(context).canYouLeaveYourReview,
          fontSize: 15.5.sp,
        ),
        12.h.verticalSpace,
        AutoSizeTextWidget(
          text: "$countEvaluation",
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          colorText: AppColors.primaryColor,
        ),
        8.h.verticalSpace,
        RatingBar.builder(
          initialRating: 2.5,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 30.r,
          unratedColor: const Color(0xfffed9a3),
          itemPadding: const EdgeInsets.symmetric(horizontal: 9.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star_rate,
            color: Color(0xffffbd30),
          ),
          onRatingUpdate: (rating) => onRatingUpdate(rating),
        ),
        14.h.verticalSpace,
        TextFormFieldWidget(
          controller: commentController,
          type: TextInputType.text,
          maxLine: 3,
          hintText: S.of(context).AddAComment,
          hintTextColor: AppColors.greySwatch.shade600.withOpacity(.7),
          hintFontSize: 11.5.sp,
          fillColor: AppColors.greySwatch.shade50,
          fieldValidator: (value) {
            if (value == null || value.toString().isEmpty) {
              return "يرجى إضافة تعليق";
            }
          },
        ),
        18.h.verticalSpace,
      ],
    );
  }
}
