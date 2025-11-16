import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../pages/subcategory_product_filter_page.dart';

class CategoryCircleCardWidget extends ConsumerWidget {
  final String image;
  final String name;
  final double? circularRadius;
  final VoidCallback? onPressed;
  final int idCategory;

  const CategoryCircleCardWidget(
      {super.key,
      required this.name,
      this.circularRadius,
      this.onPressed,
      required this.image,
      required this.idCategory});

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
      child: SizedBox(
        width: 64.w,
        child: Stack(
          children: [
            OnlineImagesWidget(
              imageUrl: image,
              circularImage: true,
              circularRadius: 40.r,
              size: const Size(double.infinity, double.infinity),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.black26.withValues(alpha: 0.26),
                  shape: BoxShape.circle),
              alignment: Alignment.center,
              child: AutoSizeTextWidget(
                text: name,
                fontSize: 10.4.sp,
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
