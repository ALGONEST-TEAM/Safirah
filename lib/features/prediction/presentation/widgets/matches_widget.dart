import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/state/check_state_in_get_api_data_widget.dart';
import 'package:safirah/core/theme/app_colors.dart';

import '../../../../core/widgets/auto_size_text_widget.dart';
import '../riverpod/prediction_riverpod.dart';
import 'match_card_widget.dart';
import 'shimmer_matches_widget.dart';

class MatchesWidget extends ConsumerWidget {
  const MatchesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(getAllMatchesProvider);

    return CheckStateInGetApiDataWidget(
      state: state,
      refresh: () {
        ref.invalidate(getAllMatchesProvider);
      },
      widgetOfLoading: const ShimmerMatchesWidget(),
      widgetOfData: RefreshIndicator(
        backgroundColor: Colors.white,
        color: AppColors.primaryColor,
        onRefresh: () async {
          ref.invalidate(getAllMatchesProvider);
        },
        child: ListView.builder(
          padding:
              EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 38.h),
          itemCount: state.data.length,
          itemBuilder: (context, dayIndex) {
            final day = state.data[dayIndex];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w).copyWith(top: 12.h),
                  child: AutoSizeTextWidget(
                    text: day.date,
                    fontSize: 10.6.sp,
                  ),
                ),
                ...day.leagues.map(
                  (league) => Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: MatchCardWidget(
                      data: league,
                      date: day.date,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

final List<MatchSection> sections = [
  MatchSection(
    title: 'إنجلترا - الدوري الإنجليزي الممتاز',
    items: [
      MatchItem(
        id: 1,
        home: 'إيفرتون',
        away: 'تشيلسي',
        time: '16:00',
        image:
            'https://e7.pngegg.com/pngimages/390/715/png-clipart-real-madrid-c-f-uefa-champions-league-dream-league-soccer-la-liga-desktop-football-emblem-logo.png',
        awayImage:
            'https://e7.pngegg.com/pngimages/59/955/png-clipart-f-c-barcelona-logo-fc-barcelona-handbol-uefa-champions-league-la-liga-fc-barcelona-logo-text-logo-thumbnail.png',
      ),
      MatchItem(
        id: 2,
        home: 'رينجرز',
        away: 'ليفربول',
        time: '16:00',
        image:
            'https://e7.pngegg.com/pngimages/390/715/png-clipart-real-madrid-c-f-uefa-champions-league-dream-league-soccer-la-liga-desktop-football-emblem-logo.png',
        awayImage:
            'https://e7.pngegg.com/pngimages/59/955/png-clipart-f-c-barcelona-logo-fc-barcelona-handbol-uefa-champions-league-la-liga-fc-barcelona-logo-text-logo-thumbnail.png',
      ),
      MatchItem(
        id: 3,
        home: 'نوريتش سيتي',
        away: ' مانشستر سيتي',
        time: '20:00',
        image:
            'https://e7.pngegg.com/pngimages/390/715/png-clipart-real-madrid-c-f-uefa-champions-league-dream-league-soccer-la-liga-desktop-football-emblem-logo.png',
        awayImage:
            'https://e7.pngegg.com/pngimages/59/955/png-clipart-f-c-barcelona-logo-fc-barcelona-handbol-uefa-champions-league-la-liga-fc-barcelona-logo-text-logo-thumbnail.png',
      ),
      MatchItem(
        id: 4,
        home: 'مانشستر يونايتد',
        away: 'نيوكاسل يونايتد',
        time: '22:00',
        image:
            'https://e7.pngegg.com/pngimages/390/715/png-clipart-real-madrid-c-f-uefa-champions-league-dream-league-soccer-la-liga-desktop-football-emblem-logo.png',
        awayImage:
            'https://e7.pngegg.com/pngimages/59/955/png-clipart-f-c-barcelona-logo-fc-barcelona-handbol-uefa-champions-league-la-liga-fc-barcelona-logo-text-logo-thumbnail.png',
      ),
      MatchItem(
        id: 5,
        home: 'ستوك سيتي',
        away: 'ساوثهامبتون',
        time: '22:00',
        image:
            'https://e7.pngegg.com/pngimages/390/715/png-clipart-real-madrid-c-f-uefa-champions-league-dream-league-soccer-la-liga-desktop-football-emblem-logo.png',
        awayImage:
            'https://e7.pngegg.com/pngimages/59/955/png-clipart-f-c-barcelona-logo-fc-barcelona-handbol-uefa-champions-league-la-liga-fc-barcelona-logo-text-logo-thumbnail.png',
      ),
    ],
  ),
  MatchSection(
    title: 'إسبانيا - الدوري الإسباني لا ليغا',
    items: [
      MatchItem(
        id: 6,
        home: 'فياريال',
        away: 'برشلونة',
        time: '16:00',
        image:
            'https://e7.pngegg.com/pngimages/390/715/png-clipart-real-madrid-c-f-uefa-champions-league-dream-league-soccer-la-liga-desktop-football-emblem-logo.png',
        awayImage:
            'https://e7.pngegg.com/pngimages/59/955/png-clipart-f-c-barcelona-logo-fc-barcelona-handbol-uefa-champions-league-la-liga-fc-barcelona-logo-text-logo-thumbnail.png',
      ),
      MatchItem(
        id: 7,
        home: 'ريال مدريد',
        away: 'أتلتيكو مدريد',
        time: '16:00',
        image:
            'https://e7.pngegg.com/pngimages/390/715/png-clipart-real-madrid-c-f-uefa-champions-league-dream-league-soccer-la-liga-desktop-football-emblem-logo.png',
        awayImage:
            'https://e7.pngegg.com/pngimages/59/955/png-clipart-f-c-barcelona-logo-fc-barcelona-handbol-uefa-champions-league-la-liga-fc-barcelona-logo-text-logo-thumbnail.png',
      ),
    ],
  ),
];

class MatchSection {
  final String title;
  final List<MatchItem> items;

  MatchSection({required this.title, required this.items});
}

class MatchItem {
  final int id;
  final String home;
  final String image;
  final String awayImage;

  final String away;
  final String time;

  MatchItem({
    required this.id,
    required this.home,
    required this.away,
    required this.time,
    required this.image,
    required this.awayImage,
  });
}
