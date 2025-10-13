import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safirah/features/profile/presentation/riverpod/setting_riverpod.dart';
import 'package:safirah/services/auth/auth.dart';
import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../core/widgets/text_form_field.dart';
import 'verify_phone_change_widget.dart';

class ChangePhoneNumberWidget extends ConsumerStatefulWidget {
  final VoidCallback? phoneNumberOnSuccess;

  const ChangePhoneNumberWidget( {super.key,this.phoneNumberOnSuccess});

  @override
  ConsumerState<ChangePhoneNumberWidget> createState() =>
      _ChangePhoneNumberWidgetState();
}

class _ChangePhoneNumberWidgetState
    extends ConsumerState<ChangePhoneNumberWidget> {
  bool isPasswordValid = false;
  bool passwordDoNotMatch = false;

  TextEditingController phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(changePhoneNumberProvider);
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeTextWidget(
              text: S.of(context).phoneNumberCurrent,
              fontSize: 11.6.sp,
              colorText: AppColors.mainColorFont,
            ),
            6.h.verticalSpace,
            Container(
              height: 40.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.scaffoldColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppIcons.phone,
                    height: 18.6.h,
                    color: AppColors.primaryColor,
                  ),
                  10.w.horizontalSpace,
                  AutoSizeTextWidget(
                    text: Auth().phoneNumber,
                    fontSize: 12.6.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            12.h.verticalSpace,
            AutoSizeTextWidget(
              text: S.of(context).phoneNumberNew,
              fontSize: 11.6.sp,
              colorText: AppColors.mainColorFont,
            ),
            6.h.verticalSpace,
            TextFormFieldWidget(
              controller: phoneNumberController,
              type: TextInputType.phone,
              hintText: S.of(context).enterPhoneNumber,
              fillColor: AppColors.scaffoldColor,
              maxLength: 9,
              fieldValidator: (value) {
                if (value == null || value.toString().isEmpty) {
                  return S.of(context).pleaseEnterPhoneNumber;
                }
                final phone = value.trim();
                if (!phone.startsWith('7')) {
                  return S.of(context).phoneMustStartWith7;
                }
                if (phone.length < 9) {
                  return S.of(context).phoneMustBe9Digits;
                }
                return null;
              },
              prefix: Padding(
                padding: EdgeInsets.all(11.sp),
                child: SvgPicture.asset(
                  AppIcons.phone,
                  height: 14.h,
                  color: AppColors.primaryColor,
                ),
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.only(
                  left: 12.w,
                  right: 12.w,
                  top: 14.h,
                  bottom: 12.h,
                ),
                child: AutoSizeTextWidget(
                  text: "967+",
                  colorText: AppColors.primaryColor,
                  fontSize: 12.sp,
                ),
              ),
            ),
            12.h.verticalSpace,
            CheckStateInPostApiDataWidget(
              state: state,
              messageSuccess:
              "${S.of(context).codeHasBeenSendTo} ${phoneNumberController.text}",
              functionSuccess: () {
                Navigator.of(context).pop();
                scrollShowModalBottomSheetWidget(
                  title: S.of(context).verificationCode,
                  fontSize: 15.6.sp,
                  context: context,
                  page: VerifyPhoneChangeWidget(
                    phoneNumber: phoneNumberController.text,
                    phoneNumberOnSuccess: widget.phoneNumberOnSuccess,
                  ),
                );
              },
              bottonWidget: DefaultButtonWidget(
                text: S.of(context).confirm,
                textSize: 13.4.sp,
                height: 40.h,
                isLoading: state.stateData == States.loading,
                onPressed: () {
                  final isValid = formKey.currentState!.validate();

                  if (isValid) {
                    ref
                        .read(changePhoneNumberProvider.notifier)
                        .changePhoneNumber(
                          phoneNumber: phoneNumberController.text,
                          otp: '',
                        );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
