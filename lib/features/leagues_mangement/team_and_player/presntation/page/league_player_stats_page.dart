import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/team_model.dart';
import '../state_mangment/riverpod.dart';

/// Widget مدمج لعرض الإحصائيات داخل صفحات أخرى (مثل DetailsLeagueWidget)
/// بدون Scaffold أو AppBar.
class LeaguePlayerStatsPage extends ConsumerStatefulWidget {
  final String leagueSyncId;

  const LeaguePlayerStatsPage({super.key, required this.leagueSyncId});

  @override
  ConsumerState<LeaguePlayerStatsPage> createState() => _LeaguePlayerStatsPageState();
}

class _LeaguePlayerStatsPageState extends ConsumerState<LeaguePlayerStatsPage> {
  late final PageController _controller;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    setState(() => _selectedIndex = index);
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getLeaguePlayersStatisticsProvider(widget.leagueSyncId));
    return CheckStateInGetApiDataWidget(
      state: state,

      widgetOfData: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
         //   _HeaderSummary(stats: state.data),
            SizedBox(height: 12.h),
            _StatsChipsBar(
              selectedIndex: _selectedIndex,
              onSelected: _goTo,
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _selectedIndex = i),
                children: [
                  _StatsListView(
                    title: 'الهدافين',
                    items: state.data.topScorer,
                    leadingIcon: Icons.sports_soccer,
                  ),
                  _StatsListView(
                    title: 'صناعة الأهداف',
                    items:  state.data.topAssist,
                    leadingIcon: Icons.handshake_outlined,
                  ),
                  _StatsListView(
                    title: 'المساهمين',
                    items:  state.data.topContributor,
                    leadingIcon: Icons.star_border,
                  ),
                  _StatsListView(
                    title: 'البطاقات الصفراء',
                    items: state.data.topYellowCards,
                    leadingIcon: Icons.square,
                    accentColor: const Color(0xFFF4C430),
                  ),
                  _StatsListView(
                    title: 'البطاقات الحمراء',
                    items:  state.data.topRedCards,
                    leadingIcon: Icons.square,
                    accentColor: const Color(0xFFE53935),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderSummary extends StatelessWidget {
  final LeaguePlayerStatsModel stats;
  const _HeaderSummary({required this.stats});

  @override
  Widget build(BuildContext context) {
    final total = stats.topScorer.length +
        stats.topAssist.length +
        stats.topContributor.length +
        stats.topYellowCards.length +
        stats.topRedCards.length;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 42.r,
            width: 42.r,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.leaderboard_outlined,
              color: AppColors.primaryColor,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeTextWidget(
                  text: 'إحصائيات اللاعبين',
                  fontSize: 13.sp,
                  colorText: AppColors.secondaryColor,
                ),
                SizedBox(height: 4.h),
                AutoSizeTextWidget(
                  text: total == 0
                      ? 'لا توجد بيانات حتى الآن'
                      : 'عدد العناصر المعروضة: $total',
                  fontSize: 11.5.sp,
                  colorText: Colors.black54,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsChipsBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _StatsChipsBar({required this.selectedIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('هدافين', Icons.sports_soccer),
      ('أسيست', Icons.handshake_outlined),
      ('مساهمة', Icons.star_border),
      ('صفراء', Icons.square),
      ('حمراء', Icons.square),
    ];

    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(width: 10.w),
        itemBuilder: (context, index) {
          final (label, icon) = items[index];
          final isSelected = selectedIndex == index;
          final Color bg = isSelected ? AppColors.primaryColor : Colors.white;
          final Color fg = isSelected ? Colors.white : AppColors.secondaryColor;

          // تلوين خاص للصفراء/الحمراء عند التحديد
          Color? special;
          if (index == 3) special = const Color(0xFFF4C430);
          if (index == 4) special = const Color(0xFFE53935);

          final effectiveBg = isSelected && special != null ? special : bg;

          return InkWell(
            borderRadius: BorderRadius.circular(12.r),
            onTap: () => onSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: effectiveBg,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : Colors.black12.withValues(alpha: .08),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: effectiveBg.withValues(alpha: .25),
                          blurRadius: 14,
                          offset: const Offset(0, 6),
                        )
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 16.sp, color: fg),
                  SizedBox(width: 6.w),
                  AutoSizeTextWidget(
                    text: label,
                    fontSize: 11.5.sp,
                    colorText: fg,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _StatsListView extends StatelessWidget {
  final String title;
  final List<PlayerStatItemModel> items;
  final IconData leadingIcon;
  final Color? accentColor;

  const _StatsListView({
    required this.title,
    required this.items,
    required this.leadingIcon,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return _EmptyState(title: title);
    }

    return ListView.separated(
      padding: EdgeInsets.only(bottom: 12.h),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        final item = items[index];
        return _PlayerStatCard(
          rank: index + 1,
          item: item,
          leadingIcon: leadingIcon,
          accentColor: accentColor,
        );
      },
    );
  }
}

class _PlayerStatCard extends StatelessWidget {
  final int rank;
  final PlayerStatItemModel item;
  final IconData leadingIcon;
  final Color? accentColor;

  const _PlayerStatCard({
    required this.rank,
    required this.item,
    required this.leadingIcon,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = accentColor ?? AppColors.primaryColor;
    final playerName = item.player.fullName ?? '-';

    final String? teamName = (item.player.teamName == null || item.player.teamName!.trim().isEmpty)
        ? null
        : item.player.teamName!.trim();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.black12.withValues(alpha: .06)),
      ),
      child: Row(
        children: [
          Container(
            width: 34.r,
            height: 34.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.withValues(alpha: .12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: AutoSizeTextWidget(
              text: '$rank',
              fontSize: 12.sp,
              colorText: color,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(leadingIcon, size: 16.sp, color: color),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: AutoSizeTextWidget(
                        text: playerName,
                        fontSize: 12.5.sp,
                        colorText: AppColors.secondaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                if (teamName != null)
                  AutoSizeTextWidget(
                    text: teamName,
                    fontSize: 10.5.sp,
                    colorText: Colors.black54,
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: AutoSizeTextWidget(
              text: item.count.toString(),
              fontSize: 12.sp,
              colorText: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  const _EmptyState({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 84.r,
              width: 84.r,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: .10),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Icon(
                Icons.inbox_outlined,
                size: 34.sp,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 12.h),
            AutoSizeTextWidget(
              text: 'لا توجد بيانات',
              fontSize: 13.sp,
              colorText: AppColors.secondaryColor,
            ),
            SizedBox(height: 6.h),
            AutoSizeTextWidget(
              text: 'قائمة "$title" فارغة حالياً.',
              fontSize: 11.5.sp,
              colorText: Colors.black54,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
