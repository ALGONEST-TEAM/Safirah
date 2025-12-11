import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import 'package:safirah/core/widgets/buttons/default_button.dart';
import 'package:safirah/core/widgets/text_form_field.dart';

class AddMoreRuleWidget extends StatelessWidget {
  const AddMoreRuleWidget({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onAdd,
  });

  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12.r)),
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(text: 'قواعد اضافية', fontSize: 10.sp),
          6.h.verticalSpace,
          TextFormFieldWidget(
            fillColor: const Color(0xffF6F7F9),
            controller: controller,
            maxLine: 3,
            hintText: 'اضافة قاعدة',
          ),
          6.h.verticalSpace,
          DefaultButtonWidget(
            isLoading: isLoading,
            text: 'اضافة قاعدة جديدة',
            background: const Color(0xffEDF0FF),
            textColor: const Color(0xff1D1750),
            onPressed: onAdd,
          ),
        ],
      ),
    );
  }
}
