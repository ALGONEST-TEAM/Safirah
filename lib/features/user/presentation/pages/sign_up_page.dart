import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../riverpod/user_riverpod.dart';
import '../widgets/birth_date_picker_widget.dart';
import '../widgets/city_widget.dart';
import '../widgets/gender_selection_widget.dart';
import '../widgets/name_and_email_widget.dart';
import '../widgets/sign_up_header_widget.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(checkOTPProvider);
    var signUpState = ref.watch(signUpProvider);
    final birthDate = ref.watch(birthDateProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.scaffoldColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppColors.scaffoldColor,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const SignUpAppBarWidget(),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignUpHeaderWidget(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(
                    children: [
                      NameAndEmailWidget(
                        name: _nameController,
                        email: _emailController,
                      ),
                      const BirthDatePickerWidget(),
                      12.h.verticalSpace,
                      const GenderPickerWidget(),
                      const CityWidget(),
                      26.h.verticalSpace,
                      CheckStateInPostApiDataWidget(
                        state: signUpState,
                        messageSuccess:
                            S.of(context).accountCreatedSuccessfully,
                        functionSuccess: () {
                          Auth().login(signUpState.data);
                          navigateAndFinish(
                              context, const BottomNavigationBarWidget());
                        },
                        bottonWidget: DefaultButtonWidget(
                          text: S.of(context).createAccount,
                          textSize: 13.6.sp,
                          isLoading: signUpState.stateData == States.loading,
                          onPressed: () {
                            final isValid = formKey.currentState!.validate();
                            final selectedCity = ref.read(selectedCityProvider);

                            bool hasError = false;
                            if (selectedCity == null) {
                              ref
                                  .read(selectedCityErrorProvider.notifier)
                                  .state = S.of(context).pleaseChoseACity;
                              hasError = true;
                            } else {
                              ref
                                  .read(selectedCityErrorProvider.notifier)
                                  .state = null;
                            }

                            if (!isValid || hasError) return;
                            if (!isValid) return;

                            FocusManager.instance.primaryFocus?.unfocus();

                            final selectedGender = ref.read(genderProvider);
                            print( state.data.user.phoneNumber);
                            ref.read(signUpProvider.notifier).logInOrSignUp(
                                  phoneNumber: state.data.user.phoneNumber,
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  gender: selectedGender.toString(),
                                  cityId: selectedCity!.id,
                                  dateOfBirth: birthDate,
                                );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
