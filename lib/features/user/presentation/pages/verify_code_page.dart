import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../riverpod/user_riverpod.dart';
import '../widgets/resend_code_widget.dart';
import '../widgets/verify_pinput_widget.dart';
import 'sign_up_page.dart';

class VerifyCodePage extends ConsumerStatefulWidget {
  final String phoneNumber;

  const VerifyCodePage({
    super.key,
    required this.phoneNumber,
  });

  @override
  ConsumerState<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends ConsumerState<VerifyCodePage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController verifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var checkOTPState = ref.watch(checkOTPProvider);

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(
              text: "${S.of(context).codeHasBeenSendTo} ${widget.phoneNumber}",
              fontSize: 11.4.sp,
              fontWeight: FontWeight.w600,
              colorText: AppColors.fontColor,
            ),
            24.h.verticalSpace,
            VerifyPinputWidget(
              verifyController: verifyController,
            ),
            24.h.verticalSpace,
            ResendCodeWidget(
              phoneNumberOrEmail: widget.phoneNumber,
            ),
            24.h.verticalSpace,
            CheckStateInPostApiDataWidget(
              state: checkOTPState,
              hasMessageSuccess:
                  checkOTPState.data.status == true ? true : false,
              messageSuccess: S.of(context).loginSuccessful,
              functionSuccess: () async {
                if (checkOTPState.data.status == true) {
                  Auth().login(checkOTPState.data);
                  navigateAndFinish(context, const BottomNavigationBarWidget());
                } else {
                  Navigator.of(context).pop();
                  navigateTo(context, const SignUpPage());
                }
              },
              bottonWidget: DefaultButtonWidget(
                text: S.of(context).confirm,
                background: AppColors.primaryColor,
                textSize: 14.4.sp,
                height: 40.h,
                isLoading: checkOTPState.stateData == States.loading,
                onPressed: () async {
                  final isValid = formKey.currentState!.validate();
                  if (isValid) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    ref.read(checkOTPProvider.notifier).checkOTP(
                          phoneNumber: widget.phoneNumber,
                          otp: verifyController.text,
                        );
                  }
                },
              ),
            ),
            24.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}
