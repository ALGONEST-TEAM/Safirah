import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/constants/app_icons.dart';
import 'package:safirah/features/shop/home/presentation/widgets/offers_widget.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';

class HomePages extends StatelessWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leadingWidth: 60.w,
        leading: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: CircleAvatar(
            radius: 11.r,
            backgroundColor:Colors.transparent,
            child:  SvgPicture.asset(
              AppIcons.logo,
              width:   27.w,

            ),
            // صورة البروفايل
          ),
        ),
        title: AutoSizeTextWidget(
          text: 'اهلا، عبدالله الأنسي',
          fontSize: 13.sp,
          colorText: Colors.white,
        ),
        actionsPadding: EdgeInsets.all(12.w),
        actions: [
          SvgPicture.asset(
            AppIcons.search,
            color: Colors.white,
            width: 20.w,
          ),
          6.h.horizontalSpace,
          SvgPicture.asset(
            AppIcons.notification,
            color: Colors.white,
            width: 20.w,
          ),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OffersWidget(offers: [],),


              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeTextWidget(
                    text: 'ابرز اللحظات',
                  ),
                  AutoSizeTextWidget(
                    text: 'عرض الكل',
                    fontSize: 11.sp,
                    colorText: AppColors.fontColor2,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              StatusPage(),

              SizedBox(height: 24.h),

              /// المباريات القادمة
              AutoSizeTextWidget(
                text: 'للمباريات القادمة',
              ),
              SizedBox(height: 8.h),
              MatchCardWidget(),

              SizedBox(height: 24.h),

              /// آخر الأخبار
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeTextWidget(
                    text: 'آخر الأخبار',
                  ),
                  AutoSizeTextWidget(
                    text: 'عرض الكل',
                    fontSize: 11.sp,
                    colorText: AppColors.fontColor2,
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AutoSizeTextWidget(
                            text:
                                'شاهد كيف عليك الهجمة انا ديراميس بريميرليج؟!',
                            fontSize: 11.sp,
                          ),
                          SizedBox(height: 4.h),
                          AutoSizeTextWidget(
                            text: 'الجمعة 15 فبراير 2025',
                            fontSize: 10.sp,
                            colorText: AppColors.fontColor2,
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                    OnlineImagesWidget(
                      imageUrl: '',
                      fit: BoxFit.cover,
                      size: Size(double.infinity, 130.h),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.favorite_border,
                              size: 18.sp, color: AppColors.primaryColor),
                          SizedBox(width: 4.w),
                          AutoSizeTextWidget(
                            text: '22',
                            fontSize: 12.sp,
                            colorText: AppColors.fontColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}

class MatchCardWidget extends StatelessWidget {
  const MatchCardWidget({super.key});

  static const String _logoPath = 'assets/images/post.jpg';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// date row
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeTextWidget(
                text: 'السبت, 15 فبراير 2025',
                fontSize: 10.sp,
              ),
            ],
          ),
          SizedBox(height: 8.h),

          /// teams & time row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// right team name
              AutoSizeTextWidget(
                text: 'الشهيد يحيى السنوار',
                fontSize: 8.sp,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(width: 8.w),

              OnlineImagesWidget(
                imageUrl: '',
                fit: BoxFit.cover,
                size: Size(23.w, 23.h),
                borderRadius: 8.r,
              ),
              SizedBox(width: 4.w),

              AutoSizeTextWidget(
                text: '10:00 م',
                fontSize: 8.sp,
              ),

              SizedBox(width: 4.w),

              OnlineImagesWidget(
                imageUrl: '',
                fit: BoxFit.cover,
                size: Size(23.w, 23.h),
                borderRadius: 8.r,
              ),
              SizedBox(width: 8.w),

              AutoSizeTextWidget(
                text: 'الشهيد مروان عيسى',
                fontSize: 8.sp,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeamLogo() {
    return Container(
      width: 20.r,
      height: 20.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.greySwatch.shade200,
          width: 1.r,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        _logoPath,
        fit: BoxFit.cover,
      ),
    );
  }
}

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statuses = [
      'https://.../image1.jpg',
      'https://.../image2.jpg',
      'https://.../image3.jpg',
      'https://.../image4.jpg',
    ];

    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        // padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: statuses.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return _StatusCard(imageUrl: statuses[index]);
        },
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String imageUrl;

  const _StatusCard({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // الخلفية (الصورة)
            OnlineImagesWidget(
              imageUrl: 'imagePath',
              fit: BoxFit.cover,
              //size: Size(double.infinity, 114.h),
              borderRadius: 8.r,
            ),

            // تدرّج خفيف من الأسفل
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.35),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // زر التشغيل
            Center(
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  size: 34,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
