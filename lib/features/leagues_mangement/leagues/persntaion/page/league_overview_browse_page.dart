import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../team_and_player/presntation/state_mangment/riverpod.dart';
import '../helpers/league_share_helper.dart';
import '../riverpod/riverpod.dart';

class LeagueOverviewBrowsePage extends ConsumerStatefulWidget {
  const LeagueOverviewBrowsePage({
    super.key,
    required this.leagueSyncId,
  });

  final String leagueSyncId;

  @override
  ConsumerState<LeagueOverviewBrowsePage> createState() =>
      _LeagueOverviewBrowsePageState();
}

class _LeagueOverviewBrowsePageState
    extends ConsumerState<LeagueOverviewBrowsePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(leagueBundleRefreshProvider(widget.leagueSyncId).notifier).refresh();
      ref.read(teamsRefreshProvider(widget.leagueSyncId).notifier).refresh();
      ref.read(playerLeagueRefreshProvider(widget.leagueSyncId).notifier).refresh();
    });
  }

  Future<void> _copyLeagueLink(BuildContext context) async {
    final leagueLink = buildLeagueDeepLink(widget.leagueSyncId);
    if (leagueLink.trim().isEmpty) {
      showFlashBarError(
        context: context,
        title: 'تعذر نسخ الرابط',
        text: 'رابط الدوري غير متوفر حالياً.',
      );
      return;
    }

    await Clipboard.setData(ClipboardData(text: leagueLink));
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم نسخ رابط الدوري'),
      ),
    );
  }

  Future<void> _shareLeagueLink(BuildContext context) async {
    final leagueLink = buildLeagueDeepLink(widget.leagueSyncId);
    if (leagueLink.trim().isEmpty) {
      showFlashBarError(
        context: context,
        title: 'تعذر مشاركة الرابط',
        text: 'رابط الدوري غير متوفر حالياً.',
      );
      return;
    }

    try {
      await SharePlus.instance.share(
        ShareParams(text: leagueLink),
      );
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('حدث خطأ أثناء محاولة مشاركة رابط الدوري'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final leagueAsync = ref.watch(leagueStreamProvider(widget.leagueSyncId));
    final teamsAsync = ref.watch(teamsStreamProvider(widget.leagueSyncId));
    final playersAsync = ref.watch(leaguePlayerStreamProvider(widget.leagueSyncId));

    return Scaffold(
      appBar: const SecondaryAppBarWidget(title: 'استعراض بيانات الدوري'),
      body: SafeArea(
        child: CheckStateInStreamWidget(
          async: leagueAsync,
          isEmpty: (league) => league == null,
          emptyBuilder: () => Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: AutoSizeTextWidget(
                text: 'لا توجد بيانات متاحة لهذا الدوري حالياً',
                fontSize: 12.sp,
              ),
            ),
          ),
          dataBuilder: (league) {
            final teamCount = teamsAsync.asData?.value.length ?? 0;
            final playerCount = playersAsync.asData?.value.length ?? 0;
            final configuredTeams = league?.maxTeams ?? 0;
            final configuredPlayersPerTeam =
                (league?.maxMainPlayers ?? 0) + (league?.maxSubPlayers ?? 0);

            return SingleChildScrollView(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionCard(
                    title: 'نبذة عن الدوري',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeTextWidget(
                          text: league?.name ?? '',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          colorText: AppColors.secondaryColor,
                        ),
                        8.h.verticalSpace,
                        _InfoRow(
                          label: 'المنظم',
                          value: (league?.nameOrganizer ?? '').trim().isEmpty
                              ? 'غير محدد'
                              : league!.nameOrganizer!,
                        ),
                        _InfoRow(
                          label: 'نوع الدوري',
                          value: (league?.type ?? '').trim().isEmpty
                              ? 'غير محدد'
                              : league!.type!,
                        ),
                        _InfoRow(
                          label: 'رسوم الاشتراك',
                          value: (league?.subscriptionPrice ?? '').trim().isEmpty
                              ? 'غير محدد'
                              : '${league!.subscriptionPrice} / اللاعب',
                        ),
                      ],
                    ),
                  ),
                  12.h.verticalSpace,
                  _SectionCard(
                    title: 'إحصائيات الدوري',
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _StatTile(
                                title: 'عدد الفرق',
                                value: teamCount.toString(),
                                subtitle: configuredTeams > 0
                                    ? 'من أصل $configuredTeams'
                                    : null,
                              ),
                            ),
                            10.w.horizontalSpace,
                            Expanded(
                              child: _StatTile(
                                title: 'عدد اللاعبين',
                                value: playerCount.toString(),
                                subtitle: configuredPlayersPerTeam > 0
                                    ? 'سعة الفريق $configuredPlayersPerTeam'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  12.h.verticalSpace,
                  _SectionCard(
                    title: 'رابط الدوري',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeTextWidget(
                          text: 'يمكنك نسخ أو مشاركة رابط الدوري مباشرة.',
                          fontSize: 10.5.sp,
                          colorText: AppColors.fontColor2,
                        ),
                        10.h.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: DefaultButtonWidget(
                                text: 'نسخ رابط الدوري',
                                onPressed: () => _copyLeagueLink(context),
                                background: const Color(0xffEDF0FF),
                                textColor: AppColors.secondaryColor,
                                withIcon: true,
                                icon: AppIcons.copy,
                                iconColor: AppColors.secondaryColor,
                              ),
                            ),
                            8.w.horizontalSpace,
                            Expanded(
                              child: DefaultButtonWidget(
                                text: 'مشاركة الرابط',
                                onPressed: () => _shareLeagueLink(context),
                                background: AppColors.secondaryColor,
                                textColor: Colors.white,
                                withIcon: true,
                                icon: AppIcons.sharing,
                                iconColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeTextWidget(
            text: title,
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w700,
          ),
          10.h.verticalSpace,
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        children: [
          AutoSizeTextWidget(
            text: '$label :',
            fontSize: 11.sp,
            colorText: AppColors.fontColor,
          ),
          6.w.horizontalSpace,
          Expanded(
            child: AutoSizeTextWidget(
              text: value,
              fontSize: 11.sp,
              colorText: AppColors.fontColor2,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.title,
    required this.value,
    this.subtitle,
  });

  final String title;
  final String value;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xffEDF0FF),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          AutoSizeTextWidget(
            text: title,
            fontSize: 10.5.sp,
            colorText: AppColors.fontColor,
          ),
          6.h.verticalSpace,
          AutoSizeTextWidget(
            text: value,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            colorText: AppColors.secondaryColor,
          ),
          if ((subtitle ?? '').trim().isNotEmpty) ...[
            4.h.verticalSpace,
            AutoSizeTextWidget(
              text: subtitle!,
              fontSize: 9.5.sp,
              colorText: AppColors.fontColor2,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}


