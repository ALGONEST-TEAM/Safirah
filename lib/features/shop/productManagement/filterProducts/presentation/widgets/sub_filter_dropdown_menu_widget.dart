import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/dropdown_helper.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../state_mangment/riverpod.dart';
import 'clear_button_and_done.dart';

class SubFilterDropdownMenuWidget extends ConsumerWidget {
  final Widget aMenuToDisplayTheSubFilterContentWidget;
  final int idCategory;
  final String filterType;

  const SubFilterDropdownMenuWidget({
    super.key,
    required this.aMenuToDisplayTheSubFilterContentWidget,
    required this.idCategory,
    required this.filterType,
  });

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(filterProductProvider(idCategory));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        6.h.verticalSpace,
        Flexible(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(8.sp),
            child: aMenuToDisplayTheSubFilterContentWidget,
          ),
        ),
        Divider(
          color: AppColors.fontColor,
          thickness: 0.1.sp,
          height: 4.h,
        ),
        ClearButtonAndDone(
          idCategory: idCategory,
          doneOnTap: () {
            DropdownHelper().overlayEntry!.remove();
            DropdownHelper().overlayEntry = null;
          },
          clearOnTap: () {
            if (filterType == "color") {
              ref.read(selectedColorsProvider(idCategory).notifier).clear();
            } else if (filterType == "size") {
              ref.read(selectedSizesProvider(idCategory).notifier).clear();
            } else if (filterType == "category") {
              ref.read(selectedCategoryProvider(idCategory).notifier).clear();
            }
            ref
                .read(filterProductProvider(idCategory).notifier)
                .getProductOfFilter(
                  idSize: ref.read(selectedSizesProvider(idCategory)),
                  idColor: ref.read(selectedColorsProvider(idCategory)),
                  idSubCategory: ref.read(selectedCategoryProvider(idCategory)),
                  sortOption:
                      ref.read(selectProductsSortOptionProvider(idCategory)),
                  nameSearch: '',
                );
            DropdownHelper().overlayEntry!.remove();
            DropdownHelper().overlayEntry = null;
          },
        ),
      ],
    );
  }
}
