import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import 'leader_board_header_widget.dart';
import 'leader_board_rank_widget.dart';

class LeaderboardItem {
  final int rank;
  final String name;
  final String username;
  final int correct;
  final int wrong;
  final int points;
  final Movement movement;

  const LeaderboardItem({
    required this.rank,
    required this.name,
    required this.username,
    required this.correct,
    required this.wrong,
    required this.points,
    this.movement = Movement.none,
  });
}

class LeaderboardWidget extends StatelessWidget {
  const LeaderboardWidget({
    super.key,
  });

  final List<LeaderboardItem> items = const [
    LeaderboardItem(
        rank: 1,
        name: 'عبدالله الانسي',
        username: '@abdullahanse',
        correct: 50,
        wrong: 20,
        points: 20,
        movement: Movement.up),
    LeaderboardItem(
        rank: 2,
        name: 'أسامة جريد',
        username: '@osame1010',
        correct: 50,
        wrong: 20,
        points: 20,
        movement: Movement.down),
    LeaderboardItem(
        rank: 3,
        name: 'فهد القحطاني',
        username: '@faha7a',
        correct: 50,
        wrong: 20,
        points: 20,
        movement: Movement.up),
    LeaderboardItem(
        rank: 4,
        name: 'مرتضى مصطفى',
        username: '@masl7a',
        correct: 50,
        wrong: 20,
        points: 20,
        movement: Movement.down),
    LeaderboardItem(
        rank: 5,
        name: 'يحيى عزيز',
        username: '@y7yaa',
        correct: 50,
        wrong: 20,
        points: 20,
        movement: Movement.none),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(12.sp).copyWith(bottom: 38.h),
      child: Column(
        spacing: 6.h,
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10.h,
                children: [
                  _infoRow(AppIcons.players, 'عدد الاعبين المشاركين: ', '200'),
                  _infoRow(AppIcons.dateEdit, 'الموسم السنوي: ', '2026-2025'),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeTextWidget(
                    text: "أسبوعي",
                    fontSize: 13.4.sp,
                    colorText: AppColors.fontColor,
                  ),
                  SvgPicture.asset(
                    AppIcons.arrowBottom,
                    color: AppColors.secondaryColor,
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            elevation: 0,
            child: Column(
              spacing: 8.h,
              children: [
                const LeaderBoardHeaderWidget(),
                Column(
                  children: List.generate(items.length, (i) {
                    final item = items[i];
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4.w,
                            children: [
                              LeaderBoardRankWidget(
                                rank: item.rank,
                                movement: item.movement,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 4.h,
                                  children: [
                                    AutoSizeTextWidget(
                                      text: item.name,
                                      fontSize: 12.sp,
                                      minFontSize: 12,
                                      maxLines: 2,
                                    ),
                                    AutoSizeTextWidget(
                                      text: item.username,
                                      fontSize: 10.sp,
                                      colorText: AppColors.fontColor
                                          .withValues(alpha: .6),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 6.h,
                                  children: [
                                    AutoSizeTextWidget(
                                      text: '${item.correct} توقع صحيح',
                                      fontSize: 10.sp,
                                      colorText: AppColors.fontColor
                                          .withValues(alpha: .6),
                                      maxLines: 2,
                                    ),
                                    AutoSizeTextWidget(
                                      text: '${item.wrong} توقع غير صحيح',
                                      fontSize: 10.sp,
                                      colorText: AppColors.fontColor
                                          .withValues(alpha: .6),
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 54.w,
                                child: AutoSizeTextWidget(
                                  text: item.points.toString(),
                                  fontSize: 11.sp,
                                  textAlign: TextAlign.end,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (i != items.length - 1)
                          Divider(
                            height: 10.h,
                            color: AppColors.fontColor2.withValues(alpha: .14),
                          ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String iconAsset, String label, String value) {
    return Row(
      children: [
        SvgPicture.asset(iconAsset),
        4.w.horizontalSpace,
        AutoSizeTextWidget(
          text: label,
          fontSize: 11.6.sp,
          colorText: AppColors.fontColor,
        ),
        AutoSizeTextWidget(
          text: value,
          fontSize: 11.6.sp,
          colorText: AppColors.secondaryColor,
        ),
      ],
    );
  }
}
