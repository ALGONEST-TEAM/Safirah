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
          text: "$countEvaluation",
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          colorText: AppColors.secondaryColor,
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
          glowColor: AppColors.primaryColor,
          itemBuilder: (context, _) => const Icon(
            Icons.star_rate_rounded,
            color: Color(0xffffbd30),
          ),
          onRatingUpdate: (rating) => onRatingUpdate(rating),
        ),
        14.h.verticalSpace,
        TextFormFieldWidget(
          controller: commentController,
          type: TextInputType.text,
          maxLine: 4,
          hintText: S.of(context).AddAComment,
          hintTextColor: AppColors.fontColor,
          hintFontSize: 11.5.sp,
          fillColor: AppColors.scaffoldColor,
          fieldValidator: (value) {
            if (value == null || value.toString().isEmpty) {
              return S.of(context).pleaseAddAComment;
            }
            return null;
          },
        ),
        16.h.verticalSpace,
      ],
    );
  }
}
