import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/league_for_prediction_model.dart';
import '../../../data/model/team_matches_model.dart';
import '../match_card_widget.dart';

class TeamMatchesListWidget extends StatelessWidget {
  final TeamMatchesModel data;

  const TeamMatchesListWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        padding: EdgeInsets.only(bottom: 30.h, top: 4.h),
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          // Current Match
          if (data.current != null) ...[
            _buildMatchCard(
              title: 'مباراة جارية',
              matches: [data.current!],
            ),
            12.h.verticalSpace,
          ],

          // Upcoming Matches
          if (data.upcoming.isNotEmpty) ...[
            _buildMatchCard(
              title: 'مباريات قادمة',
              matches: data.upcoming,
            ),
            12.h.verticalSpace,
          ],

          // Previous Matches
          if (data.previous.isNotEmpty) ...[
            _buildMatchCard(
              title: 'مباريات سابقة',
              matches: data.previous,
            ),
          ],

          // Empty State
          if (data.current == null &&
              data.upcoming.isEmpty &&
              data.previous.isEmpty)
            Padding(
              padding: EdgeInsets.only(top: 80.h),
              child: const Center(
                child: AutoSizeTextWidget(
                  text: 'لا توجد مباريات متاحة حالياً',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  colorText: AppColors.fontColor2,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMatchCard(
      {required String title, required List<TeamMatchItem> matches}) {
    final leagueModel = LeagueForPredictionModel(
      id: 0,
      name: title,
      logo: '', // We can leave it empty, or use a specific icon if supported
      matches: matches.map((e) => e.toMatchPredictionModel()).toList(),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          6.h.verticalSpace,
          AutoSizeTextWidget(
            text: title,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            colorText: Colors.black,
          ),
          6.h.verticalSpace,
          MatchCardWidget(
            data: leagueModel,
            date: '',
            hideHeader: true,
          ),
        ],
      ),
    );
  }
}
