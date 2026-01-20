import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/online_images_widget.dart';
import '../../data/model/product_data.dart';
import '../state_mangment/riverpod_details.dart';

class ImageSliderWidget extends StatefulWidget {
  final ProductData productData;
  final int? indexColorImage;

  const ImageSliderWidget({
    super.key,
    required this.productData,
    this.indexColorImage,
  });

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  late ScrollController _scrollController;
  int? currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imagesByColor = widget.productData.colorsProduct!.isNotEmpty
        ? widget.productData.colorsProduct![widget.indexColorImage ?? 0]
                .image ??
            []
        : [];
    final allImage = widget.productData.allImage!;
    return Consumer(
      builder: (context, ref, child) =>
          NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          final double itemWidth = MediaQuery.of(context).size.width;
          int newIndex = (_scrollController.offset / itemWidth).round() + 1;
          if (newIndex != currentIndex) {
            currentIndex = newIndex;
            ref
                .read(showNumberOfScrollImageProvider.notifier)
                .setIndexColorImage(newIndex);
          }
          return true;
        },
        child: SizedBox(
          height: 420.h,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(),
            itemCount: widget.productData.colorHasImage == false
                ? allImage.length
                : imagesByColor.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: OnlineImagesWidget(
                  imageUrl: widget.productData.colorHasImage == false
                      ? allImage[index]
                      : imagesByColor[index],
                  size: Size(double.infinity, 420.h),
                  borderRadius: 0,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
