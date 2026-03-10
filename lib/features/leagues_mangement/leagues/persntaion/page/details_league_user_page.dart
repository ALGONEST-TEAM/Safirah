import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/constants/app_icons.dart';
import 'package:safirah/core/state/check_state_in_post_api_data_widget.dart';
import 'package:safirah/core/state/state.dart';
import 'package:safirah/core/theme/app_colors.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';
import 'package:safirah/core/widgets/secondary_app_bar_widget.dart';
import 'package:safirah/features/leagues_mangement/leagues/data/model/league_model.dart';
import 'package:flutter/scheduler.dart';
import '../../../../../core/state/data_state.dart';

import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../home/presntation/widgets/banners_widget.dart';
import '../riverpod/riverpod.dart';
import 'details_league_widget.dart';

class DetailsLeagueUserPage extends ConsumerWidget {
  const DetailsLeagueUserPage({super.key, required this.leagueSyncId});
  final String leagueSyncId;

  @override
  Widget build(BuildContext context, ref) {
    final addOrderLeagueInvitationsPlayerState =
        ref.watch(orderLeagueInvitationsPlayerProvider(leagueSyncId));
    final detailsLeague = ref.watch(leagueStreamProvider(leagueSyncId));
    final bannersState = ref.watch(getLeagueBannersProvider(leagueSyncId));
    final leagueRulesAsync = ref.watch(leagueRulesStreamProvider(leagueSyncId));
    final leagueRulesRefresh = ref.watch(leagueRulesRefreshProvider(leagueSyncId));

    // trigger refresh once (post frame) - similar to other pages
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (leagueRulesRefresh.status == RefreshStatus.idle) {
        ref.read(leagueRulesRefreshProvider(leagueSyncId).notifier).refresh();
      }
    });

    return Scaffold(
      appBar: const SecondaryAppBarWidget(
        title: 'تفاصيل الدوري',
      ),
      body: SafeArea(
        child: CheckStateInStreamWidget<LeagueModel?>(
          async: detailsLeague,
          isEmpty: (data) {
            // يعتبر فارغاً إذا رجع الستريم null.
            return data == null;
          },
          dataBuilder: (data) {
            if (data == null) {
              return Padding(
                padding: EdgeInsets.all(16.w),
                child: Center(
                  child: AutoSizeTextWidget(
                    text: 'لا توجد بيانات لهذا الدوري حالياً',
                    fontSize: 12.sp,
                    colorText: AppColors.fontColor,
                  ),
                ),
              );
            }

            final maxMainPlayers = data.maxMainPlayers ?? 0;
            final maxSubPlayers = data.maxSubPlayers ?? 0;
            final maxTeams = data.maxTeams ?? 0;
            final totalPlayers = (maxMainPlayers + maxSubPlayers) * maxTeams;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: BannersWidget(banners: bannersState.data),
                    ),
                    Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeTextWidget(text: 'تفاصيل الدوري'),
                            6.h.verticalSpace,
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeTextWidget(
                                    text: data.name ?? '',
                                    fontSize: 13.sp,
                                  ),
                                  6.h.verticalSpace,
                                  AutoSizeTextWidget(
                                    text:
                                        '${data.subscriptionPrice ?? ''} / اللعب ',
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.h),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xffEDF0FF),
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0.w),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const AutoSizeTextWidget(text: 'قواعد الدوري'),
                                                const Spacer(),
                                                if (leagueRulesRefresh.status == RefreshStatus.loading)
                                                  SizedBox(
                                                    height: 14.r,
                                                    width: 14.r,
                                                    child: const CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: AppColors.primaryColor,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                            6.h.verticalSpace,
                                            CheckStateInStreamWidget(
                                              async: leagueRulesAsync,
                                              isEmpty: (rules) => rules.isEmpty,
                                              emptyBuilder: () => AutoSizeTextWidget(
                                                fontSize: 10.sp,
                                                text: 'لا توجد قواعد لهذا الدوري بعد.',
                                              ),
                                              dataBuilder: (rules) {
                                                // تصنيف ديناميكي بدون رقم ثابت
                                                final anyMandatory = rules.any((e) => e.isMandatory);
                                                final defaultRulesText = RulesNotifier.defaultRulesText;

                                                final defaultRules = anyMandatory
                                                    ? rules.where((e) => e.isMandatory).toList()
                                                    : rules
                                                        .where((e) => defaultRulesText.contains(e.description))
                                                        .toList();

                                                final customRules = anyMandatory
                                                    ? rules.where((e) => !e.isMandatory).toList()
                                                    : rules
                                                        .where((e) => !defaultRulesText.contains(e.description))
                                                        .toList();

                                                int i = 0;
                                                final all = <String>[
                                                  ...defaultRules.map((e) => e.description),
                                                  ...customRules.map((e) => e.description),
                                                ];

                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    if (defaultRules.isNotEmpty) ...[
                                                      AutoSizeTextWidget(
                                                        fontSize: 10.sp,
                                                        text: 'الأساسية:',
                                                      ),
                                                      4.h.verticalSpace,
                                                      ...defaultRules.map((r) {
                                                        i++;
                                                        return AutoSizeTextWidget(
                                                          fontSize: 10.sp,
                                                          text: '$i- ${r.description}',
                                                          maxLines: 4,
                                                        );
                                                      }),
                                                      6.h.verticalSpace,
                                                    ],
                                                    if (customRules.isNotEmpty) ...[
                                                      AutoSizeTextWidget(
                                                        fontSize: 10.sp,
                                                        text: 'المخصصة:',
                                                      ),
                                                      4.h.verticalSpace,
                                                      ...customRules.map((r) {
                                                        i++;
                                                        return AutoSizeTextWidget(
                                                          fontSize: 10.sp,
                                                          text: '$i- ${r.description}',
                                                          maxLines: 4,
                                                        );
                                                      }),
                                                    ],
                                                    if (all.isEmpty)
                                                      AutoSizeTextWidget(
                                                        fontSize: 10.sp,
                                                        text: 'لا توجد قواعد لهذا الدوري بعد.',
                                                      ),
                                                  ],
                                                );
                                              },
                                              onRefresh: () async {
                                                await ref
                                                    .read(leagueRulesRefreshProvider(leagueSyncId).notifier)
                                                    .refresh();
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        10.h.verticalSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeTextWidget(text: 'تفاصيل اللعبين'),
                            6.h.verticalSpace,
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeTextWidget(text: 'منظم الدوري'),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffEDF0FF),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.0.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 20.r,
                                                ),
                                                6.w.horizontalSpace,
                                                AutoSizeTextWidget(
                                                    text:data.nameOrganizer ?? '',),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppIcons.editPlayer,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.primaryColor,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      4.w.horizontalSpace,
                                      AutoSizeTextWidget(text: 'نوع الدوري :'),
                                      4.w.horizontalSpace,
                                      AutoSizeTextWidget(
                                        text: 'مجموعات',
                                        fontSize: 11.sp,
                                        colorText: AppColors.fontColor,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppIcons.players,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.primaryColor,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      4.w.horizontalSpace,
                                      AutoSizeTextWidget(text: 'عدد اللعابين :'),
                                      4.w.horizontalSpace,
                                      AutoSizeTextWidget(
                                        text:"${ totalPlayers.toString()} لاعب",
                                        fontSize: 11.sp,
                                        colorText: AppColors.fontColor,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        AppIcons.editPlayer,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.primaryColor,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      4.w.horizontalSpace,
                                      AutoSizeTextWidget(text: 'عدد الفرق :'),
                                      4.w.horizontalSpace,
                                      AutoSizeTextWidget(
                                        text: ' $maxTeams فريق',
                                        fontSize: 11.sp,
                                        colorText: AppColors.fontColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        10.h.verticalSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeTextWidget(text: 'الانضمام الى الدوري'),
                            6.h.verticalSpace,
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DefaultButtonWidget(
                                    text: 'نسخ رابط الدوري',
                                    icon: AppIcons.copy,
                                    withIcon: true,
                                    iconColor: AppColors.secondaryColor,
                                    textColor: AppColors.secondaryColor,
                                    background: const Color(0xffEDF0FF),
                                    onPressed: () async {
                                      // WhatsApp and many apps don't always make custom schemes clickable.
                                      // So we share an HTTPS link and let Android App Links / iOS Universal Links open the app.
                                      final uri = Uri(
                                        scheme: 'https',
                                        host: 'saferah.dev-station.com',
                                        pathSegments: ['league', leagueSyncId],
                                      );

                                      await Clipboard.setData(
                                        ClipboardData(text: uri.toString()),
                                      );

                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text('تم نسخ رابط الدوري'),
                                          ),
                                        );
                                      }

                                      // Optional share.

                                    },
                                  ),
                                  6.h.verticalSpace,
                                  CheckStateInPostApiDataWidget(
                                    state: addOrderLeagueInvitationsPlayerState,
                                    bottonWidget: DefaultButtonWidget(
                                      text: 'ارسال طلب الانضمام',
                                      isLoading:
                                          addOrderLeagueInvitationsPlayerState
                                                  .stateData ==
                                              States.loading,
                                      icon: AppIcons.sharing,
                                      withIcon: true,
                                      iconColor: AppColors.secondaryColor,
                                      textColor: AppColors.secondaryColor,
                                      background: const Color(0xffEDF0FF),
                                      onPressed: () {
                                        // ignore: avoid_print
                                        print(leagueSyncId);
                                        ref
                                            .read(
                                              orderLeagueInvitationsPlayerProvider(
                                                leagueSyncId,
                                              ).notifier,
                                            )
                                            .add();
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DefaultButtonWidget(
                                text: 'الانتقال الى الدوري',
                                isLoading:
                                addOrderLeagueInvitationsPlayerState
                                    .stateData ==
                                    States.loading,
                                icon: AppIcons.league,
                                withIcon: true,
                                iconColor: Colors.white,
                                background: AppColors.primaryColor,
                                onPressed: () {
                              navigateTo(context, DetailsLeagueWidget(leagueSyncId: leagueSyncId,));
                                },
                              ),
                            ),

                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
