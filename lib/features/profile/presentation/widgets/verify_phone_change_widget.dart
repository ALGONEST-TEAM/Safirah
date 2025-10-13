import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../../../user/presentation/widgets/resend_code_widget.dart';
import '../../../user/presentation/widgets/verify_pinput_widget.dart';
import '../riverpod/setting_riverpod.dart';

class VerifyPhoneChangeWidget extends ConsumerStatefulWidget {
  final String phoneNumber;
  final VoidCallback? phoneNumberOnSuccess;

  const VerifyPhoneChangeWidget({
    super.key,
    required this.phoneNumber,
    this.phoneNumberOnSuccess,
  });

  @override
  ConsumerState<VerifyPhoneChangeWidget> createState() =>
      _VerifyPhoneChangeWidgetState();
}

class _VerifyPhoneChangeWidgetState
    extends ConsumerState<VerifyPhoneChangeWidget> {
  final formKey = GlobalKey<FormState>();

  TextEditingController verifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(changePhoneNumberProvider);

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
              state: state,
              messageSuccess: S.of(context).phoneNumberUpdatedSuccess,
              functionSuccess: () async {
                Auth().login(state.data);
                Navigator.of(context).pop();
                widget.phoneNumberOnSuccess?.call();
              },
              bottonWidget: DefaultButtonWidget(
                text: S.of(context).confirm,
                textSize: 14.4.sp,
                height: 40.h,
                isLoading: state.stateData == States.loading,
                onPressed: () async {
                  final isValid = formKey.currentState!.validate();
                  if (isValid) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    ref
                        .read(changePhoneNumberProvider.notifier)
                        .changePhoneNumber(
                          phoneNumber: widget.phoneNumber,
                          otp: verifyController.text,
                        );
                  }
                },
              ),
            ),
            14.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}
