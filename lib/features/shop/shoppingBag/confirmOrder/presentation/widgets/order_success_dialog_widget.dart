import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';

class OrderSuccessDialogWidget extends ConsumerWidget {
  const OrderSuccessDialogWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.sp),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 88.h,
            width: 94.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.secondaryColor,
                  AppColors.secondarySwatch.shade900,
                  AppColors.secondarySwatch.shade700,
                  AppColors.secondarySwatch.shade600.withOpacity(.92),
                ],
              ),
            ),
            child: Icon(
              Icons.check_sharp,
              color: Colors.white,
              size: 38.sp,
            ),
          ),
          14.h.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).transactionSuccessful,
            fontSize: 15.sp,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text: S
                .of(context)
                .yourOrderHasBeenSuccessfulPlacedThankYouForShoppingWithUs,
            fontSize: 12.sp,
            colorText: AppColors.fontColor,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
          18.h.verticalSpace,
          DefaultButtonWidget(
            text: S.of(context).backToHome,
            width: 140.w,
            height: 38.h,
            textSize: 11.4.sp,
            onPressed: () {
              ref.read(activeIndexProvider.notifier).state = 0;
              navigateAndFinish(context, const BottomNavigationBarWidget());
            },
          ),
        ],
      ),
    );
  }
}

class CompleteOrder {
  static successDialog(BuildContext context, ref) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return const Dialog(
          alignment: Alignment.center,
          backgroundColor: Colors.transparent,
          child: OrderSuccessDialogWidget(),
        );
      },
    ).then((v) {
      ref.read(activeIndexProvider.notifier).state = 0;
      navigateAndFinish(context, const BottomNavigationBarWidget());
    });
  }
}
