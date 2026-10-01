import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/radio_widget.dart';
import '../riverpod/prediction_riverpod.dart';

class StandingsMonthFilterWidget extends ConsumerWidget {
  const StandingsMonthFilterWidget({super.key});

  static const List<({String label, String? direction})> options = [
    (label: 'الشهر السابق', direction: 'prev'),
    (label: 'الشهر الحالي', direction: null),
    (label: 'الشهر القادم', direction: 'next'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDirection = ref.watch(standingsDirectionProvider);

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      itemCount: options.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final opt = options[index];
        final isSelected = currentDirection == opt.direction;

        return InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            ref.read(standingsDirectionProvider.notifier).state = opt.direction;
            Navigator.of(context).pop();
          },
          child: Container(
            height: 46.h,
            decoration: BoxDecoration(
              color: AppColors.scaffoldColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AutoSizeTextWidget(
                    text: opt.label,
                    fontSize: 12.4.sp,
                    colorText: const Color(0xFF4F4A59),
                  ),
                ),
                RadioWidget(selected: isSelected),
              ],
            ),
          ),
        );
      },
    );
  }
}
