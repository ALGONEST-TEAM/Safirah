import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../category/data/model/category_data.dart';
import '../../../detailsProducts/data/model/color_data.dart';
import '../../../detailsProducts/data/model/size_data.dart';
import '../state_mangment/riverpod.dart';
import '../widgets/list_of_color_in_filter_widget.dart';
import '../widgets/list_of_filter_category_widget.dart';
import '../widgets/list_of_size_in_filter_widget.dart';
import '../widgets/card_of_sub_filter_drawer_widget.dart';
import '../widgets/clear_button_and_done.dart';

class SubFilterDrawerWidget extends ConsumerStatefulWidget {
  const SubFilterDrawerWidget({
    super.key,
    required this.colorFilterList,
    required this.sizeFilterList,
    required this.categoryFilterList,
    required this.nameSearch,
    required this.isSearchFilter,
    required this.idCategory,
  });

  final List<SizeData> sizeFilterList;
  final List<ColorOfProductData> colorFilterList;
  final List<CategoryData> categoryFilterList;
  final String nameSearch;
  final int idCategory;
  final bool isSearchFilter;

  @override
  ConsumerState<SubFilterDrawerWidget> createState() =>
      _SubFilterDrawerWidgetState();
}

class _SubFilterDrawerWidgetState extends ConsumerState<SubFilterDrawerWidget> {

  @override
  Widget build(BuildContext context) {
    final selectedSizes = ref.watch(selectedSizesProvider(widget.idCategory));
    final selectedColors = ref.watch(selectedColorsProvider(widget.idCategory));
    final selectedCategory =
        ref.watch(selectedCategoryProvider(widget.idCategory));
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        children: [
          28.h.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).filter,
            fontSize: 16.5.sp,
            fontWeight: FontWeight.w600,
          ),
          6.h.verticalSpace,
          Divider(
            color: AppColors.fontColor,
            thickness: 0.2.sp,
            height: 0,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CardOfSubFilterDrawerWidget(
                    isOpenToRead: selectedColors.isNotEmpty ? true : false,
                    title: S.of(context).color,
                    child: ListOfColorInFilterWidget(
                      colorFilter: widget.colorFilterList,
                      idCategory: widget.idCategory,
                      nameSearch: widget.nameSearch,
                      isSearchFilter: widget.isSearchFilter,
                    ),
                  ),
                  CardOfSubFilterDrawerWidget(
                    isOpenToRead: selectedSizes.isNotEmpty ? true : false,
                    title: S.of(context).size2,
                    child: ListOfSizeInFilterWidget(
                      size: widget.sizeFilterList,
                      idCategory: widget.idCategory,
                      nameSearch: widget.nameSearch,
                      isSearchFilter: widget.isSearchFilter,
                    ),
                  ),
                  CardOfSubFilterDrawerWidget(
                    isOpenToRead: selectedCategory != null ? true : false,
                    title: S.of(context).categories,
                    child: ListOfFilterCategoryWidget(
                      categoryFilter: widget.categoryFilterList,
                      idCategory: widget.idCategory,
                      nameSearch: widget.nameSearch,
                      isSearchFilter: widget.isSearchFilter,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: AppColors.fontColor,
            thickness: 0.2.sp,
            height: 0,
          ),
          ClearButtonAndDone(
            idCategory: widget.idCategory,
            height: 29.h,
            doneOnTap: () {
              Navigator.pop(context);
            },
            clearOnTap: () {
              ref
                  .read(selectedColorsProvider(widget.idCategory).notifier)
                  .clear();
              ref
                  .read(selectedSizesProvider(widget.idCategory).notifier)
                  .clear();
              ref
                  .read(selectedCategoryProvider(widget.idCategory).notifier)
                  .clear();
              ref
                  .read(sortOptionTitleProvider(widget.idCategory).notifier)
                  .state = S.of(context).forYou;
              ref
                  .read(selectProductsSortOptionProvider(widget.idCategory)
                      .notifier)
                  .clear();
              ref
                  .read(filterProductProvider(widget.idCategory).notifier)
                  .getProductOfFilter(
                idSize:<int> [],
                idColor:<int> [],
                idSubCategory:null ,
                sortOption:'',
                nameSearch: '',
              );
            },
          ),
        ],
      ),
    );
  }
}
