import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/extension/string.dart';
import '../auto_size_text_widget.dart';
import '../online_images_widget.dart';
import '../../../features/shop/productManagement/detailsProducts/data/model/color_data.dart';

class ProductPhotosWidget extends StatefulWidget {
  final List<String> image;
  final double height;
  final int productColorsCount;
  final List<ColorOfProductData> colorsOfProduct;

  const ProductPhotosWidget({
    super.key,
    required this.image,
    required this.height,
    required this.productColorsCount,
    required this.colorsOfProduct,
  });

  @override
  State<ProductPhotosWidget> createState() => _ProductPhotosWidgetState();
}

class _ProductPhotosWidgetState extends State<ProductPhotosWidget> {
  int pageController = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Directionality.of(context) == TextDirection.rtl
          ? Alignment.bottomLeft
          : Alignment.bottomRight,
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            itemCount: widget.image.length,
            onPageChanged: (value) {
              setState(() {
                pageController = value;
              });
            },
            itemBuilder: (context, imageIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  topLeft: Radius.circular(8.r),
                ),
                child: OnlineImagesWidget(
                  imageUrl: widget.image[imageIndex],
                  size: Size(double.infinity, widget.height),
                  borderRadius: 0,
                ),
              );
            },
          ),
        ),
        if (widget.colorsOfProduct.isNotEmpty)
          Container(
            width: 10.5.w,
            margin: EdgeInsets.all(4.sp),
            decoration: BoxDecoration(
              color: Colors.black38.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 6.5.h,
                      margin: EdgeInsets.only(top: 2.h),
                      decoration: BoxDecoration(
                          color:
                              widget.colorsOfProduct[index].colorHex!.toColor(),
                          borderRadius: BorderRadius.circular(1.4.r),
                          border:
                              Border.all(color: Colors.white, width: 0.3.w)),
                    );
                  },
                  itemCount: widget.colorsOfProduct.length,
                ),
                AutoSizeTextWidget(
                  text: widget.productColorsCount.toString(),
                  colorText: Colors.white,
                  fontSize: 8.sp,
                  minFontSize: 8,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
