import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../productManagement/filterProducts/presentation/state_mangment/riverpod.dart';
import '../pages/subcategory_product_filter_page.dart';

class CategoryRowCardWidget extends ConsumerWidget {
  final bool circularImage;
  final String nameCategory;
  final String image;
  final int idCategory;
  final int parentIdCategory;
  final String nameSearch;

  const CategoryRowCardWidget({
    super.key,
    required this.circularImage,
    required this.nameCategory,
    required this.image,
    required this.idCategory,
    required this.parentIdCategory,
    required this.nameSearch,
  });

  @override
  Widget build(BuildContext context, ref) {
    final selectedCategory =
        ref.watch(selectedCategoryProvider(parentIdCategory));
    final isSelected = selectedCategory == idCategory;
    final stateFilter = ref.watch(filterProductProvider(parentIdCategory));
    return InkWell(
      onTap: () {
        if(circularImage){
          navigateTo(
            context,
            SubcategoryProductFilterPage(
              idCategory: idCategory,
              nameCategoryForHintSearch: nameSearch,
              isSearchPage: false,
            ),
          );
        }
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
      child: Container(
        width: 84.w,
        margin: EdgeInsets.only(bottom: 3.h),
        decoration: BoxDecoration(
            color:  Colors.white,
            border:circularImage?null: isSelected == true
                ? Border.all(color: AppColors.primaryColor, width: 0.8)
                : Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8.r)
        ),
        child: Row(
          children: [
            Flexible(
              child: OnlineImagesWidget(
                imageUrl: image,
                circularImage: circularImage,
              ),
            ),
            4.w.horizontalSpace,
            Flexible(
              child: AutoSizeTextWidget(
                text: nameCategory,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                maxLines: 2,
                minFontSize: 10,
                textAlign: TextAlign.start,
                colorText: AppColors.mainColorFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
