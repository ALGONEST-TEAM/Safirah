import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../generated/l10n.dart';
import '../riverpod/user_riverpod.dart';
import '../widgets/app_bar_to_user_widget.dart';
import '../widgets/input_password_widget.dart';
import '../widgets/receive_newsletters_widget.dart';
import '../widgets/view_phone_ number_or_email_widget.dart';
import 'forget_password_dialog.dart';
import 'verify_code_page.dart';

class ContinueToLogInPage extends ConsumerStatefulWidget {
  const ContinueToLogInPage({super.key});

  @override
  ConsumerState<ContinueToLogInPage> createState() =>
      _ContinueToLogInPageState();
}

class _ContinueToLogInPageState extends ConsumerState<ContinueToLogInPage> {
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(checkUserProvider);
    var logInState = ref.watch(logInOrSignUpProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarToUserWidget(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              8.h.verticalSpace,
              10.h.verticalSpace,
              ViewPhoneNumberOrEmailWidget(
                email: state.data.input,
                title: state.data.type,
              ),
              8.h.verticalSpace,
              InputPasswordWidget(
                title: "paas",
                validator:"pleaseEnterYourPassword",
                passwordController: passwordController,
              ),
              6.h.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      navigateTo(
                        context,
                        ForgetPasswordPage(
                          phoneNumberOrEmail: state.data.input,
                          title: state.data.type,
                        ),
                      );
                    },
                    child: AutoSizeTextWidget(
                      text:"forgotYourPassword",
                      fontSize: 9.4.sp,
                      colorText: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              10.h.verticalSpace,
              const ReceiveNewslettersWidget(),
              CheckStateInPostApiDataWidget(
                state: logInState,
                hasMessageSuccess: false,
                functionSuccess: () {
                  navigateTo(
                      context,
                      VerifyCodePage(
                        phoneNumberOrEmail: state.data.input,
                      ));
                },
                bottonWidget: DefaultButtonWidget(
                  text: S.of(context).logIn,
                  height: 42.h,
                  textSize: 13.sp,
                  isLoading: logInState.stateData == States.loading,
                  onPressed: () {
                    final isValid = formKey.currentState!.validate();
                    if (isValid) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ref.read(logInOrSignUpProvider.notifier).logInOrSignUp(
                            name: "",
                            phoneNumberOrEmail: state.data.input,
                            password: passwordController.text,
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
