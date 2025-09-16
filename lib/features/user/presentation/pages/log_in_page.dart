import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../../generated/l10n.dart';
import '../riverpod/user_riverpod.dart';
import '../widgets/app_bar_to_user_widget.dart';
import '../widgets/continue_with_google_or_facebook_widget.dart';
import '../widgets/exclusive_discount_and_benefits_widget.dart';
import 'continue_to_log_in_page.dart';
import 'sign_up_page.dart';

class LogInPage extends ConsumerStatefulWidget {
  const LogInPage({super.key});

  @override
  ConsumerState<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends ConsumerState<LogInPage> {
  TextEditingController phoneNumberOrEmailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(checkUserProvider);
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



              14.h.verticalSpace,

              AutoSizeTextWidget(
                text: "phoneNumberOrEmail",
                fontSize: 12.4.sp,
                colorText: Colors.black87,
              ),
              6.h.verticalSpace,

              TextFormFieldWidget(
                controller: phoneNumberOrEmailController,
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
              12.h.verticalSpace,

              CheckStateInPostApiDataWidget(
                state: state,
                hasMessageSuccess: false,
                functionSuccess: () {
                  if (state.data.status == "not exists") {
                    navigateTo(context, const SignUpPage());
                  } else {
                    navigateTo(context, const ContinueToLogInPage());
                  }
                },
                bottonWidget: DefaultButtonWidget(
                  text: S.of(context).following,
                  height: 42.h,
                  textSize: 13.sp,
                  isLoading: state.stateData == States.loading,
                  onPressed: () {
                    final isValid = formKey.currentState!.validate();

                    if (isValid) {
                      FocusManager.instance.primaryFocus?.unfocus();

                      ref.read(checkUserProvider.notifier).checkUser(
                            phoneNumberOrEmail:
                                phoneNumberOrEmailController.text,
                          );
                    }
                  },
                ),
              ),
              22.h.verticalSpace,


            ],
          ),
        ),
      ),
    );
  }
}
