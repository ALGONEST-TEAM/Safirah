import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/features/user/presentation/pages/reset_password_page.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../riverpod/user_riverpod.dart';
import '../widgets/app_bar_to_user_widget.dart';
import '../widgets/resend_code_widget.dart';
import '../widgets/verify_pinput_widget.dart';

class VerifyCodePage extends ConsumerWidget {
  final String phoneNumberOrEmail;
  final bool? verifyCodeWhenYouForgetYourPass;

  VerifyCodePage({
    super.key,
    required this.phoneNumberOrEmail,
    this.verifyCodeWhenYouForgetYourPass = false,
  });

  final formKey = GlobalKey<FormState>();

  TextEditingController verifyController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    var checkOTPState = ref.watch(checkOTPProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarToUserWidget(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(14.sp),
          child: Column(
            children: [
              18.h.verticalSpace,
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.logoWithText,
                  width: 200.w,
                ),
              ),
              34.h.verticalSpace,
              AutoSizeTextWidget(
                text:
                    "${S.of(context).codeHasBeenSendTo} ${phoneNumberOrEmail.substring(0, 3)}******",
                fontSize: 14.5.sp,
                maxLines: 2,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
              ),
              34.h.verticalSpace,
              VerifyPinputWidget(
                verifyController: verifyController,
              ),
              34.h.verticalSpace,
              ResendCodeWidget(
                phoneNumberOrEmail: phoneNumberOrEmail,
              ),
              34.h.verticalSpace,
              CheckStateInPostApiDataWidget(
                state: checkOTPState,
                hasMessageSuccess: false,
                functionSuccess: () {
                  if (verifyCodeWhenYouForgetYourPass == true) {
                    navigateReplacement(
                      context,
                      ResetPasswordPage(
                        phoneNumberOrEmail: phoneNumberOrEmail,
                      ),
                    );
                  } else {
                    Auth().login(checkOTPState.data);
                    navigateAndFinish(
                      context,
                      const BottomNavigationBarWidget(),
                    );
                  }
                },
                bottonWidget: DefaultButtonWidget(
                  text: S.of(context).confirm,
                  height: 44.h,
                  textSize: 14.sp,
                  isLoading: checkOTPState.stateData == States.loading,
                  onPressed: () async {
                    final isValid = formKey.currentState!.validate();
                    if (isValid) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ref.read(checkOTPProvider.notifier).checkOTP(
                            phoneNumberOrEmail: phoneNumberOrEmail,
                            otp: verifyController.text,
                          );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
