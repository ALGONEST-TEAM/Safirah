import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/online_images_widget.dart';
import '../../../data/model/match_lineups_model.dart';

class MatchLineupsAbsentPlayersWidget extends StatelessWidget {
  final List<MatchLineupPlayerModel> unavailablePlayers;

  const MatchLineupsAbsentPlayersWidget({
    super.key,
    required this.unavailablePlayers,
  });

  @override
  Widget build(BuildContext context) {
    if (unavailablePlayers.isEmpty) {
      return const SizedBox.shrink();
    }

    // Deduplicate unavailable players by ID or Name to prevent repetition
    final uniqueMap = <String, MatchLineupPlayerModel>{};
    for (final player in unavailablePlayers) {
      final key = player.id > 0
          ? '${player.id}'
          : (player.commonName.isNotEmpty ? player.commonName : player.name)
              .trim()
              .toLowerCase();
      uniqueMap.putIfAbsent(key, () => player);
    }
    final displayList = uniqueMap.values.toList();

    if (displayList.isEmpty) {
      return const SizedBox.shrink();
    }

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
                text: 'اللاعبون الغائبون',
                fontWeight: FontWeight.w800,
                fontSize: 13.sp,
                colorText: AppColors.mainColorFont,
              ),
            ),
          ),

          const Divider(height: 1, color: Color(0xfff5f3f9)),

          // List of unique absent players
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: displayList.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Color(0xfff5f3f9)),
            itemBuilder: (context, index) {
              final player = displayList[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
                  children: [
                    Container(
                      width: 38.r,
                      height: 38.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.greySwatch.shade100,
                        border: Border.all(
                            color: AppColors.greySwatch.shade200, width: 1),
                      ),
                      clipBehavior: Clip.antiAlias,
                      alignment: Alignment.center,
                      child: player.image.isNotEmpty
                          ? OnlineImagesWidget(
                              imageUrl: player.image,
                              size: Size(38.r, 38.r),
                              fit: BoxFit.cover,
                            )
                          : Icon(Icons.person,
                              size: 24.r, color: AppColors.fontColor3),
                    ),
                    16.w.horizontalSpace,

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeTextWidget(
                          text: player.commonName.isNotEmpty
                              ? player.commonName
                              : player.name,
                          fontSize: 12.5.sp,
                          fontWeight: FontWeight.w600,
                          colorText: AppColors.mainColorFont,
                        ),
                        2.h.verticalSpace,
                        AutoSizeTextWidget(
                          text: player.positionLabel.isNotEmpty
                              ? player.positionLabel
                              : 'غائب',
                          fontSize: 10.5.sp,
                          colorText: const Color(0xff6B7173),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Injury icon
                    Image.asset(
                      'assets/icons/infection.png',
                      width: 20.r,
                      height: 20.r,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.medical_services_outlined,
                        size: 18.sp,
                        color: const Color(0xffef4444),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
