import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/logo_shimmer_widget.dart';
import '../../data/model/standings_model.dart';
import '../riverpod/prediction_riverpod.dart';
import 'standings_list_card_widget.dart';
import 'standings_rank_widget.dart';
import 'standings_scope_card_widget.dart';
import 'standings_user_row_widget.dart';

class StandingsWidget extends ConsumerWidget {
  const StandingsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scope = ref.watch(standingsScopeProvider);
    final state = ref.watch(standingsProvider(scope));
    return CheckStateInGetApiDataWidget(
      state: state,
      refresh: () {
        ref.invalidate(standingsProvider(scope));
      },
      widgetOfLoading: const LogoShimmerWidget(),
      widgetOfData: RefreshIndicator(
        backgroundColor: Colors.white,
        color: AppColors.primaryColor,
        onRefresh: () async {
          ref.invalidate(standingsProvider(scope));
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(12.sp).copyWith(bottom: 90.h),
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
                          _infoRow(AppIcons.players, 'عدد الاعبين المشاركين: ',
                              state.data.participantsCount.toString()),
                          _infoRow(AppIcons.dateEdit, 'الموسم السنوي: ',
                              state.data.season),
                        ],
                      ),
                    ),
                  ),
                  StandingsScopeCardWidget(scope: scope),
                  StandingsListCardWidget(items: state.data.items),
                ],
              ),
            ),
            if (state.data.userItem != null)
              Positioned(
                left: 12.w,
                right: 12.w,
                bottom: 38.h,
                child: StandingsUserRowWidget(
                  item: state.data.userItem,
                ),
                // child: Material(
                //   borderRadius: BorderRadius.circular(12.r),
                //   elevation: 6,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(12.r),
                //       border: Border.all(
                //         color: AppColors.greySwatch.shade100,
                //         width: 0.6,
                //       ),
                //     ),
                //     child: StandingsUserRowWidget(
                //       item: state.data.userItem,
                //     ),
                //   ),
                // ),
              ),
          ],
        ),
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


