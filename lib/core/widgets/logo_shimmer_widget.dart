import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_images.dart';
import 'shimmer_widget.dart';

class LogoShimmerWidget extends StatelessWidget {
  final double? width;

  const LogoShimmerWidget({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShimmerWidget(
        baseColor: Colors.grey[200],
        child: Container(
          width: width ?? 250.w,
          margin: EdgeInsets.only(bottom: 120.h),
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(
          //       AppImages.logoWithText,
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
