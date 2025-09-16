import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../detailsProducts/data/model/color_data.dart';
import '../../../detailsProducts/presentation/widget/list_of_colors_product_widget.dart';
import '../state_mangment/riverpod.dart';

class ListOfColorInFilterWidget extends ConsumerWidget {
  const ListOfColorInFilterWidget(
      {super.key,
      required this.colorFilter,
      required this.idCategory,
      required this.nameSearch,
      required this.isSearchFilter});

  final List<ColorOfProductData> colorFilter;
  final int idCategory;
  final String nameSearch;
  final bool isSearchFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColors = ref.watch(selectedColorsProvider(idCategory));
    final stateFilter = ref.watch(filterProductProvider(idCategory));
    return Wrap(
      spacing: 10.w,
      runSpacing: 6.0.h,
      children: colorFilter.map((item) {
        final isSelected = selectedColors.contains(item.idColor);

        return GestureDetector(
          onTap: () {
            if (stateFilter.stateData != States.loading) {
              ref
                  .read(selectedColorsProvider(idCategory).notifier)
                  .toggleColor(item.idColor!);
              ref.read(filterProductProvider(idCategory).notifier).getProductOfFilter(
                  idSize: ref.read(selectedSizesProvider(idCategory)),
                  idColor: ref.read(selectedColorsProvider(idCategory)),
                  idSubCategory: ref.read(selectedCategoryProvider(idCategory)),
                sortOption: ref.read(selectProductsSortOptionProvider(idCategory)),
                  nameSearch: isSearchFilter ? nameSearch : '',
              );
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 50),
            height: 23.h,
            width: 26.w,
            decoration: BoxDecoration(
              color: hexToColor(item.colorHex!),
              borderRadius: BorderRadius.circular(6.r),
              boxShadow: isSelected
                  ? [
                       const BoxShadow(
                        color: AppColors.primaryColor,
                        spreadRadius: 2,
                      ),
                      const BoxShadow(
                        color: Colors.white,
                        spreadRadius: 1.0,
                      ),
                    ]
                  : [],
              border: isSelected
                  ? null
                  : Border.all(
                      color: const Color(0xffE1E1E1),
                    ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
