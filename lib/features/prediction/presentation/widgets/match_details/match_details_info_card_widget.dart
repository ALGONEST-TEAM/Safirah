import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../data/model/match_details_model.dart';

class MatchDetailsInfoCardWidget extends StatelessWidget {
  final MatchDetailsModel matchDetails;

  const MatchDetailsInfoCardWidget({
    super.key,
    required this.matchDetails,
  });

  String _formatArabicDateTime(String dateStr, String timeStr) {
    if (dateStr.isEmpty) return 'غير متوفر';

    try {
      final String cleanTime = timeStr.isNotEmpty ? timeStr : '00:00:00';
      final DateTime dt = DateTime.parse('${dateStr.trim()}T${cleanTime.trim()}');

      const daysAr = {
        1: 'الإثنين',
        2: 'الثلاثاء',
        3: 'الأربعاء',
        4: 'الخميس',
        5: 'الجمعة',
        6: 'السبت',
        7: 'الأحد',
      };

      const monthsAr = {
        1: 'يناير',
        2: 'فبراير',
        3: 'مارس',
        4: 'أبريل',
        5: 'مايو',
        6: 'يونيو',
        7: 'يوليو',
        8: 'أغسطس',
        9: 'سبتمبر',
        10: 'أكتوبر',
        11: 'نوفمبر',
        12: 'ديسمبر',
      };

      final String dayName = daysAr[dt.weekday] ?? '';
      final String monthName = monthsAr[dt.month] ?? '';
      final int hour12 = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
      final String period = dt.hour >= 12 ? 'م' : 'ص';
      final String formattedTime = '${hour12}:${dt.minute.toString().padLeft(2, '0')} $period';

      return '$dayName، ${dt.day} $monthName, $formattedTime';
    } catch (_) {
      return '$dateStr $timeStr'.trim();
    }
  }

  String _getSeasonStr(MatchDetailsModel matchDetails) {
    final String? seasonName = matchDetails.competition?.season?.name;
    if (seasonName != null && seasonName.isNotEmpty) {
      return seasonName;
    }

    // Fallback: Automatic derivation from match date if season is missing
    if (matchDetails.date.isNotEmpty) {
      try {
        final DateTime dt = DateTime.parse(matchDetails.date.trim());
        if (dt.month >= 7) {
          return '${dt.year}/${dt.year + 1}';
        } else {
          return '${dt.year - 1}/${dt.year}';
        }
      } catch (_) {}
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    // Format Arabic Date & Time (e.g. الأحد، 17 مايو, 10:15 م)
    final String dateTimeStr = _formatArabicDateTime(matchDetails.date, matchDetails.time);

    // Format Competition + Round + Season (e.g. الدوري الإسباني الجولة 37 - 2025/2026)
    final String leagueName = matchDetails.competition?.name ?? '';
    final String roundStr = matchDetails.round != null ? 'الجولة ${matchDetails.round}' : '';
    final String seasonStr = _getSeasonStr(matchDetails);

    final List<String> parts = [];
    if (leagueName.isNotEmpty) parts.add(leagueName);
    if (roundStr.isNotEmpty) parts.add(roundStr);

    String leagueInfo = parts.join(' ');
    if (seasonStr.isNotEmpty) {
      if (leagueInfo.isNotEmpty) {
        leagueInfo = '$leagueInfo - $seasonStr';
      } else {
        leagueInfo = seasonStr;
      }
    }
    if (leagueInfo.isEmpty) leagueInfo = 'غير متوفر';

    // Competition Logo
    final String compLogo = matchDetails.competition?.logo ?? '';

    // Get dynamic referee
    final mainReferee = matchDetails.mainReferee;
    final String refereeName = mainReferee != null
        ? (mainReferee.name.isNotEmpty ? mainReferee.name : mainReferee.commonName)
        : 'غير متوفر';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.greySwatch.shade100, width: 0.8),
      ),
      child: Column(
        children: [
          // Row 1: Formatted Arabic Date and Time (الأحد، 17 مايو, 10:15 م)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.calendar_month_outlined,
                size: 20.r,
                color: AppColors.fontColor,
              ),
              12.w.horizontalSpace,
              AutoSizeTextWidget(
                text: dateTimeStr,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                colorText: AppColors.fontColor,
              ),
            ],
          ),
          10.h.verticalSpace,

          // Row 2: League Logo, League Name, Round & Season
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (compLogo.isNotEmpty) ...[
                Container(
                  width: 20.r,
                  height: 20.r,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.antiAlias,
                  child: OnlineImagesWidget(
                    imageUrl: compLogo,
                    size: Size(20.r, 20.r),
                    fit: BoxFit.contain,
                  ),
                ),
                12.w.horizontalSpace,
              ] else ...[
                Icon(
                  Icons.emoji_events_outlined,
                  color: AppColors.fontColor,
                  size: 20.r,
                ),
                12.w.horizontalSpace,
              ],
              Expanded(
                child: AutoSizeTextWidget(
                  text: leagueInfo,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  colorText: AppColors.fontColor,
                ),
              ),
            ],
          ),
          10.h.verticalSpace,

          // Row 3: Referee (Dynamic from API)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.sports_rounded,
                size: 20.r,
                color: AppColors.fontColor,
              ),
              12.w.horizontalSpace,
              Expanded(
                child: AutoSizeTextWidget(
                  text: refereeName,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  colorText: AppColors.fontColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
