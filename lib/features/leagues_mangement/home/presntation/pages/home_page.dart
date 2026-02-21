import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/constants/app_icons.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import 'package:safirah/core/widgets/logo_shimmer_widget.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../riverpod/home_riverpod.dart';
import '../widgets/banners_widget.dart';
import '../widgets/latest_news_card_widget.dart';
import '../widgets/stories_list_widget.dart';
import '../widgets/upcoming_match_card_widget.dart';
import 'latest_news_page.dart';

class HomePages extends ConsumerWidget {
  const HomePages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(getAllItemsLeagueHomeProvider);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColor,
        leadingWidth: 60.w,
        leading: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: CircleAvatar(
            radius: 11.r,
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(
              AppIcons.logo,
              width: 27.w,
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
        top: false,
        child: CheckStateInGetApiDataWidget(
          state: state,
          widgetOfLoading: const LogoShimmerWidget(),
          refresh: () {
            ref.invalidate(getAllItemsLeagueHomeProvider);
          },
          widgetOfData: RefreshIndicator(
            backgroundColor: Colors.white,
            color: AppColors.primaryColor,
            onRefresh: () async {
              ref.invalidate(getAllItemsLeagueHomeProvider);
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(state.data.banners.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: BannersWidget(banners: state.data.banners),
                  ),
                  if(state.data.highlightsByLeague.isNotEmpty)...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h)
                          .copyWith(bottom: 8.h),
                      child: const AutoSizeTextWidget(
                        text: 'ابرز اللحظات',
                      ),
                    ),
                    StoriesListWidget(stories: state.data.highlightsByLeague),
                  ],
                  if(state.data.upcomingMatches.isNotEmpty)...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h)
                          .copyWith(bottom: 8.h, top: 12.h),
                      child: const AutoSizeTextWidget(
                        text: 'المباريات القادمة',
                      ),
                    ),
                    UpcomingMatchCardWidget(matches: state.data.upcomingMatches),
                  ],
                  if(state.data.news.isNotEmpty)...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h)
                          .copyWith(bottom: 10.h, top: 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeTextWidget(
                            text: 'آخر الأخبار',
                          ),
                          InkWell(
                            onTap: (){
                              navigateTo(context, const LatestNewsPage());
                            },
                            child: AutoSizeTextWidget(
                              text: 'عرض الكل',
                              fontSize: 10.5.sp,
                              colorText: AppColors.fontColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 240.h,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        scrollDirection: Axis.horizontal,
                        itemCount: state.data.news.length,
                        separatorBuilder: (_, __) => SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          return LatestNewsCardWidget(news: state.data
                              .news[index],size: Size(300.w, 180.h),);
                        },
                      ),
                    ),
                  ],
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
