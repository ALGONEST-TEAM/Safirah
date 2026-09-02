import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_details_model.dart';
import 'match_header_button_widget.dart';

class MatchHeaderTitleWidget extends StatelessWidget {
  final MatchDetailsModel matchDetails;
  final String leagueName;
  final VoidCallback onBackTap;

  const MatchHeaderTitleWidget({
    super.key,
    required this.matchDetails,
    required this.leagueName,
    required this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: MatchHeaderButtonWidget(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 16.sp,
                color: AppColors.mainColorFont,
              ),
              onTap: onBackTap,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeTextWidget(
                text: "${matchDetails.teams?.home?.name ?? 'فريق'} ضد ${matchDetails.teams?.away?.name ?? 'فريق'}",
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                colorText: AppColors.mainColorFont,
                textAlign: TextAlign.center,
              ),
              4.h.verticalSpace,
              AutoSizeTextWidget(
                text: leagueName,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                colorText: AppColors.fontColor2,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
