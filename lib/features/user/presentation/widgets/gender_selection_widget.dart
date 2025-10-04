import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/radio_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../generated/l10n.dart';
import '../riverpod/user_riverpod.dart';

class GenderPickerWidget extends ConsumerWidget {
  const GenderPickerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedGender = ref.watch(genderProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: S.of(context).gender,
          fontSize: 11.5.sp,
          colorText: Colors.black87,
        ),
        6.h.verticalSpace,
        InkWell(
          onTap: () {
            scrollShowModalBottomSheetWidget(
              title: S.of(context).gender,
              fontSize: 14.8.sp,
              context: context,
              page: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: GenderBottomSheetWidget(ref: ref),
              ),
            );
          },
          child: Container(
            height: 42.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(
                  selectedGender == 'male' ? Icons.male : Icons.female,
                  size: 20.sp,
                  color: AppColors.primaryColor,
                ),
                8.w.horizontalSpace,
                AutoSizeTextWidget(
                  text: selectedGender == 'male'
                      ? S.of(context).male
                      : S.of(context).female,
                  fontSize: 11.sp,
                  colorText: Colors.black87,
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
      ],
    );
  }
}

class GenderBottomSheetWidget extends StatelessWidget {
  final WidgetRef ref;

  const GenderBottomSheetWidget({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    final genders = {
      'male': S.of(context).male,
      'female': S.of(context).female
    };

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...genders.entries.map(
          (entry) {
            final isSelected = ref.read(genderProvider) == entry.key;
            return GestureDetector(
              onTap: () {
                ref.read(genderProvider.notifier).state = entry.key;
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
                      child: Row(
                        children: [
                          Icon(
                            entry.key == 'male' ? Icons.male : Icons.female,
                            size: 22.sp,
                            color: isSelected
                                ? AppColors.primaryColor
                                : AppColors.fontColor2,
                          ),
                          6.w.horizontalSpace,
                          AutoSizeTextWidget(
                            text: entry.value,
                            fontSize: 13.sp,
                            colorText: const Color(0xFF4F4A59),
                          ),
                        ],
                      ),
                    ),
                    RadioWidget(selected: isSelected),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
