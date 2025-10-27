import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';

class TextFormFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? type;
  final Color? fillColor;
  final bool? isPassword;
  final double? fontSizeText;
  final String? label;
  final String? hintText;
  final Color? hintTextColor;
  final Color? labelTextColor;
  final double? hintFontSize;
  final double? labelFontSize;
  final TextAlign? textAlign;
  final BorderSide? borderSide;
  final BorderSide? borderSideError;
  final FormFieldValidator? fieldValidator;
  final ValueChanged? onSubmit;
  final ValueChanged<String>? onChanged;
  final Function()? onTap;
  final Widget? prefix;
  final Widget? suffixIcon;
  final bool? expanded;
  final bool? autofocus;
  final int? maxLine;
  final int? maxLength;
  final Color? counterColor;
  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final bool preserveFocusOnResume;
  final bool underlineInputBorder;
  final bool? buildCounter;

  const TextFormFieldWidget({
    super.key,
    required this.controller,
    this.type,
    this.fillColor,
    this.fontSizeText,
    this.hintText,
    this.hintTextColor,
    this.hintFontSize,
    this.label,
    this.labelTextColor,
    this.labelFontSize,
    this.textAlign,
    this.borderSide,
    this.borderSideError,
    this.fieldValidator,
    this.isPassword,
    this.prefix,
    this.suffixIcon,
    this.expanded,
    this.autofocus,
    this.maxLine,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.onSubmit,
    this.cursorColor,
    this.contentPadding,
    this.counterColor,
    this.focusNode,
    this.preserveFocusOnResume = true,
    this.underlineInputBorder = false,
    this.buildCounter = true,

  });

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget>
    with WidgetsBindingObserver {
  FocusNode? _internalFocus;

  FocusNode get _focus => widget.focusNode ?? _internalFocus!;

  bool _wasFocused = false;

  @override
  void initState() {
    super.initState();
    if (widget.preserveFocusOnResume) {
      WidgetsBinding.instance.addObserver(this);
    }
    _internalFocus ??= widget.focusNode ?? FocusNode();
    _focus.addListener(() {
      _wasFocused = _focus.hasFocus;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!widget.preserveFocusOnResume) return;
    if (state == AppLifecycleState.resumed && _wasFocused && mounted) {
      Future.microtask(() {
        if (!mounted) return;
        FocusScope.of(context).requestFocus(_focus);
        SystemChannels.textInput.invokeMethod('TextInput.show');
      });
    }
  }

  @override
  void dispose() {
    if (widget.preserveFocusOnResume) {
      WidgetsBinding.instance.removeObserver(this);
    }
    if (widget.focusNode == null) {
      _internalFocus?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focus,
      maxLines: widget.maxLine ?? 1,
      maxLength: widget.maxLength,
      buildCounter: widget.buildCounter == true
          ? null
          : (
          BuildContext context, {
            required int currentLength,
            required int? maxLength,
            required bool isFocused,
          }) {
        return null;
      },
      controller: widget.controller,
      keyboardType: widget.type ?? TextInputType.text,
      validator: widget.fieldValidator,
      obscureText: widget.isPassword ?? false,
      autofocus: widget.autofocus ?? false,
      onFieldSubmitted: widget.onSubmit,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      cursorColor: widget.cursorColor ?? AppColors.primaryColor,
      style: TextStyle(
        fontSize: widget.fontSizeText ?? 12.5.sp,
        fontFamily: "IBMPlexSansArabic",
      ),
      decoration: InputDecoration(
        fillColor: widget.fillColor ?? Colors.white,
        filled: true,
        hintText: widget.hintText,
        labelText: widget.label,
        counterStyle: TextStyle(
            color: widget.counterColor ?? Colors.white,
            fontWeight: FontWeight.w400,
            fontFamily: "IBMPlexSansArabic"),
        hintStyle: TextStyle(
          fontSize: widget.hintFontSize ?? 10.8.sp,
          color: widget.hintTextColor ?? AppColors.fontColor2,
          fontWeight: FontWeight.w400,
          fontFamily: "IBMPlexSansArabic",
        ),
        labelStyle: TextStyle(
          fontSize: widget.labelFontSize ?? 10.8.sp,
          color: widget.labelTextColor ?? AppColors.fontColor2,
          fontWeight: FontWeight.w400,
          fontFamily: "IBMPlexSansArabic",
        ),
        border: widget.underlineInputBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor),
              )
            : InputBorder.none,
        errorBorder: widget.underlineInputBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.dangerColor),
              )
            : OutlineInputBorder(
                borderSide: widget.borderSideError ?? BorderSide.none,
                borderRadius: BorderRadius.circular(8.r),
              ),
        focusedErrorBorder: widget.underlineInputBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.dangerColor),
              )
            : OutlineInputBorder(
                borderSide: widget.borderSideError ?? BorderSide.none,
                borderRadius: BorderRadius.circular(8.r),
              ),
        focusedBorder: widget.underlineInputBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor),
              )
            : OutlineInputBorder(
                borderSide: widget.borderSide ?? BorderSide.none,
                borderRadius: BorderRadius.circular(8.r),
              ),
        enabledBorder: widget.underlineInputBorder
            ? UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor),
              )
            : OutlineInputBorder(
                borderSide: widget.borderSide ?? BorderSide.none,
                borderRadius: BorderRadius.circular(8.r),
              ),
        prefixIcon: widget.prefix,
        suffixIcon: widget.suffixIcon,
        contentPadding: widget.contentPadding ?? EdgeInsets.all(11.sp),
      ),
      expands: widget.expanded ?? false,
      textAlign: widget.textAlign ?? TextAlign.start,
    );
  }
}
