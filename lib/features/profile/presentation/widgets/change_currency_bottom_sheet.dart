import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/app_restart_controller.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/radio_widget.dart';
import '../riverpod/currency_riverpod.dart';

class ChangeCurrencyBottomSheet extends ConsumerWidget {
  const ChangeCurrencyBottomSheet({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(getAllCurrencies);
    var currencyState = ref.watch(currencyProvider);
    var currencyStateNotifier = ref.watch(currencyProvider.notifier);
    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfLoading: CircularProgressIndicator(
          color: AppColors.primaryColor,
          strokeWidth: 2.8.w,
        ),
        refresh: () {
          ref.invalidate(getAllCurrencies);
        },
        widgetOfData: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.h,
          children: state.data.map((items) {
            return InkWell(
              onTap: () async {
                await currencyStateNotifier.changeCurrency(items.code);
                AppRestartController.restartApp(context);
              },
              child: Container(
                height: 46.h,
                decoration: BoxDecoration(
                  color: AppColors.scaffoldColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          AutoSizeTextWidget(
                            text: items.code,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            colorText: const Color(0xFF4F4A59),
                          ),
                          10.w.horizontalSpace,
                          Flexible(
                            child: AutoSizeTextWidget(
                              text: items.symbol,
                              fontSize: 12.sp,
                              colorText: const Color(0xFF4F4A59),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RadioWidget(selected: currencyState == items.code),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
