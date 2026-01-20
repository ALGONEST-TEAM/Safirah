import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';


class EmptyWishesProductsWidget extends StatelessWidget {
  const EmptyWishesProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppIcons.emptyWishlist,
            height: 140.h,
          ),
          AutoSizeTextWidget(
            text: S.of(context).youDontHaveAnyProductInMyWishlist,
            fontSize: 11.2.sp,
            colorText: Colors.black54,
            fontWeight: FontWeight.w600,
            maxLines: 2,
          ),
          18.h.verticalSpace,
          Consumer(
            builder: (context, ref, child) {
              return DefaultButtonWidget(
                text: S.of(context).shopNow,
                height: 30.h,
                width: 140.w,
                textSize: 11.sp,
                borderRadius: 2.r,
                onPressed: () {
                  ref.read(activeIndexShopProvider.notifier).state = 0;
                  navigateAndFinish(context, const BottomNavigationBarWidget());
                },
              );
            },
          ),
          18.h.verticalSpace,

        ],
      ),
    );
  }
}
