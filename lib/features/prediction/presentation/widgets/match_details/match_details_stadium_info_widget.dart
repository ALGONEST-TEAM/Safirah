import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_details_model.dart';

class MatchDetailsStadiumInfoWidget extends StatelessWidget {
  final MatchVenueModel? venue;
  final int? attendance;
  final bool hasStarted;

  const MatchDetailsStadiumInfoWidget({
    super.key,
    this.venue,
    this.attendance,
    this.hasStarted = false,
  });

  String _formatNumber(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }

  String _translateSurface(String surface) {
    final lower = surface.toLowerCase();
    if (lower.contains('grass')) return 'عشب طبيعي';
    if (lower.contains('synthetic') || lower.contains('artificial')) return 'عشب صناعي';
    return surface.isNotEmpty ? surface : 'غير متوفر';
  }

  @override
  Widget build(BuildContext context) {
    if (venue == null) return const SizedBox.shrink();

    final int capacityVal = venue!.capacity ?? 0;

    // Attendance calculation: Default to 80% of capacity if missing, ONLY when match has started or finished
    int effectiveAttendance = attendance ?? 0;
    if (effectiveAttendance <= 0 && hasStarted && capacityVal > 0) {
      effectiveAttendance = (capacityVal * 0.80).round();
    }

    final double percentage = (capacityVal > 0 && effectiveAttendance > 0)
        ? (effectiveAttendance / capacityVal).clamp(0.0, 1.0)
        : 0.0;
    final String percentageStr = '${(percentage * 100).toInt()}%';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.greySwatch.shade100, width: 0.8),
      ),
      child: Column(
        children: [
          // Top Section: Stadium Name & City
          Row(
            children: [
              Icon(
                Icons.stadium_outlined,
                color: AppColors.mainColorFont,
                size: 20.r,
              ),
              12.w.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeTextWidget(
                      text: venue!.name.isNotEmpty ? venue!.name : 'غير متوفر',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      colorText: AppColors.fontColor,
                    ),
                    4.h.verticalSpace,
                    AutoSizeTextWidget(
                      text: venue!.city.isNotEmpty ? venue!.city : 'غير متوفر',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      colorText: AppColors.fontColor2,
                    ),
                  ],
                ),
              ),
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.greySwatch.shade100, width: 1),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.location_on,
                  color: const Color(0xff1B144A),
                  size: 18.r,
                ),
              ),
            ],
          ),

          // Capacity & Attendance Section
          if (capacityVal > 0) ...[
            8.h.verticalSpace,
            Divider(height: 1, thickness: 1, color: AppColors.greySwatch.shade100),
            8.h.verticalSpace,
            Row(
              children: [
                Icon(
                  Icons.airline_seat_recline_normal_outlined,
                  color: AppColors.mainColorFont,
                  size: 20.r,
                ),
                8.w.horizontalSpace,
                AutoSizeTextWidget(
                  text: _formatNumber(capacityVal),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  colorText: AppColors.mainColorFont,
                ),
                8.w.horizontalSpace,
                AutoSizeTextWidget(
                  text: 'السعة',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  colorText: AppColors.mainColorFont,
                ),
              ],
            ),
            // Attendance row shown ONLY if match has started or finished and effective attendance is available
            if (hasStarted && effectiveAttendance > 0) ...[
              4.h.verticalSpace,
              Row(
                children: [
                  SizedBox(width: 20.r),
                  8.w.horizontalSpace,
                  AutoSizeTextWidget(
                    text: _formatNumber(effectiveAttendance),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    colorText: AppColors.mainColorFont,
                  ),
                  8.w.horizontalSpace,
                  AutoSizeTextWidget(
                    text: 'الحضور',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    colorText: AppColors.mainColorFont,
                  ),
                ],
              ),
              4.h.verticalSpace,
              // Progress Bar
              LayoutBuilder(
                builder: (context, constraints) {
                  final double barWidth = constraints.maxWidth;
                  final double fillWidth = barWidth * percentage;
                  return SizedBox(
                    height: 24.h,
                    child: Stack(
                      alignment: Alignment.centerRight,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: 4.h,
                          width: barWidth,
                          decoration: BoxDecoration(
                            color: AppColors.greySwatch.shade200,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        Container(
                          height: 4.h,
                          width: fillWidth,
                          decoration: BoxDecoration(
                            color: const Color(0xff1B144A),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        Positioned(
                          right: (fillWidth - 22.w).clamp(0.0, barWidth - 44.w),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: const Color(0xff1B144A),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: AutoSizeTextWidget(
                              text: percentageStr,
                              fontSize: 11.sp,
                              colorText: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ],

          // Pitch Surface Section
          if (venue!.surface.isNotEmpty) ...[
            8.h.verticalSpace,
            Divider(height: 1, thickness: 1, color: AppColors.greySwatch.shade100),
            8.h.verticalSpace,
            Row(
              children: [
                Icon(
                  Icons.texture_outlined,
                  color: AppColors.mainColorFont,
                  size: 18.r,
                ),
                12.w.horizontalSpace,
                AutoSizeTextWidget(
                  text: _translateSurface(venue!.surface),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  colorText: AppColors.mainColorFont,
                ),
                16.w.horizontalSpace,
                AutoSizeTextWidget(
                  text: 'سطح الملعب',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  colorText: AppColors.fontColor2,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
