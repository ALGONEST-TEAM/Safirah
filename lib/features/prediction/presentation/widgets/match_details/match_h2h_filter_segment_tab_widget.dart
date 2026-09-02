import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../provider/match_details_providers.dart';

class MatchH2hFilterSegmentTabWidget extends ConsumerWidget {
  final int matchId;
  final String title;
  final int index;
  final int selectedIndex;

  const MatchH2hFilterSegmentTabWidget({
    super.key,
    required this.matchId,
    required this.title,
    required this.index,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        ref.read(matchH2hUIProvider(matchId).notifier).setFilterIndex(index);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.all(3.r),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        alignment: Alignment.center,
        child: AutoSizeTextWidget(
          text: title,
          fontSize: 11.5.sp,
          maxLines: 1,
          minFontSize: 8,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          colorText: isSelected ? Colors.white : AppColors.fontColor,
        ),
      ),
    );
  }
}
