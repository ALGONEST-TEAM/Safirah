import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/extension/string.dart';
import '../auto_size_text_widget.dart';
import '../online_images_widget.dart';
import '../../../features/shop/productManagement/detailsProducts/data/model/color_data.dart';

class ProductPhotosWidget extends StatefulWidget {
  final int productId;
  final List<String> image;
  final double height;
  final int productColorsCount;
  final List<ColorOfProductData> colorsOfProduct;

  const ProductPhotosWidget({
    super.key,
    required this.productId,
    required this.image,
    required this.height,
    required this.productColorsCount,
    required this.colorsOfProduct,
  });

  @override
  State<ProductPhotosWidget> createState() => _ProductPhotosWidgetState();
}

class _ProductPhotosWidgetState extends State<ProductPhotosWidget> {
  late PageController _controller;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0, keepPage: false);
  }

  void _resetToFirst() {
    pageIndex = 0;
    _controller.dispose();
    _controller = PageController(initialPage: 0, keepPage: false);
  }

  @override
  void didUpdateWidget(covariant ProductPhotosWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    // ✅ إذا تغير المنتج (أو تغيرت الصور جذريًا) رجّع لأول صورة
    if (oldWidget.productId != widget.productId) {
      setState(_resetToFirst);
      return;
    }

    // احتياط: لو تغيرت الصور لنفس المنتج (مثلاً تحديث من API)
    final oldLen = oldWidget.image.length;
    final newLen = widget.image.length;
    final oldFirst = oldLen > 0 ? oldWidget.image.first : null;
    final newFirst = newLen > 0 ? widget.image.first : null;

    if (oldLen != newLen || oldFirst != newFirst) {
      setState(_resetToFirst);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;

    return Stack(
      alignment: rtl ? Alignment.bottomLeft : Alignment.bottomRight,
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            key: PageStorageKey('photos_${widget.productId}'),
            controller: _controller,
            itemCount: widget.image.length,
            onPageChanged: (v) => setState(() => pageIndex = v),
            itemBuilder: (context, imageIndex) {
              final url = widget.image[imageIndex];

              return ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  topLeft: Radius.circular(8.r),
                ),
                child: OnlineImagesWidget(
                  imageUrl: url,
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
                  itemCount: widget.colorsOfProduct.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 6.5.h,
                      margin: EdgeInsets.only(top: 2.h),
                      decoration: BoxDecoration(
                        color: widget.colorsOfProduct[index].colorHex!.toColor(),
                        borderRadius: BorderRadius.circular(1.4.r),
                        border: Border.all(color: Colors.white, width: 0.3.w),
                      ),
                    );
                  },
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
