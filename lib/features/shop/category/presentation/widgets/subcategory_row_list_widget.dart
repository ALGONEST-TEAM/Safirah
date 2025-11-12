import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../data/model/category_data.dart';
import 'category_row_card_widget.dart';

class SubcategoryRowListWidget extends StatelessWidget {
  final List<CategoryData> category;
  final int parentIdCategory;
  final String nameSearch;

  const SubcategoryRowListWidget({
    super.key,
    required this.category,
    required this.parentIdCategory,
    required this.nameSearch,
  });

  @override
  Widget build(BuildContext context) {
    return category.isNotEmpty
        ? Container(
            height: 36.h,
            color: AppColors.scaffoldColor,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              itemCount: category.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    CategoryRowCardWidget(
                      circularImage:
                          category[index].hasChildren == true ? true : false,
                      nameCategory: category[index].name??"",
                      image: category[index].image??"",
                      idCategory: category[index].id!,
                      parentIdCategory: parentIdCategory,
                      nameSearch: nameSearch,
                    ),
                   6.w.horizontalSpace,
                  ],
                );
              },
            ),
          )
        : const SizedBox.shrink();
  }
}
