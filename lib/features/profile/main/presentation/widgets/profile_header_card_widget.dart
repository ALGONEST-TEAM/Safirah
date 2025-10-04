import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import '../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/auth/auth.dart';
import '../../../../user/presentation/pages/log_in_page.dart';
import '../pages/logout_or_delete_account_bottom_sheet.dart';

class ProfileHeaderCardWidget extends StatelessWidget {
  final VoidCallback? onLogoutSuccess;

  const ProfileHeaderCardWidget({super.key, this.onLogoutSuccess});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!Auth().loggedIn) {
          navigateTo(context, const LogInPage());
        }
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.symmetric(
          horizontal: 6.w,
          vertical: !Auth().loggedIn ? 13.h : 10.h,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        child: Visibility(
          visible: Auth().loggedIn,
          replacement: AutoSizeTextWidget(
            text: S.of(context).logIn,
            colorText: AppColors.primaryColor,
            fontSize: 13.sp,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeTextWidget(
                        text: Auth().name,
                      ),
                      4.h.verticalSpace,
                      AutoSizeTextWidget(
                        text: Auth().phoneNumber,
                        colorText: AppColors.primaryColor,
                        fontSize: 11.sp,
                      ),
                    ],
                  ),
                ),
              ),
              InkWellButtonWidget(
                icon: AppIcons.logout,
                iconColor: const Color(0xffbfc8c6),
                onPressed: () {
                  showModalBottomSheetWidget(
                    context: context,
                    page: LogoutOrDeleteAccountBottomSheet(
                      onSuccess: onLogoutSuccess,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
