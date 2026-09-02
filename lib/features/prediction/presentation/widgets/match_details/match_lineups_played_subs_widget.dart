import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class PlayedSubMock {
  final String name;
  final int number;
  final String rating;
  final int minute;
  final String replacedName;
  final bool hasGoal;
  final bool hasCard;
  final bool isInjuredReplaced;
  final String? photoUrl;

  PlayedSubMock({
    required this.name,
    required this.number,
    required this.rating,
    required this.minute,
    required this.replacedName,
    this.hasGoal = false,
    this.hasCard = false,
    this.isInjuredReplaced = false,
    this.photoUrl,
  });
}

class MatchLineupsPlayedSubsWidget extends StatelessWidget {
  final bool showHomeTeam;

  const MatchLineupsPlayedSubsWidget({super.key, required this.showHomeTeam});

  @override
  Widget build(BuildContext context) {
    // High-fidelity mockup data matching the screenshot
    final List<PlayedSubMock> homeSubs = [
      PlayedSubMock(name: 'باركولا', number: 12, rating: '6.7', minute: 46, replacedName: 'دوي', hasGoal: true),
      PlayedSubMock(name: 'دين', number: 3, rating: '5.8', minute: 46, replacedName: 'هيرنانديز'),
      PlayedSubMock(name: 'أوباميكانو', number: 4, rating: '6.5', minute: 46, replacedName: 'كوناتي'),
      PlayedSubMock(name: 'ديمبيلي', number: 7, rating: '7.4', minute: 46, replacedName: 'شرقي', hasGoal: true),
      PlayedSubMock(name: 'كوندي', number: 5, rating: '-', minute: 90, replacedName: 'جوستو', isInjuredReplaced: true),
    ];

    final List<PlayedSubMock> awaySubs = [
      PlayedSubMock(name: 'تريبييه', number: 11, rating: '6.4', minute: 46, replacedName: 'جيمس'),
      PlayedSubMock(name: 'سارة', number: 16, rating: '6.1', minute: 62, replacedName: 'ستونز'),
      PlayedSubMock(name: 'مادوييكي', number: 7, rating: '6.2', minute: 74, replacedName: 'روجرز'),
    ];

    final subs = showHomeTeam ? homeSubs : awaySubs;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.greySwatch.shade100, width: 0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Align(
            alignment: Alignment.centerRight,
            child: AutoSizeTextWidget(
              text: 'البدلاء',
              fontWeight: FontWeight.w800,
              fontSize: 14.sp,
              colorText: AppColors.mainColorFont,
            ),
          ),
          12.h.verticalSpace,
          Divider(height: 1, color: AppColors.greySwatch.shade100),
          16.h.verticalSpace,

          // Substitutes grid-like layout (3 columns max)
          Wrap(
            spacing: 12.w,
            runSpacing: 16.h,
            alignment: WrapAlignment.start,
            children: subs.map((sub) => _SubItemWidget(sub: sub)).toList(),
          ),
        ],
      ),
    );
  }
}

// ── Single substitute item ──────────────────────────────────────────────────
class _SubItemWidget extends StatelessWidget {
  final PlayedSubMock sub;

  const _SubItemWidget({required this.sub});

  Color _ratingColor(String r) {
    if (r == '-') return const Color(0xff9e9e9e);
    final val = double.tryParse(r) ?? 0.0;
    if (val >= 7.0) return const Color(0xff10b981);
    if (val >= 6.0) return const Color(0xfff59e0b);
    return const Color(0xfff97316);
  }

  @override
  Widget build(BuildContext context) {
    final rateColor = _ratingColor(sub.rating);

    return SizedBox(
      width: 102.w, // Perfect width for 3 items to fit on typical screens
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Minute & Green Arrow (left side of circle)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AutoSizeTextWidget(
                    text: "${sub.minute}'",
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    colorText: AppColors.fontColor,
                  ),
                  4.h.verticalSpace,
                  Icon(
                    Icons.arrow_upward_rounded,
                    size: 14.sp,
                    color: const Color(0xff10b981), // Green entry arrow
                  ),
                ],
              ),
              
              // Vertical separator
              Container(
                width: 0.8,
                height: 32.h,
                color: AppColors.greySwatch.shade300,
                margin: EdgeInsets.symmetric(horizontal: 6.w),
              ),

              // Player Photo circle stack
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  // Photo circle
                  Container(
                    width: 38.r,
                    height: 38.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.greySwatch.shade100,
                      border: Border.all(color: AppColors.greySwatch.shade200, width: 1),
                    ),
                    child: ClipOval(
                      child: sub.photoUrl != null
                          ? Image.network(sub.photoUrl!, fit: BoxFit.cover)
                          : Icon(Icons.person, size: 24.r, color: AppColors.fontColor3),
                    ),
                  ),

                  // Jersey number – top-left
                  Positioned(
                    top: -4.h,
                    left: -4.w,
                    child: Container(
                      width: 13.r,
                      height: 13.r,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.greySwatch.shade300, width: 0.5),
                      ),
                      alignment: Alignment.center,
                      child: AutoSizeTextWidget(
                        text: '${sub.number}',
                        fontSize: 6.sp,
                        fontWeight: FontWeight.w900,
                        colorText: AppColors.mainColorFont,
                      ),
                    ),
                  ),

                  // Event icon (e.g. goal) – top-right
                  if (sub.hasGoal)
                    Positioned(
                      top: -4.h,
                      right: -4.w,
                      child: Container(
                        width: 13.r,
                        height: 13.r,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.greySwatch.shade300, width: 0.5),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.sports_soccer, size: 9.sp, color: Colors.black),
                      ),
                    ),

                  // Rating pill – bottom-center
                  Positioned(
                    bottom: -6.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: rateColor,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: AutoSizeTextWidget(
                          text: sub.rating,
                          fontSize: 7.sp,
                          fontWeight: FontWeight.w800,
                          colorText: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          12.h.verticalSpace,

          // Name of incoming player
          AutoSizeTextWidget(
            text: sub.name,
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
            colorText: const Color(0xff10b981), // Green text
            textAlign: TextAlign.center,
          ),
          
          4.h.verticalSpace,

          // Name of outgoing player (with optional medical cross icon)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (sub.isInjuredReplaced) ...[
                Icon(
                  Icons.add_circle, // Red medical cross icon style
                  size: 11.sp,
                  color: const Color(0xffef4444),
                ),
                4.w.horizontalSpace,
              ],
              Flexible(
                child: AutoSizeTextWidget(
                  text: sub.replacedName,
                  fontSize: 11.sp,
                  colorText: AppColors.fontColor2,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                //  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
