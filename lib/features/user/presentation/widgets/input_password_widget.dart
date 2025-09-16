import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../core/widgets/text_form_field.dart';

class InputPasswordWidget extends StatefulWidget {
  final String title;
  final String validator;
  final TextEditingController passwordController;

  const InputPasswordWidget({
    super.key,
    required this.passwordController,
    required this.title,
    required this.validator,
  });

  @override
  State<InputPasswordWidget> createState() => _InputPasswordWidgetState();
}

class _InputPasswordWidgetState extends State<InputPasswordWidget> {
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        6.h.verticalSpace,
        AutoSizeTextWidget(
          text: widget.title,
          fontSize: 13.sp,
          colorText: Colors.black87,
        ),
        6.h.verticalSpace,
        TextFormFieldWidget(
          controller: widget.passwordController,
          borderSide: const BorderSide(
            color: Colors.black26,
          ),
          borderSideError: const BorderSide(
            color: AppColors.primaryColor,
          ),
          isPassword: isShow,
          suffixIcon: IconButtonWidget(
            onPressed: () {
              setState(() {
                isShow = !isShow;
              });
            },
            iconColor: AppColors.primaryColor,
          ),
          fieldValidator: (value) {
            if (value == null || value.toString().isEmpty) {
              return widget.validator;
            }
          },
        ),
      ],
    );
  }
}
