import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';
import '../../../shop/address/presentation/riverpod/address_riverpod.dart';
import '../riverpod/user_riverpod.dart';
import 'cities_bottom_sheet_widget.dart';

class CityWidget extends ConsumerWidget {
  const CityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCity = ref.watch(selectedCityProvider);
    final errorMessage = ref.watch(selectedCityErrorProvider);
    ref.watch(citiesProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.h.verticalSpace,
        AutoSizeTextWidget(
          text: S.of(context).city,
          fontSize: 11.5.sp,
          colorText: Colors.black87,
        ),
        6.h.verticalSpace,
        InkWell(
          onTap: () {
            scrollShowModalBottomSheetWidget(
              title: S.of(context).city,
              fontSize: 14.8.sp,
              context: context,
              page: const CitiesBottomSheetWidget(),
            );
          },
          child: Container(
            height: 42.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppIcons.location,
                  height: 18.h,
                ),
                8.w.horizontalSpace,
                AutoSizeTextWidget(
                  text: selectedCity?.name ?? S.of(context).city,
                  fontSize: 11.sp,
                  colorText: selectedCity == null
                      ? AppColors.fontColor2
                      : Colors.black87,
                ),
                const Spacer(),
                SvgPicture.asset(
                  AppIcons.arrowBottom,
                  height: 18.h,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
        if (errorMessage != null)
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Text(
              errorMessage,
              style: TextStyle(
                fontSize: 10.sp,
                color: AppColors.dangerColor,
              ),
            ),
          ),
      ],
    );
  }
}

