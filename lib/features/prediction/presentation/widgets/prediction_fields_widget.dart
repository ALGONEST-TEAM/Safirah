import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/text_form_field.dart';

class PredictionFieldsWidget extends StatelessWidget {
  final TextEditingController homeController;
  final TextEditingController awayController;

  const PredictionFieldsWidget({
    super.key,
    required this.homeController,
    required this.awayController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormFieldWidget(
            controller: homeController,
            textAlign: TextAlign.center,
            type: TextInputType.number,
            fontSizeText: 16.sp,
            maxLength: 2,
            buildCounter: false,
            hintText: "0",
            hintFontSize: 15.sp,
            underlineInputBorder: true,
            fieldValidator:(value) {
              if (value == null || value.trim().isEmpty) {
                return 'الرجاء إدخال النتيجة';
              }
              return null;
            },
          ),
        ),
        74.w.horizontalSpace,
        Expanded(
          child: TextFormFieldWidget(
            controller: awayController,
            textAlign: TextAlign.center,
            type: TextInputType.number,
            fontSizeText: 16.sp,
            maxLength: 2,
            buildCounter: false,
            hintText: "0",
            hintFontSize: 15.sp,
            underlineInputBorder: true,
            fieldValidator:(value) {
              if (value == null || value.trim().isEmpty) {
                return 'الرجاء إدخال النتيجة';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
