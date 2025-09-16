import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../core/constants/app_icons.dart';

class FilterWithCounterWidget extends StatelessWidget {
  final int sumOfSelectedItemInFilter;
  final VoidCallback onTap;

  const FilterWithCounterWidget({
    super.key,
    required this.sumOfSelectedItemInFilter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 22.h,
          color: AppColors.fontColor2.withValues(alpha: 0.6),
          width: 0.8.w,
        ),
        8.w.horizontalSpace,
        InkWell(
          onTap: onTap,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.8.h),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AutoSizeTextWidget(
                      text: S.of(context).filter,
                      colorText: Colors.white,
                      fontSize: 10.6.sp,
                    ),
                    3.w.horizontalSpace,
                    SvgPicture.asset(
                      AppIcons.filter,
                      color: Colors.white,
                      height: 13.4.h,
                    )
                  ],
                ),
              ),
              if (sumOfSelectedItemInFilter != 0)
                Container(
                  width: 11.4.w,
                  height: 11.4.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: AutoSizeTextWidget(
                    text: sumOfSelectedItemInFilter.toString(),
                    colorText: Colors.white,
                    fontSize: 8.sp,
                    minFontSize: 1,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
