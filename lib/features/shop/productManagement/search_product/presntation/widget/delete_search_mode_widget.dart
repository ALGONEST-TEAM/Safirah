import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';

import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../state_mangment/riverpod.dart';

class DeleteSearchModeWidget extends ConsumerWidget {
  const DeleteSearchModeWidget({
    super.key,
    required this.deleteSearchMode,
    required this.onTapIconDelete,
    required this.onTapCancel,

  });

  final bool deleteSearchMode;

  final GestureTapCallback onTapIconDelete;

  final GestureTapCallback onTapCancel;

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      children: [
        AutoSizeTextWidget(
          text: S.of(context).recent_search,
          fontSize: 15.4.sp,
        ),
        const Spacer(),
        deleteSearchMode
            ? Row(
              children: [
                InkWell(
                  onTap: onTapCancel,
                  child: AutoSizeTextWidget(
                    text: S.of(context).cancel,
                    fontSize: 11.4.sp,
                    colorText: AppColors.secondaryColor,
                  ),
                ),
                10.w.horizontalSpace,
                InkWell(
                    onTap: () {
                      ref.read(searchHistoryProvider.notifier).clearSearchHistory();
                    },
                    child: AutoSizeTextWidget(
                      text: "${S.of(context).clear} ${S.of(context).all}",
                      fontSize: 11.4.sp,
                      colorText: AppColors.dangerSwatch.shade500,
                    ),
                  ),
              ],
            )
            : InkWellButtonWidget(
                onPressed: onTapIconDelete,
                icon: AppIcons.trash,
              ),
      ],
    );
  }
}
