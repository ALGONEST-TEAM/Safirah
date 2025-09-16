import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../riverpod/user_riverpod.dart';
import '../widgets/exclusive_discount_and_benefits_widget.dart';
import '../widgets/conditions_for_input_the_password_widget.dart';
import '../widgets/receive_newsletters_widget.dart';
import '../widgets/view_phone_ number_or_email_widget.dart';
import 'verify_code_page.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(checkUserProvider);
    var signUpState = ref.watch(logInOrSignUpProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 36.h,
        leading: IconButtonWidget(
          icon: AppIcons.arrowBack,
          iconColor: AppColors.primaryColor,
          height: 30.h,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ViewPhoneNumberOrEmailWidget(
              email: state.data.input,
              title: state.data.type,
            ),
            10.h.verticalSpace,
            AutoSizeTextWidget(
              text: "name",
              fontSize: 13.sp,
              colorText: Colors.black87,
            ),
            6.h.verticalSpace,
            TextFormFieldWidget(
              controller: _nameController,
              borderSide: const BorderSide(
                color: Colors.black26,
              ),
              borderSideError: const BorderSide(
                color: AppColors.primaryColor,
              ),
              fieldValidator: (value) {
                if (value == null || value.toString().isEmpty) {
                  return S.of(context).pleaseEnterYourName;
                }
              },
            ),
            10.h.verticalSpace,
            AutoSizeTextWidget(
              text: "password",
              fontSize: 13.sp,
              colorText: Colors.black87,
            ),
            6.h.verticalSpace,
            ConditionsForInputThePasswordWidget(
              passwordController: _passwordController,
              onValidationChanged: (isValid) {
                setState(() {
                  isPasswordValid = isValid;
                });
              },
            ),
            const ReceiveNewslettersWidget(),
            CheckStateInPostApiDataWidget(
              state: signUpState,
              hasMessageSuccess: false,
              functionSuccess: () {
                navigateTo(
                    context,
                    VerifyCodePage(
                      phoneNumberOrEmail: state.data.input,
                    ));
              },
              bottonWidget: DefaultButtonWidget(
                text: "signUp",
                height: 42.h,
                textSize: 13.sp,
                isLoading: signUpState.stateData == States.loading,
                onPressed: isPasswordValid
                    ? () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        ref.read(logInOrSignUpProvider.notifier).logInOrSignUp(
                              name: _nameController.text,
                              phoneNumberOrEmail: state.data.input,
                              password: _passwordController.text,
                            );
                      }
                    : null,
              ),
            ),
            14.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}
