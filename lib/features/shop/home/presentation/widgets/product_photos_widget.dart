import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/online_images_widget.dart';

class ProductPhotosWidget extends StatefulWidget {
  final List<String> image;
  final double height;

  const ProductPhotosWidget({
    super.key,
    required this.image,
    required this.height,
  });

  @override
  State<ProductPhotosWidget> createState() => _ProductPhotosWidgetState();
}

class _ProductPhotosWidgetState extends State<ProductPhotosWidget> {
  int pageController = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
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
        // PositionedDirectional(
        //   top: 5,
        //   end: 5,
        //   child: Container(
        //     padding: EdgeInsets.all(4.6.sp),
        //     decoration: const BoxDecoration(
        //       color: Colors.white,
        //       shape: BoxShape.circle,
        //     ),
        //     child: SvgPicture.asset(
        //       AppIcons.wishlist,
        //       color: AppColors.secondaryColor,
        //       height: 15.4.h,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
