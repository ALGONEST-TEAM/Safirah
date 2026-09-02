import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../data/model/match_fixture_standings_model.dart';

class MatchStandingsCompetitionHeaderWidget extends StatelessWidget {
  final MatchStandingsCompetitionModel competition;

  const MatchStandingsCompetitionHeaderWidget({
    super.key,
    required this.competition,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            children: [
              if (competition.imagePath.isNotEmpty) ...[
                Container(
                  width: 22.r,
                  height: 22.r,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  clipBehavior: Clip.antiAlias,
                  child: OnlineImagesWidget(
                    imageUrl: competition.imagePath,
                    size: Size(22.r, 22.r),
                    fit: BoxFit.contain,
                  ),
                ),
                8.w.horizontalSpace,
              ],
              AutoSizeTextWidget(
                text: competition.name,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                colorText: AppColors.fontColor,
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Color(0xfff5f3f9)),
      ],
    );
  }
}
