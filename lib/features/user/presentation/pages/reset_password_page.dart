import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../generated/l10n.dart';
import '../riverpod/user_riverpod.dart';
import '../widgets/app_bar_to_user_widget.dart';
import '../widgets/conditions_for_input_the_password_widget.dart';
import '../widgets/input_password_widget.dart';

class ResetPasswordPage extends ConsumerStatefulWidget {
  final String phoneNumberOrEmail;

  const ResetPasswordPage({
    super.key,
    required this.phoneNumberOrEmail,
  });

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  bool isPasswordValid = false;
  bool passwordDoNotMatch = false;

  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              AutoSizeTextWidget(
                text: "newPassword:",
                fontSize: 13.sp,
                colorText: Colors.black87,
              ),
              6.h.verticalSpace,
              ConditionsForInputThePasswordWidget(
                passwordController: newPasswordController,
                onValidationChanged: (isValid) {
                  setState(() {
                    isPasswordValid = isValid;
                  });
                },
              ),
              8.h.verticalSpace,
              InputPasswordWidget(
                title: "confirmPassword:",
                validator: "pleaseConfirmYourPassword",
                passwordController: confirmPasswordController,
              ),
              2.h.verticalSpace,
               Visibility(
                 visible: passwordDoNotMatch,
                 child: AutoSizeTextWidget(
                  text: "passwordDoNotMatch",
                  fontSize: 11.sp,
                  colorText: AppColors.secondarySwatch.shade500,
                               ),
               ),
              28.h.verticalSpace,
              CheckStateInPostApiDataWidget(
                state: state,
                messageSuccess: S.of(context).thePasswordHasBeenChanged,
                functionSuccess: () {
                  Navigator.pop(context);
                },
                bottonWidget: DefaultButtonWidget(
                  text: S.of(context).confirm,
                  height: 43.h,
                  textSize: 14.sp,
                  isLoading: state.stateData == States.loading,
                  onPressed: isPasswordValid
                      ? () {
                          final isValid = formKey.currentState!.validate();

                          if (isValid) {
                            if(newPasswordController.text!=confirmPasswordController.text){
                              setState(() {
                                passwordDoNotMatch=true;
                              });
                            }else{
                              setState(() {
                                passwordDoNotMatch=false;
                              });
                              FocusManager.instance.primaryFocus?.unfocus();
                              ref.read(userProvider.notifier).resetPassword(
                                phoneNumberOrEmail: widget.phoneNumberOrEmail,
                                password: newPasswordController.text,
                                confirmPassword:
                                confirmPasswordController.text,
                              );
                            }

                          }
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
