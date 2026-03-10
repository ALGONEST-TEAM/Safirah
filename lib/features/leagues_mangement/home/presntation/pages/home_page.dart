import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/constants/app_icons.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import 'package:safirah/core/widgets/logo_shimmer_widget.dart';
import 'package:safirah/features/leagues_mangement/leagues/persntaion/page/create_league_page.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/auth/auth.dart';
import '../../../../notifications/presentation/pages/notifications_page.dart';
import '../../../../notifications/presentation/state_mangment/notifications_riverpod.dart';
import '../../../../user/presentation/pages/log_in_page.dart';
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
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'انشاء دوري',
        elevation: 0,
        onPressed: () {
          navigateTo(context, const CreateLeaguePage());
        },
        backgroundColor: AppColors.primaryColor,
        label: AutoSizeTextWidget(
          text: 'انشاء دوري',
          colorText: Colors.white,
          fontSize: 10.sp,
        ),
        icon: const Icon(Icons.add, color: Colors.white, size: 16),
      ),
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.w.horizontalSpace,
            AutoSizeTextWidget(
              text: S.of(context).welcome,
              colorText: AppColors.fontColor,
              fontSize: 12.6.sp,
            ),
            4.w.horizontalSpace,
            Flexible(
              child: AutoSizeTextWidget(
                text: Auth().name,
                colorText: AppColors.secondaryColor,
                fontSize: 12.6.sp,
                maxLines: 2,
              ),
            ),
            12.w.horizontalSpace,
          ],
        ),
        actions: [
          Consumer(builder: (context, ref, _) {
            final unread = ref.watch(unreadCountProvider);

            return Stack(
              clipBehavior: Clip.none,
              children: [
                IconButtonWidget(
                  icon: AppIcons.notification,
                  height: 20.h,
                  onPressed: () async {
                    if (!Auth().loggedIn) {
                      navigateTo(context, const LogInPage());
                    } else {
                      navigateTo(context, const NotificationsPage());
                      ref.read(unreadCountProvider.notifier).refresh();
                    }
                  },
                ),
                if (unread > 0)
                  Positioned(
                    top: 1,
                    left: unread >= 10 ? 4.w : 6.w,
                    child: Container(
                      padding: EdgeInsets.all(unread >= 10 ? 1.6.sp : 2.sp),
                      decoration: BoxDecoration(
                        color: AppColors.dangerColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                      ),
                      child: AutoSizeTextWidget(
                        text: unread > 99 ? '99+' : ' $unread ',
                        colorText: Colors.white,
                        fontSize: 7.2.sp,
                        minFontSize: 6,
                      ),
                    ),
                  ),
              ],
            );
          }),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.data.banners.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: BannersWidget(banners: state.data.banners),
                    ),
                  if (state.data.highlightsByLeague.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h)
                          .copyWith(bottom: 8.h),
                      child: const AutoSizeTextWidget(
                        text: 'ابرز اللحظات',
                      ),
                    ),
                    StoriesListWidget(stories: state.data.highlightsByLeague),
                  ],
                  if (state.data.upcomingMatches.isNotEmpty) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.h)
                          .copyWith(bottom: 8.h, top: 12.h),
                      child: const AutoSizeTextWidget(
                        text: 'المباريات القادمة',
                      ),
                    ),
                    UpcomingMatchCardWidget(
                        matches: state.data.upcomingMatches),
                  ],
                  if (state.data.news.isNotEmpty) ...[
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
                            onTap: () {
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
                          return LatestNewsCardWidget(
                            news: state.data.news[index],
                            size: Size(300.w, 180.h),
                          );
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
