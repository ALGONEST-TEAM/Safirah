import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/helpers/dropdown_helper.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../category/data/model/category_data.dart';
import '../../../detailsProducts/data/model/color_data.dart';
import '../../../detailsProducts/data/model/size_data.dart';
import '../state_mangment/riverpod.dart';
import '../widgets/filter_with_counter_widget.dart';
import '../widgets/list_of_color_in_filter_widget.dart';
import '../widgets/list_of_filter_category_widget.dart';
import '../widgets/list_of_size_in_filter_widget.dart';
import '../widgets/main_filter_design_widget.dart';
import '../widgets/sub_filter_dropdown_menu_widget.dart';

class MainFilterWidget extends ConsumerStatefulWidget {
  final List<SizeData> sizeFilterList;
  final List<SizeData> unitFilterList;

  final List<ColorOfProductData> colorFilterList;
  final List<CategoryData> categoryFilterList;
  final int idCategory;
  final String nameSearch;
  final bool isSearchFilter;
  final VoidCallback? onTapFilter;

  const MainFilterWidget({
    super.key,
    required this.sizeFilterList,
    required this.colorFilterList,
    required this.categoryFilterList,
    required this.nameSearch,
    required this.isSearchFilter,
    required this.unitFilterList,
    required this.idCategory,
    this.onTapFilter,
  });

  @override
  ConsumerState<MainFilterWidget> createState() => _MainFilterWidgetState();
}

class _MainFilterWidgetState extends ConsumerState<MainFilterWidget> {
  @override
  Widget build(BuildContext context) {
    final sizeList = ref.watch(selectedSizesProvider(widget.idCategory));
    final colorList = ref.watch(selectedColorsProvider(widget.idCategory));
    final categoryFilter =
        ref.watch(selectedCategoryProvider(widget.idCategory));
    final sumOfSelectedItemInFilter =
        sizeList.length + colorList.length + (categoryFilter == null ? 0 : 1);

    return WillPopScope(
      onWillPop: () async {
        if (DropdownHelper().overlayEntry == null) {
          return true;
        } else {
          setState(() {});
          DropdownHelper().overlayEntry!.remove();
          DropdownHelper().overlayEntry = null;
          return false;
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.h)
            .copyWith(top: 10.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 8.w,
          children: [
            MainFilterDesignWidget(
              title: "${S.of(context).color}${colorList.isEmpty ? '' : '(${colorList.length})'}",
              icon: AppIcons.arrowBottom2,
              border: colorList.isNotEmpty,
              onTap: () {
                DropdownHelper().toggleDropdown(
                  context: context,
                  items: SubFilterDropdownMenuWidget(
                    idCategory: widget.idCategory,
                    filterType: "color",
                    aMenuToDisplayTheSubFilterContentWidget:
                        ListOfColorInFilterWidget(
                      colorFilter: widget.colorFilterList,
                      idCategory: widget.idCategory,
                      nameSearch: widget.nameSearch,
                      isSearchFilter: widget.isSearchFilter,
                    ),
                  ),
                );
              },
            ),
            MainFilterDesignWidget(
              title: "${S.of(context).size2}${sizeList.isEmpty ? '' : '(${sizeList.length})'}",
              icon: AppIcons.arrowBottom2,
              border: sizeList.isNotEmpty,
              onTap: () {
                DropdownHelper().toggleDropdown(
                  context: context,
                  items: SubFilterDropdownMenuWidget(
                    idCategory: widget.idCategory,
                    filterType: "size",
                    aMenuToDisplayTheSubFilterContentWidget:
                        ListOfSizeInFilterWidget(
                      size: widget.sizeFilterList,
                      idCategory: widget.idCategory,
                      nameSearch: widget.nameSearch,
                      isSearchFilter: widget.isSearchFilter,
                    ),
                  ),
                );
              },
            ),
            MainFilterDesignWidget(
              title: S.of(context).categories,
              icon: AppIcons.arrowBottom2,
              border: categoryFilter != null,
              onTap: () {
                DropdownHelper().toggleDropdown(
                  context: context,
                  items: SubFilterDropdownMenuWidget(
                    idCategory: widget.idCategory,
                    filterType: "category",
                    aMenuToDisplayTheSubFilterContentWidget:
                        ListOfFilterCategoryWidget(
                      categoryFilter: widget.categoryFilterList,
                      idCategory: widget.idCategory,
                      nameSearch: widget.nameSearch,
                      isSearchFilter: widget.isSearchFilter,
                    ),
                  ),
                );
              },
            ),
            FilterWithCounterWidget(
              sumOfSelectedItemInFilter: sumOfSelectedItemInFilter,
              onTap: widget.onTapFilter!,
            ),
          ],
        ),
      ),
    );
  }
}
