import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../data/model/match_lineups_model.dart';

class MatchLineupsCoachCardWidget extends StatelessWidget {
  final MatchLineupCoachModel? coach;
  final String teamName;

  const MatchLineupsCoachCardWidget({
    super.key,
    this.coach,
    required this.teamName,
  });

  @override
  Widget build(BuildContext context) {
    final coachName = coach?.commonName ?? coach?.name ?? 'غير محدد';
    final coachImage = coach?.image ?? '';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Center(
              child: AutoSizeTextWidget(
                text: 'المدرب',
                fontWeight: FontWeight.w800,
                fontSize: 13.sp,
                colorText: AppColors.mainColorFont,
              ),
            ),
          ),
          const Divider(height: 1, color: Color(0xfff5f3f9)),

          // Coach Row details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: [
                // Photo circle
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.greySwatch.shade100,
                    border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.center,
                  child: coachImage.isNotEmpty
                      ? OnlineImagesWidget(
                          imageUrl: coachImage,
                          size: Size(40.r, 40.r),
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.person, size: 24.r, color: AppColors.fontColor3),
                ),
                16.w.horizontalSpace,

                // Coach text names
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeTextWidget(
                      text: coachName,
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w700,
                      colorText: AppColors.mainColorFont,
                    ),
                    2.h.verticalSpace,
                    AutoSizeTextWidget(
                      text: teamName.isNotEmpty ? teamName : 'مدرب الفريق',
                      fontSize: 10.5.sp,
                      colorText: AppColors.fontColor2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
