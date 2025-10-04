import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/radio_widget.dart';
import '../../../shop/address/presentation/riverpod/address_riverpod.dart';
import '../riverpod/user_riverpod.dart';

class CitiesBottomSheetWidget extends ConsumerWidget {
  const CitiesBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final selectedCity = ref.read(selectedCityProvider);
    var cities = ref.read(citiesProvider);

    return CheckStateInGetApiDataWidget(
      state: cities,

      refresh: (){
        ref.refresh(citiesProvider);
        Navigator.of(context).pop();

      },

      widgetOfData: SizedBox(
        height: 460.h,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          itemCount: cities.data.length,
          itemBuilder: (context, index) {
            final isSelected = selectedCity != null &&
                selectedCity.id == cities.data[index].id;

            return GestureDetector(
              onTap: () {
                ref.read(selectedCityProvider.notifier).state =
                cities.data[index];
                Navigator.of(context).pop();
              },
              child: Container(
                height: 46.h,
                decoration: BoxDecoration(
                  color: AppColors.scaffoldColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                margin: EdgeInsets.symmetric(horizontal: 12.w)
                    .copyWith(bottom: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AutoSizeTextWidget(
                        text: cities.data[index].name.toString(),
                        fontSize: 13.sp,
                        colorText: const Color(0xFF4F4A59),
                      ),
                    ),
                    RadioWidget(selected: isSelected),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
