import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../../generated/l10n.dart';

class ConditionsForInputThePasswordWidget extends StatefulWidget {
  final TextEditingController passwordController;
  final ValueChanged<bool> onValidationChanged;
  final BorderSide? borderSide;
  final String? hintText;
  final double? fontSize;

  const ConditionsForInputThePasswordWidget({
    super.key,
    required this.onValidationChanged,
    required this.passwordController,
    this.borderSide,
    this.hintText = '',
    this.fontSize,
  });

  @override
  State<ConditionsForInputThePasswordWidget> createState() =>
      _ConditionsForInputThePasswordWidgetState();
}

class _ConditionsForInputThePasswordWidgetState
    extends State<ConditionsForInputThePasswordWidget> {
  bool isLengthValid = false;
  bool hasLetter = false;
  bool hasNumber = false;
  bool isFirstInput = true;
  bool isShow = true;

  void validatePassword(String password) {
    setState(() {
      isFirstInput = false;
      isLengthValid = password.length >= 8;
      hasLetter = password.contains(RegExp(r'[A-Za-z]'));
      hasNumber = password.contains(RegExp(r'[0-9]'));
      widget.onValidationChanged(isFormValid);
    });
  }

  bool get isFormValid => isLengthValid && hasLetter && hasNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormFieldWidget(
          controller: widget.passwordController,
          onChanged: validatePassword,
          hintText: widget.hintText,
          hintTextColor: Colors.black87,
          borderSide: widget.borderSide ??
              const BorderSide(
                color: Colors.black26,
              ),
          borderSideError: widget.borderSide ??
              const BorderSide(
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
        ),
        6.h.verticalSpace,
        buildRequirementText(
          "atLeast8Characters",
          isLengthValid,
          fontSize: widget.fontSize,
        ),
        buildRequirementText(
          "atLeastOneLetter",
          hasLetter,
          fontSize: widget.fontSize,

        ),
        buildRequirementText(
          "atLeastOneNumber",
          hasNumber,
          fontSize: widget.fontSize,

        ),
      ],
    );
  }

  Widget buildRequirementText(String text, bool isValid,{double? fontSize}) {
    Color color = isFirstInput
        ? Colors.black
        : (isValid ? Colors.green : AppColors.primarySwatch.shade600);

    return Padding(
      padding: EdgeInsets.only(bottom: 3.5.h),
      child: AutoSizeTextWidget(
        text: text,
        colorText: color,
        fontSize:fontSize?? 10.5.sp,
      ),
    );
  }
}
