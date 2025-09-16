import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../detailsProducts/data/model/size_data.dart';
import '../state_mangment/riverpod.dart';

class ListOfSizeInFilterWidget extends ConsumerWidget {
  const ListOfSizeInFilterWidget({
    super.key,
    required this.isSearchFilter,
    required this.size,
    required this.idCategory,
    required this.nameSearch,
  });

  final bool isSearchFilter;
  final String nameSearch;
  final List<SizeData> size;
  final int idCategory;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSizes = ref.watch(selectedSizesProvider(idCategory));
    final stateFilter = ref.watch(filterProductProvider(idCategory));

    return Wrap(
      spacing: 10.w,
      runSpacing: 8.h,
      children: size.map((item) {
        final isSelected = selectedSizes.contains(item.id);
        return InkWell(
          onTap: () {
            if (stateFilter.stateData != States.loading) {
              ref
                  .read(selectedSizesProvider(idCategory).notifier)
                  .toggleSize(item.id!);
              ref.read(filterProductProvider(idCategory).notifier).getProductOfFilter(
                    idSize: ref.read(selectedSizesProvider(idCategory)),
                    idColor: ref.read(selectedColorsProvider(idCategory)),
                    idSubCategory:
                        ref.read(selectedCategoryProvider(idCategory)),
                sortOption: ref.read(selectProductsSortOptionProvider(idCategory)),
                    nameSearch: isSearchFilter ? nameSearch : '',
                  );
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryColor.withOpacity(0.2)
                  : AppColors.whiteColor,
              border: Border.all(
                color:
                    isSelected ? AppColors.primaryColor : AppColors.fontColor,
                width: isSelected ? 1.2.r : 0.2.r,
              ),
              borderRadius: BorderRadius.circular(6.r)
            ),
            child: AutoSizeTextWidget(
              text: item.sizeTypeName,
              colorText:
                  isSelected ? AppColors.primaryColor : AppColors.fontColor,
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
    );
  }
}
