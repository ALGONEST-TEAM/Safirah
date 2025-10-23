import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/radio_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../state_mangment/riverpod.dart';

class ProductsSortOptionBottomSheetWidget extends ConsumerWidget {
  const ProductsSortOptionBottomSheetWidget({
    super.key,
    required this.idCategory,
    required this.nameSearch,
  });

  final int idCategory;
  final String nameSearch;

  List<String> get options => [
        S.current.forYou,
        S.current.mostSold,
        S.current.topRated,
        S.current.priceHigh,
        S.current.priceLow,
      ];

  @override
  Widget build(BuildContext context, ref) {
    final selectedIndex = ref.watch(selectedSortIndexProvider(idCategory));
    final selectOption =
        ref.watch(selectProductsSortOptionProvider(idCategory));

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      itemCount: options.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final bool selected = index == selectedIndex;
        return InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            ref.read(sortOptionTitleProvider(idCategory).notifier).state =
                options[index];

            // ref
            //     .read(selectProductsSortOptionProvider(idCategory).notifier)
            //     .state = index + 1;
            ref
                .read(selectProductsSortOptionProvider(idCategory).notifier)
                .selectOption(index+1);
            ref
                .watch(filterProductProvider(idCategory).notifier)
                .getProductOfFilter(
                  nameSearch: nameSearch,
                  idSize: ref.read(selectedSizesProvider(idCategory)),
                  idColor: ref.read(selectedColorsProvider(idCategory)),
                  idSubCategory: ref.read(selectedCategoryProvider(idCategory)),
                  sortOption: ref
                      .read(
                          selectProductsSortOptionProvider(idCategory)),
                );
            Navigator.of(context).pop();
            // if(index==3||index==4){
            //   ref
            //       .read(selectProductsSortOptionProvider(idCategory).notifier)
            //       .selectOption(index == 3 ? 'max' : 'min');
            //   ref.watch(filterProductProvider(idCategory).notifier).getProductOfFilter(
            //       nameSearch: nameSearch,
            //       idSize: ref.read(selectedSizesProvider(idCategory)),
            //       idColor: ref.read(selectedColorsProvider(idCategory)),
            //       idSubCategory: ref.read(selectedCategoryProvider(idCategory)),
            //       sortOption:
            //       ref.read(selectProductsSortOptionProvider(idCategory)),
            //
            //   );
            // }else{
            //   ref.watch(filterProductProvider(idCategory).notifier).getProductOfFilter(
            //       nameSearch: nameSearch,
            //       idSize: ref.read(selectedSizesProvider(idCategory)),
            //       idColor: ref.read(selectedColorsProvider(idCategory)),
            //       idSubCategory: ref.read(selectedCategoryProvider(idCategory)),
            //       sortOption:'',
            //   );
            // }
          },
          child: Container(
            height: 46.h,
            decoration: BoxDecoration(
              color: AppColors.scaffoldColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AutoSizeTextWidget(
                    text: options[index],
                    fontSize: 12.4.sp,
                    colorText: const Color(0xFF4F4A59),
                  ),
                ),
                RadioWidget(selected: selected),
              ],
            ),
          ),
        );
      },
    );
  }
}
