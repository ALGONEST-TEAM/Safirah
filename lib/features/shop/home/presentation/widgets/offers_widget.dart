import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import 'package:safirah/features/shop/productManagement/detailsProducts/presentation/page/details_page.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/offers_model.dart';
import '../pages/offers_page.dart';

class OffersWidget extends StatelessWidget {
  final List<OffersModel> offers;

  const OffersWidget({super.key, required this.offers});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 126.h,
        autoPlay: offers.length > 1,
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
      items: offers.map((items) {
        return GestureDetector(
          onTap: () {
            if (items.productsIds?.isEmpty==true) return;
            if (items.productsIds!.length == 1) {
              navigateTo(
                  context,
                  DetailsPage(
                    idProduct: items.productsIds![0],
                    name: S.of(context).appName,
                    price: 0000,
                    image:const <String>[] ,
                  ));
            } else {
              navigateTo(context, OffersPage(offerId: items.id));
            }
          },
          child: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: OnlineImagesWidget(
                  imageUrl: items.image,
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
