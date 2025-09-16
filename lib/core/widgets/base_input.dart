import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../theme/app_colors.dart';

class BaseInputWidget extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final Map<String, String Function(Object)>? validationMessages;
  final String formControlName;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final Widget? prefix;
  final Color? fillColor;
  final String? label;
  final Color? labelTextColor;
  final double? labelFontSize;
  final String? hintText;
  final Color? hintTextColor;
  final double? hintFontSize;
  final double? fontSize;
  final double? contentPadding;
  final BorderSide? borderSide;
  final BorderSide? borderSideError;
  final ValueChanged? onChanged;
  final Function(FormControl<Object?>)? onSubmitted;
  final Function(FormControl<Object?>)? onTap;

  final int maxLines;
  final EdgeInsets? margin;
  final bool? expanded;
  final bool? autofocus;
  final bool? isPassword;
  final double? cursorHeight;
  final int? maxLine;

  const BaseInputWidget({
    super.key,
    required this.formControlName,
    this.inputFormatters,
    this.validationMessages,
    this.keyboardType,
    this.suffix,
    this.prefix,
    this.fillColor,
    this.hintText,
    this.hintTextColor,
    this.hintFontSize,
    this.label,
    this.contentPadding,
    this.labelTextColor,
    this.labelFontSize,
    this.fontSize,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.borderSide,
    this.borderSideError,
    this.isPassword,
    this.expanded,
    this.autofocus,
    this.maxLine,
    this.margin,
    this.cursorHeight,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(bottom: 16.h),
      child: ReactiveTextField(
        formControlName: formControlName,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        validationMessages: validationMessages,
        cursorColor: AppColors.primaryColor,
        cursorHeight: cursorHeight ?? 16.h,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        onTap: onTap,
        obscureText: isPassword ?? false,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: fontSize ?? 13.sp,
          fontFamily: "IBMPlexSansArabic",
        ),
        decoration: InputDecoration(
          fillColor: fillColor ?? AppColors.greySwatch.shade50,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: hintFontSize ?? 12.sp,
            color: hintTextColor ?? Colors.black,
            fontWeight: FontWeight.w400,
            fontFamily: "IBMPlexSansArabic",
          ),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: labelFontSize ?? 10.5.sp,
            color: labelTextColor ?? Colors.black,
            fontWeight: FontWeight.w400,
            fontFamily: "IBMPlexSansArabic",
          ),
          border: InputBorder.none,
          errorBorder: OutlineInputBorder(
            borderSide: borderSideError ??
                BorderSide(
                  color: AppColors.greySwatch.shade200,
                  width: 0.5,
                ),
            borderRadius: BorderRadius.circular(4.sp),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: borderSide ??
                BorderSide(
                  color: AppColors.greySwatch.shade200,
                  width: 0.5,
                ),
            borderRadius: BorderRadius.circular(4.sp),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: borderSide ??
                BorderSide(
                  color: AppColors.greySwatch.shade200,
                  width: 0.5,
                ),
            borderRadius: BorderRadius.circular(4.sp),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: borderSide ??
                BorderSide(
                  color: AppColors.greySwatch.shade200,
                  width: 0.5,
                ),
            borderRadius: BorderRadius.circular(4.sp),
          ),
          prefixIcon: prefix,
          suffixIcon: suffix,
          contentPadding: EdgeInsets.all(contentPadding ?? 12.sp),
        ),
        expands: expanded ?? false,
        textAlign: TextAlign.start,
      ),
    );
  }
}
