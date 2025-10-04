import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/category_data.dart';
import 'home_category_widget.dart';

class HomeCategoriesList extends StatelessWidget {
  const HomeCategoriesList({super.key, required this.category});

  final List<CategoryData>? category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 8.h),
          child: AutoSizeTextWidget(
            text: S.of(context).categories,
            colorText: AppColors.fontColor,
            fontSize: 11.3.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 42.h,
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding:
                EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 12.h),
            itemCount: category!.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  HomeCategoryWidget(
                    idCategory: category![index].id!,
                    name: category![index].name!,
                    image: category![index].image ?? '',
                  ),
                  10.w.horizontalSpace,
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
