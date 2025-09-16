import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/buttons/icon_button_widget.dart';

class LoadingDesignToDisplayProductDetailsToAddToCartWidget extends StatelessWidget {
  const LoadingDesignToDisplayProductDetailsToAddToCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
      child: Row(
        children: [
          IconButtonWidget(
            icon: AppIcons.wishlist,
            height: 21.h,
            iconColor: AppColors.fontColor,
            onPressed: () {},
          ),
          4.w.horizontalSpace,
          Expanded(
            child: Container(
              height: 38.h,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2.5.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
