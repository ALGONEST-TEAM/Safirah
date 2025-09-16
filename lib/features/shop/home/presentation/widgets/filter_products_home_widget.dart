import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../riverpod/home_riverpod.dart';
import 'sort_bottom_sheet_widget.dart';

class FilterProductsHomeWidget extends ConsumerStatefulWidget {
  const FilterProductsHomeWidget({
    super.key,
    required this.idSection,
  });

  final int idSection;

  @override
  ConsumerState<FilterProductsHomeWidget> createState() =>
      _FilterProductsHomeWidgetState();
}

class _FilterProductsHomeWidgetState
    extends ConsumerState<FilterProductsHomeWidget> {
  int temp = 0;

  List<String> get nameFilter => [
        S.current.forYou,
        S.current.mostSold,
        S.current.topRated,
        S.current.priceHigh,
        S.current.priceLow,
      ];

  String get _title => nameFilter[temp];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w).copyWith(top: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeTextWidget(
            text: S.of(context).products,
            colorText: AppColors.fontColor,
            fontSize: 11.4.sp,
            fontWeight: FontWeight.w400,
          ),
          GestureDetector(
            onTap: _onOpenSheet,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  2.w.horizontalSpace,
                  Padding(
                    padding: EdgeInsets.only(bottom: 1.4.h),
                    child: AutoSizeTextWidget(
                      text: _title,
                      fontSize: 10.4.sp,
                      minFontSize: 6,
                      colorText: AppColors.fontColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  14.w.horizontalSpace,
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18.sp,
                    color: AppColors.fontColor.withOpacity(.8),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onOpenSheet() async {
    final int? selected = await showSortBottomSheet(
      context: context,
      initialIndex: temp,
      options: nameFilter,
    );

    if (!mounted || selected == null) return;
    setState(() => temp = selected);

    scheduleMicrotask(() async {
      await Future<void>.delayed(const Duration(milliseconds: 180));
      if (!mounted) return;

      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ref
            .read(getSectionFilterTypeProvider(widget.idSection).notifier)
            .setSectionFilterNumber(selected + 1);
      });
    });
  }
}
