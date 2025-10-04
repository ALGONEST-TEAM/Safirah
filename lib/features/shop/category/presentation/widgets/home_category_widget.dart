import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../pages/subcategory_product_filter_page.dart';

class HomeCategoryWidget extends ConsumerWidget {
  final String image;
  final String name;
  final int idCategory;

  const HomeCategoryWidget(
      {super.key,
      required this.name,
      required this.image,
      required this.idCategory
      });

  @override
  Widget build(BuildContext context, ref) {
    return InkWell(
      onTap: () {
        navigateTo(
          context,
          SubcategoryProductFilterPage(
            idCategory: idCategory,
            nameCategoryForHintSearch: name,
            isSearchPage: false,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 2.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            OnlineImagesWidget(
              imageUrl: image,
              circularImage: true,
              circularRadius: 38.sp,
              size: Size(34.w, 34.h),
            ),
            4.w.horizontalSpace,
            Flexible(
              child: AutoSizeTextWidget(
                text: name,
                fontSize: 10.2.sp,
                fontWeight: FontWeight.w500,
                colorText: AppColors.fontColor,
                textAlign: TextAlign.center,
              ),
            ),
            4.w.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
