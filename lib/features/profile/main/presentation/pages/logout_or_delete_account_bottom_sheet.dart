import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/auth/auth.dart';
import '../riverpod/profile_riverpod.dart';

class LogoutOrDeleteAccountBottomSheet extends ConsumerWidget {
  final bool deleteAccount;
  final VoidCallback? onSuccess;

  const LogoutOrDeleteAccountBottomSheet({
    super.key,
    this.deleteAccount = false,
    this.onSuccess,
  });

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(logoutProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          20.h.verticalSpace,
          SvgPicture.asset(
            AppIcons.warning,
            width: 80.w,
          ),
          20.h.verticalSpace,
          AutoSizeTextWidget(
            text: deleteAccount
                ? S.of(context).deleteAccount
                : S.of(context).signOut,
            fontSize: 16.sp,
            colorText: AppColors.secondaryColor,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text: deleteAccount
                ? S.of(context).deleteAccountConfirmation
                : S.of(context).doYouReallyWantToSignOut,
            colorText: AppColors.fontColor2,
            fontSize: 12.5.sp,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          24.h.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: CheckStateInPostApiDataWidget(
                  state: state,
                  messageSuccess: S.of(context).logoutSuccessfully,
                  functionSuccess: ()  {
                     Auth().logout();
                    Navigator.of(context).pop();
                     onSuccess?.call();
                  },
                  bottonWidget: DefaultButtonWidget(
                    text: deleteAccount
                        ? S.of(context).deleteAccount
                        : S.of(context).signOut,
                    height: 38.h,
                    borderRadius: 12.sp,
                    textSize: 12.sp,
                    background: Colors.transparent,
                    textColor: AppColors.secondaryColor,
                    border: Border.all(color: AppColors.secondaryColor),
                    isLoading: state.stateData == States.loading,
                    onPressed: () {
                      if (deleteAccount) {
                      } else {
                        ref.read(logoutProvider.notifier).logout();
                      }
                    },
                  ),
                ),
              ),
              12.w.horizontalSpace,
              Expanded(
                child: DefaultButtonWidget(
                  text: S.of(context).cancel,
                  height: 38.h,
                  borderRadius: 12.sp,
                  textSize: 12.sp,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          12.h.verticalSpace,
        ],
      ),
    );
  }
}
