import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../generated/l10n.dart';
import '../riverpod/user_riverpod.dart';
import '../widgets/app_bar_to_user_widget.dart';
import '../widgets/view_phone_ number_or_email_widget.dart';
import 'verify_code_page.dart';

class ForgetPasswordPage extends ConsumerWidget {
  final String phoneNumberOrEmail;
  final String title;

  final formKey = GlobalKey<FormState>();

  ForgetPasswordPage({
    super.key,
    required this.phoneNumberOrEmail,
    required this.title,
  });

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(userProvider);

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
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AppImages.logoWithText,
                  width: 200.w,
                ),
              ),
              24.h.verticalSpace,
              AutoSizeTextWidget(
                text: "forgotYourPassword",
                fontSize: 14.5.sp,
                fontWeight: FontWeight.w600,
              ),
              8.h.verticalSpace,
              ViewPhoneNumberOrEmailWidget(
                email: phoneNumberOrEmail,
                title: title,
                editIcon: false,
              ),
              34.h.verticalSpace,
              CheckStateInPostApiDataWidget(
                state: state,
                hasMessageSuccess: false,
                functionSuccess: () {
                  navigateReplacement(
                    context,
                    VerifyCodePage(
                      phoneNumberOrEmail: phoneNumberOrEmail,
                      verifyCodeWhenYouForgetYourPass: true,
                    ),
                  );
                },
                bottonWidget: DefaultButtonWidget(
                  text: S.of(context).confirm,
                  height: 43.h,
                  textSize: 14.sp,
                  isLoading: state.stateData == States.loading,
                  onPressed: () {
                    final isValid = formKey.currentState!.validate();

                    if (isValid) {
                      ref.read(userProvider.notifier).forgetPassword(
                            phoneNumberOrEmail: phoneNumberOrEmail,
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
