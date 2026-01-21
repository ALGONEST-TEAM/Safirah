import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';
import '../riverpod/prediction_riverpod.dart';

class MatchStatusActionWidget extends ConsumerWidget {
  final num? status;
  final bool rtl;
  final VoidCallback onEditTap;

  const MatchStatusActionWidget({
    super.key,
    required this.status,
    required this.rtl,
    required this.onEditTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusHelper = ref.watch(matchStatusHelperProvider);

    return Padding(
      padding: EdgeInsets.only(
        left: rtl ? 4.w : 0,
        right: rtl ? 0 : 4.w,
      ),
      child: Visibility(
        visible: statusHelper.isNotStarted(status),
        replacement: statusHelper.isLive(status)
            ? AutoSizeTextWidget(
                text: S.of(context).live,
                fontSize: 8.sp,
                fontWeight: FontWeight.w400,
                colorText: AppColors.successSwatch.shade600,
              )
            : statusHelper.isFinished(status)
                ? AutoSizeTextWidget(
                    text: S.of(context).finished,
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w400,
                    colorText: AppColors.dangerSwatch.shade500,
                  )
                : const SizedBox.shrink(),
        child: InkWell(
          onTap: onEditTap,
          child: SvgPicture.asset(
            AppIcons.edit,
            height: 22.h,
            width: 20.w,
          ),
        ),
      ),
    );
  }
}
