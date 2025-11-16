import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/category_data.dart';
import 'category_circle_card_widget.dart';
import 'category_rect_card_widget.dart';

class SubcategoryColumnListWidget extends ConsumerWidget {
  final List<CategoryData> category;
  final int parentIdCategory;
  final String nameSearch;

  SubcategoryColumnListWidget({
    super.key,
    required this.parentIdCategory,
    required this.category,
    required this.nameSearch,
  });

  bool oneOfSubCategoryHasChild = false;

  @override
  Widget build(BuildContext context, ref) {
    return category.isNotEmpty == true
        ? ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            itemCount: category.length,
            itemBuilder: (context, index) {
              for (int i = 0; i <= category.length;) {
                if (category[i].hasChildren == true) {
                  oneOfSubCategoryHasChild = true;
                }
                break;
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  3.w.horizontalSpace,
                  oneOfSubCategoryHasChild == true
                      ? CategoryCircleCardWidget(
                          idCategory: category[index].id!,
                          circularRadius: 30.sp,
                          name: category[index].name ?? "",
                          image: category[index].image ?? "",
                        )
                      : CategoryRectCardWidget(
                          idCategory: category[index].id!,
                          image: category[index].image ?? "",
                          name: category[index].name ?? "",
                          parentIdCategory: parentIdCategory,
                          nameSearch: nameSearch,
                        ),
                  3.w.horizontalSpace,
                ],
              );
            },
          )
        : const SizedBox.shrink();
  }
}
