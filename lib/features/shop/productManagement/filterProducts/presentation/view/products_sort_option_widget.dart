import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../state_mangment/riverpod.dart';
import '../widgets/products_sort_option_bottom_sheet_widget.dart';

class ProductsSortOptionWidget extends ConsumerWidget {
  final int idCategory;
  final String nameSearch;

  const ProductsSortOptionWidget(
      {super.key, required this.idCategory, required this.nameSearch});

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(sortOptionTitleProvider(idCategory));
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w).copyWith(top: 14.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeTextWidget(
            text: S.of(context).products,
            colorText: AppColors.fontColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          GestureDetector(
            onTap: () {
              scrollShowModalBottomSheetWidget(
                context: context,
                title: S.of(context).title,
                page: ProductsSortOptionBottomSheetWidget(
                  idCategory: idCategory,
                  nameSearch: nameSearch,
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.4.h),
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
                      text: ref
                          .read(sortOptionTitleProvider(idCategory).notifier)
                          .state
                          .toString(),
                      fontSize: 10.8.sp,
                      minFontSize: 6,
                      colorText: AppColors.fontColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  14.w.horizontalSpace,
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18.sp,
                    color: AppColors.fontColor.withValues(alpha: .8),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
