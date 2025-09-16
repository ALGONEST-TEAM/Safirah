import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../widgets/app_bar_to_user_widget.dart';
import 'verify_code_page.dart';

class ForgetPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarToUserWidget(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(14.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              18.h.verticalSpace,
              AutoSizeTextWidget(
                text: "forgotYourPassword",
                fontSize: 14.5.sp,
                fontWeight: FontWeight.w600,
              ),
              14.h.verticalSpace,
              AutoSizeTextWidget(
                text:"phoneNumberOrEmail",
                fontSize: 13.sp,
                colorText: Colors.black87,
              ),
              4.h.verticalSpace,
              TextFormFieldWidget(
                controller: emailController,
                borderSide: const BorderSide(
                  color: Colors.black26,
                ),
                borderSideError: const BorderSide(
                  color: AppColors.primaryColor,
                ),
                fieldValidator: (value) {
                  if (value == null || value.toString().isEmpty) {
                    return "pleaseEnterYourPhoneNumberOrEmail";
                  }
                },
              ),
              24.h.verticalSpace,
              DefaultButtonWidget(
                text: S.of(context).confirm,
                height: 43.h,
                textSize: 14.sp,
                onPressed: () {
                  final isValid = formKey.currentState!.validate();

                  if (isValid) {
                    navigateTo(
                        context,
                        VerifyCodePage(
                          phoneNumberOrEmail: '',
                        ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
