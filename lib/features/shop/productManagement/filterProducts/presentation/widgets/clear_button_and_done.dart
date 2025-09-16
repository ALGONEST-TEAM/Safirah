import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';
import '../state_mangment/riverpod.dart';

class ClearButtonAndDone extends ConsumerWidget {
  final int idCategory;
  final VoidCallback doneOnTap;
  final VoidCallback clearOnTap;
  final double? height;

  const ClearButtonAndDone({
    super.key,
    required this.idCategory,
    required this.doneOnTap,
    required this.clearOnTap,
    this.height,
  });

  @override
  Widget build(BuildContext context, ref) {
    final stateFilter = ref.watch(filterProductProvider(idCategory));

    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Row(
        children: [
          DefaultButtonWidget(
            text: S.of(context).done,
            width: 56.w,
            height: height ?? 26.h,
            textSize: 11.sp,
            onPressed: doneOnTap,
            isLoading: stateFilter.stateData == States.loading,
          ),
          8.w.horizontalSpace,
          DefaultButtonWidget(
            text: S.of(context).clear,
            width: 56.w,
            height: height ?? 26.h,
            textSize: 11.sp,
            background: Colors.white,
            textColor: Colors.black,
            border: Border.all(color: AppColors.fontColor, width: 0.14.r),
            onPressed: clearOnTap,
          ),
        ],
      ),
    );
  }
}
