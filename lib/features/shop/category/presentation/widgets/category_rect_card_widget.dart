import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../productManagement/filterProducts/presentation/state_mangment/riverpod.dart';

class CategoryRectCardWidget extends ConsumerWidget {
  final String name;
  final int idCategory;
  final String image;
  final int parentIdCategory;
  final String nameSearch;

  const CategoryRectCardWidget(
      {super.key,
      required this.name,
      required this.idCategory,
      required this.image,
      required this.nameSearch,
      required this.parentIdCategory});

  @override
  Widget build(BuildContext context, ref) {
    final selectedCategory =
        ref.watch(selectedCategoryProvider(parentIdCategory));
    final isSelected = selectedCategory == idCategory;
    final stateFilter = ref.watch(filterProductProvider(parentIdCategory));

    return InkWell(
      onTap: () {
        if (stateFilter.stateData != States.loading) {
          ref
              .read(selectedCategoryProvider(parentIdCategory).notifier)
              .selectCategory(idCategory);
          ref.read(filterProductProvider(parentIdCategory).notifier).getProductOfFilter(
                idSize: ref.read(selectedSizesProvider(parentIdCategory)),
                idColor: ref.read(selectedColorsProvider(parentIdCategory)),
                idSubCategory:
                    ref.read(selectedCategoryProvider(parentIdCategory)),
            sortOption: ref.read(selectProductsSortOptionProvider(parentIdCategory)),
                nameSearch: nameSearch,
              );
        }
      },
      child: SizedBox(
        width: 80.w,
        child: Stack(
          children: [
            OnlineImagesWidget(
              imageUrl: image,
              size: const Size(double.infinity, double.infinity),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black26.withValues(alpha: 0.26),
                border: isSelected == true
                    ? Border.all(color: AppColors.primaryColor, width: 1.2)
                    : Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: AutoSizeTextWidget(
                text: name,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                maxLines: 2,
                minFontSize: 9,
                textAlign: TextAlign.center,
                colorText: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
