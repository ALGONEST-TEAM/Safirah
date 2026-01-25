import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/radio_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../riverpod/prediction_riverpod.dart';

class StandingsSortWidget extends ConsumerWidget {
  const StandingsSortWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final currentScope = ref.watch(standingsScopeProvider);

    final options = [
      {'scope': 'week', 'label': S.of(context).weekly},
      {'scope': 'month', 'label': S.of(context).monthly},
      {'scope': 'season', 'label': S.of(context).season},
    ];

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      itemCount: options.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final opt = options[index];
        final scope = opt['scope'] as String;
        final label = opt['label'] as String;

        final selected = currentScope == scope;
        return InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            ref.read(standingsScopeProvider.notifier).state = scope;
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
                    text: label,
                    fontSize: 12.4.sp,
                    colorText: const Color(0xFF4F4A59),
                  ),
                ),
                RadioWidget(selected: selected),
              ],
            ),
          ),
        );
      },
    );
  }
}
