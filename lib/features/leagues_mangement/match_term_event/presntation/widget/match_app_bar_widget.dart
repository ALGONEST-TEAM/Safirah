import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../state_mangement/riverpod.dart';

class MatchAppBarWidget extends ConsumerWidget implements PreferredSizeWidget {
  final String matchSyncId;
  const MatchAppBarWidget({super.key, required this.matchSyncId});

  String _formatTime(int seconds) {
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final sec = (seconds % 60).toString().padLeft(2, '0');
    return '$min:$sec';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final termState = ref.watch(matchTermCounterProvider(matchSyncId));

    return SecondaryAppBarWidget(

      title: 'احداث المباراة',

      actions: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: AutoSizeTextWidget(
              text: _formatTime(termState.data.elapsedSeconds),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              colorText: Colors.white,
            ),
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
