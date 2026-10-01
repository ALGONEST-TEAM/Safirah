import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/design_please_login_widget.dart';
import '../../../../core/widgets/logo_shimmer_widget.dart';
import '../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../services/auth/auth.dart';
import '../riverpod/prediction_riverpod.dart';
import 'standings_list_card_widget.dart';
import 'standings_month_filter_widget.dart';
import 'standings_scope_card_widget.dart';
import 'standings_user_row_widget.dart';

class StandingsWidget extends ConsumerStatefulWidget {
  const StandingsWidget({
    super.key,
  });

  @override
  ConsumerState<StandingsWidget> createState() => _StandingsWidgetState();
}

class _StandingsWidgetState extends ConsumerState<StandingsWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(standingsScopeProvider.notifier).state = 'month';
      ref.read(standingsDirectionProvider.notifier).state = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scope = ref.watch(standingsScopeProvider);
    final direction = ref.watch(standingsDirectionProvider);
    final filter = StandingsFilter(scope: scope, direction: direction);
    final state = ref.watch(standingsProvider(filter));

    final isMonthly = scope == 'month' ||
        scope == 'شهري' ||
        scope.toLowerCase().contains('month') ||
        state.data.scope == 'month' ||
        state.data.scope == 'شهري' ||
        state.data.periods.contains('شهر');

    return !Auth().loggedIn
        ? const DesignPleaseLoginWidget()
        : CheckStateInGetApiDataWidget(
            state: state,
            refresh: () {
              ref.invalidate(standingsProvider(filter));
            },
            widgetOfLoading: const LogoShimmerWidget(),
            widgetOfData: RefreshIndicator(
              backgroundColor: Colors.white,
              color: AppColors.primaryColor,
              onRefresh: () async {
                ref.invalidate(standingsProvider(filter));
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
                                _infoRow(
                                    AppIcons.players,
                                    'عدد الاعبين المشاركين: ',
                                    state.data.participantsCount.toString()),
                                _infoRow(AppIcons.dateEdit, 'الموسم السنوي: ',
                                    state.data.season),
                              ],
                            ),
                          ),
                        ),
                        if (isMonthly)
                          Row(
                            children: [
                              Expanded(
                                child: StandingsScopeCardWidget(
                                  scopes: state.data.rankingPeriods,
                                  periods: state.data.periods,
                                ),
                              ),
                              8.w.horizontalSpace,
                              InkWell(
                                borderRadius: BorderRadius.circular(8.r),
                                onTap: () {
                                  scrollShowModalBottomSheetWidget(
                                    context: context,
                                    title: 'الفلترة حسب الشهر',
                                    page: const StandingsMonthFilterWidget(),
                                  );
                                },
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  elevation: 0,
                                  margin: EdgeInsets.zero,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 12.h),
                                    child: SvgPicture.asset(
                                      AppIcons.filter,
                                      colorFilter: ColorFilter.mode(
                                        direction != null
                                            ? AppColors.primaryColor
                                            : AppColors.secondaryColor,
                                        BlendMode.srcIn,
                                      ),
                                      height: 18.h,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        else
                          StandingsScopeCardWidget(
                            scopes: state.data.rankingPeriods,
                            periods: state.data.periods,
                          ),
                        StandingsListCardWidget(items: state.data.items),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 12.w,
                    right: 12.w,
                    bottom: 38.h,
                    child: StandingsUserRowWidget(
                      item: state.data.userItem,
                    ),
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
