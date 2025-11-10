import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../../../notifications/presentation/state_mangment/notifications_riverpod.dart';
import '../riverpod/user_riverpod.dart';
import '../widgets/resend_code_widget.dart';
import '../widgets/verify_pinput_widget.dart';
import 'sign_up_page.dart';

class VerifyCodePage extends ConsumerStatefulWidget {
  final String phoneNumber;

  const VerifyCodePage({super.key, required this.phoneNumber});

  @override
  ConsumerState<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends ConsumerState<VerifyCodePage>
    with CodeAutoFill {
  static const _otpLen = 6;

  final TextEditingController _verifyController = TextEditingController();

  bool _canAutoSubmit = true;

  @override
  void initState() {
    super.initState();
    listenForCode();

    _verifyController.addListener(_maybeAutoSubmit);
  }

  @override
  void codeUpdated() {
    final c = code ?? '';
    if (c.isNotEmpty) {
      _verifyController.text = c;
    }
  }

  void _maybeAutoSubmit() async {
    final text = _verifyController.text.trim();
    if (text.length < _otpLen) {
      _canAutoSubmit = true;
      return;
    }
    if (_canAutoSubmit && text.length == _otpLen) {
      _canAutoSubmit = false;
      FocusManager.instance.primaryFocus?.unfocus();
      ref.read(checkOTPProvider.notifier).checkOTP(
            phoneNumber: widget.phoneNumber,
            otp: text,
            fcmToken: await Auth().getFcmToken(),
          );
    }
  }

  @override
  void dispose() {
    cancel();
    _verifyController.removeListener(_maybeAutoSubmit);
    _verifyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final checkOTPState = ref.watch(checkOTPProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${S.of(context).codeHasBeenSendTo} ${widget.phoneNumber}",
            style: TextStyle(fontSize: 11.4.sp, fontWeight: FontWeight.w600),
          ),
          24.h.verticalSpace,
          VerifyPinputWidget(verifyController: _verifyController),
          24.h.verticalSpace,
          ResendCodeWidget(
            phoneNumberOrEmail: widget.phoneNumber,
          ),
          24.h.verticalSpace,
          CheckStateInPostApiDataWidget(
            state: checkOTPState,
            hasMessageSuccess: checkOTPState.data.status == true,
            messageSuccess: S.of(context).loginSuccessful,
            functionSuccess: () async {
              if (checkOTPState.data.status == true) {
                Auth().login(checkOTPState.data);
                navigateAndFinish(context, const BottomNavigationBarWidget());
                ref.read(unreadCountProvider.notifier).refresh();
              } else {
                Navigator.of(context).pop();
                navigateTo(context, const SignUpPage());
              }
            },
            bottonWidget: DefaultButtonWidget(
              text: S.of(context).confirm,
              textSize: 14.4.sp,
              height: 40.h,
              isLoading: checkOTPState.stateData == States.loading,
              onPressed: () async {
                final code = _verifyController.text.trim();
                if (code.length != _otpLen) return;
                FocusManager.instance.primaryFocus?.unfocus();
                ref.read(checkOTPProvider.notifier).checkOTP(
                      phoneNumber: widget.phoneNumber,
                      otp: code,
                      fcmToken: await Auth().getFcmToken(),
                    );
              },
            ),
          ),
          24.h.verticalSpace,
        ],
      ),
    );
  }
}
