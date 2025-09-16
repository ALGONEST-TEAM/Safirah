import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RichTextWidget extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Color firstColor;
  final Color secondColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? fontSizeSecondText;
  final FontWeight? fontWeightSecondText;
  const RichTextWidget({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.firstColor,
    required this.secondColor,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.fontSizeSecondText,
    this.fontWeightSecondText
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: firstText,
            style: TextStyle(
              color: firstColor,
              fontSize: fontSize ?? 12.sp,
              fontWeight: fontWeight ?? FontWeight.w500,
              fontFamily: 'IBMPlexSansArabic',
            ),
          ),
          TextSpan(
            text: secondText,
            style: TextStyle(
              color: secondColor,
              fontSize: fontSizeSecondText ?? 12.sp,
              fontWeight: fontWeightSecondText ?? FontWeight.w500,
              fontFamily: 'IBMPlexSansArabic',
            ),
          ),
        ],
      ),
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
