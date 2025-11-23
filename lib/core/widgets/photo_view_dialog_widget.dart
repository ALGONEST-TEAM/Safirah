import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:safirah/core/theme/app_colors.dart';

import '../constants/app_icons.dart';
import 'buttons/icon_button_widget.dart';

class PhotoViewDialogWidget {
  static Future<void> show(
    BuildContext context, {
    required List<String> images,
    int initialIndex = 0,
  }) async {
    if (images.isEmpty) return;

    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: AppColors.secondaryColor.withValues(alpha: .8),
      builder: (_) {
        return _FullScreenGalleryDialog(
          images: images,
          initialIndex: initialIndex,
        );
      },
    );
  }
}

class _FullScreenGalleryDialog extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _FullScreenGalleryDialog({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_FullScreenGalleryDialog> createState() =>
      _FullScreenGalleryDialogState();
}

class _FullScreenGalleryDialogState extends State<_FullScreenGalleryDialog> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _goTo(int index) {
    if (index < 0 || index >= widget.images.length) return;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.secondaryColor.withValues(alpha: .6),
      child: SafeArea(
        child: Column(
          children: [
            12.h.verticalSpace,
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 30.h,
                width: 30.w,
                margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: const BoxDecoration(
                    color: Colors.white30, shape: BoxShape.circle),
                child: const IconButtonWidget(
                  icon: AppIcons.close,
                  iconColor: Colors.white,
                ),
              ),
            ),
            4.h.verticalSpace,
            Expanded(
              flex: 10,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) {
                  setState(() => _currentIndex = i);
                },
                itemCount: widget.images.length,
                itemBuilder: (context, index) {
                  final image = widget.images[index];
                  return PhotoView(
                    imageProvider: CachedNetworkImageProvider(image),
                    minScale: PhotoViewComputedScale.contained,
                    initialScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained,
                    basePosition: Alignment.center,
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: 64.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.images.length,
                        separatorBuilder: (_, __) => 8.w.horizontalSpace,
                        itemBuilder: (context, index) {
                          final thumb = widget.images[index];
                          final isSelected = index == _currentIndex;
                          return GestureDetector(
                            onTap: () => _goTo(index),
                            child: Container(
                              width: 64.w,
                              height: 64.w,
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: CachedNetworkImage(
                                  imageUrl: thumb,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => _goTo(_currentIndex - 1),
                            icon: const Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${_currentIndex + 1} / ${widget.images.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _goTo(_currentIndex + 1),
                            icon: const Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
