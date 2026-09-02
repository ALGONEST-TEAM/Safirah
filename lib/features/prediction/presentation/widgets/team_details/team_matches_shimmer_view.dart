import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/theme/app_colors.dart';

class TeamMatchesShimmerView extends StatelessWidget {
  const TeamMatchesShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final statusBarHeight = mediaQuery.padding.top;
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: false,
        physics: const ClampingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 100.h,
              toolbarHeight: 40.h,
              pinned: true,
              floating: false,
              snap: false,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              elevation: 0,
              scrolledUnderElevation: 0,
              flexibleSpace: RepaintBoundary(
                child: Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      // Back Button
                      Positioned(
                        top: statusBarHeight + 5.h,
                        left: isRtl ? null : 12.w,
                        right: isRtl ? 12.w : null,
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 16.sp,
                          color: AppColors.mainColorFont.withValues(alpha: 0.5),
                        ),
                      ),
                      // Header Content Shimmer
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: statusBarHeight),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[200]!,
                            highlightColor: Colors.grey[100]!,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Logo Shimmer
                                Container(
                                  width: 48.w,
                                  height: 48.w,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                ),
                                6.h.verticalSpace,
                                // Title Shimmer
                                Container(
                                  width: 80.w,
                                  height: 12.h,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 30.h, top: 12.h),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 110.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
