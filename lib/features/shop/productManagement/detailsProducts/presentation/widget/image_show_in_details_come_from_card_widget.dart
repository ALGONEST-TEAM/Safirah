import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/widgets/online_images_widget.dart';
import '../state_mangment/riverpod_details.dart';

class ImageShowInDetailsComeFromCardWidget extends StatefulWidget {
  final List<String> productData;
  final int? indexColorImage;

  const ImageShowInDetailsComeFromCardWidget({
    super.key,
    required this.productData,
    this.indexColorImage,
  });

  @override
  _ImageShowInDetailsComeFromCardWidgetState createState() =>
      _ImageShowInDetailsComeFromCardWidgetState();
}

class _ImageShowInDetailsComeFromCardWidgetState
    extends State<ImageShowInDetailsComeFromCardWidget> {
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
          height: 320.h,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(),
            itemCount: widget.productData.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: OnlineImagesWidget(
                  imageUrl: widget.productData[index],
                  size: Size(double.infinity, 320.h),
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
