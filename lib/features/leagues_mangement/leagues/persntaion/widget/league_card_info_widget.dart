import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/league_model.dart';

class LeagueCardInfoWidget extends StatelessWidget {
  final LeagueModel leagueModel;
  final Color cardBg;

  const LeagueCardInfoWidget({
    super.key,
    required this.leagueModel,
    required this.cardBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      color: cardBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(
            text: leagueModel.name ?? '',
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            colorText: const Color(0xff292D32),
            maxLines: 1,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              AutoSizeTextWidget(
                text: leagueModel.subscriptionPrice ?? '1000 ريال',
                fontSize: 11.sp,
                colorText: AppColors.primaryColor,
                maxLines: 1,
              ),
              SizedBox(width: 6.w),
              const AutoSizeTextWidget(
                text: '/ نادي الكامب نو',
                fontSize: 10,
                colorText: Color(0xff8E95A2),
                maxLines: 1,
              ),
            ],
          ),
          6.h.verticalSpace,
        ],
      ),
    );
  }
}
