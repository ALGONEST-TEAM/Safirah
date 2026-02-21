import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../data/models/banners_model.dart';

class BannersWidget extends StatelessWidget {
  final List<BannerModel> banners;

  const BannersWidget({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 126.h,
        autoPlay: banners.length > 1,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
        reverse: false,
        enableInfiniteScroll: false,
        viewportFraction: 0.93,
        enlargeCenterPage: false,
        padEnds: true,
      ),
      items: banners.map((items) {
        return GestureDetector(
          onTap: () {

          },
          child: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: OnlineImagesWidget(
                  imageUrl: items.imageUrl,
                  fit: BoxFit.cover,
                  size: Size(double.infinity, 126.h),
                  borderRadius: 8.r,
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }
}
