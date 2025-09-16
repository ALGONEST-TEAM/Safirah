import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/theme/app_colors.dart';

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
                      nameCategory: category[index].name!,
                      image: category[index].image!,
                      idCategory: category[index].id!,
                      parentIdCategory: parentIdCategory,
                      nameSearch: nameSearch,
                    ),
                    category[index].hasChildren == true
                        ? 0.horizontalSpace
                        : 6.w.horizontalSpace,
                  ],
                );
              },
            ),
          )
        : const SizedBox.shrink();
  }
}

// class ListForRowCardSubcategoriesWidget2 extends SliverPersistentHeaderDelegate {
//   final bool circularImage;
//   const ListForRowCardSubcategoriesWidget2({
//     required this.circularImage,
// });
//
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.white,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: EdgeInsets.symmetric(horizontal: 8.w),
//         itemCount: 8,
//         itemBuilder: (context, index) {
//           return Row(
//             children: [
//               RowCardForCategoriesWidget(
//                 circularImage: circularImage,
//               ),
//              circularImage==true?0.horizontalSpace: 6.w.horizontalSpace,
//
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   double get maxExtent => 34.h;
//
//   @override
//   double get minExtent => 34.h;
//
//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }
