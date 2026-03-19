import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/features/leagues_mangement/team_and_player/data/model/team_model.dart';
import 'package:safirah/core/widgets/online_images_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../data/model/match_event_model.dart';
import '../state_managment/riverpod.dart';
import '../../../../../core/state/state.dart';

class MatchDetailsPage extends ConsumerWidget {
  const MatchDetailsPage({
    super.key,
    required this.matchSyncId,
    this.onEdit,
    this.onShare,
  });

  final String matchSyncId;
  final VoidCallback? onEdit;
  final VoidCallback? onShare;

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(getMatchDetailsProvider(matchSyncId));

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            await ref.read(getMatchDetailsProvider(matchSyncId).notifier).load();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                _MatchHeader(
                  league: state.data.leagueName,
                  round: state.data.roundName,
                  homeTeam: state.data.homeTeam,
                  awayTeam: state.data.awayTeam,
                  homeScore: state.data.homeScore,
                  awayScore: state.data.awayScore,
                  status: state.data.statusText,
                  homeGoals: state.data.homeScorers,
                  awayGoals: state.data.awayScorers,
                  onEdit: onEdit ?? () {},
                  onShare: onShare ?? () {},
                  onBack: () => Navigator.of(context).maybePop(),
                ),
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: _MatchEventsCard(
                    homeTeam: state.data.homeTeam,
                    awayTeam: state.data.awayTeam,
                    events: state.data.events,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =========================
// Events UI
// =========================

class _MatchEventsCard extends StatelessWidget {
  const _MatchEventsCard({
    required this.homeTeam,
    required this.awayTeam,
    required this.events,
  });

  final TeamModel homeTeam;
  final TeamModel awayTeam;
  final List<MatchEventModel> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _EventsTimelineList(
            events: events,
            homeTeamName: homeTeam.teamName,
            awayTeamName: awayTeam.teamName,
          ),
        ],
      ),
    );
  }
}

class _EventsTimelineList extends StatelessWidget {
  const _EventsTimelineList({
    required this.events,
    required this.homeTeamName,
    required this.awayTeamName,
  });

  final List<MatchEventModel> events;
  final String homeTeamName;
  final String awayTeamName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < events.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: i == events.length - 1 ? 0 : 10.h),
            child: _EventRow(
              item: events[i],
              homeTeamName: homeTeamName,
              awayTeamName: awayTeamName,
            ),
          ),
      ],
    );
  }
}

class _EventRow extends StatelessWidget {
  const _EventRow({
    required this.item,
    required this.homeTeamName,
    required this.awayTeamName,
  });

  final MatchEventModel item;
  final String homeTeamName;
  final String awayTeamName;

  @override
  Widget build(BuildContext context) {
    if (item.type == MatchEventType.scoreSeparator) {
      return _ScoreSeparatorRow(scoreText: item.scoreText ?? '');
    }

    final eventTeam = item.teamName.trim();
    final isHome = eventTeam.isNotEmpty && eventTeam == homeTeamName;
    final isAway = eventTeam.isNotEmpty && eventTeam == awayTeamName;

    // إذا الاسم ما طابق (مثلاً اختلاف كتابة)، نعرضه بشكل محايد باليمين افتراضياً.
    final showOnRight = isAway || (!isHome && !isAway);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: (!showOnRight)
              ? _EventContent(
                  alignEnd: true,
                  icon: _eventIcon(item.type),
                  iconColor: _eventIconColor(item.type),
                  playerName: item.playerName ?? '',
                  extraText: item.extraText,
                )
              : const SizedBox.shrink(),
        ),
        SizedBox(
          width: 60.w,
          child: _TimelineCenter(minuteText: item.minute),
        ),
        Expanded(
          child: showOnRight
              ? _EventContent(
                  alignEnd: false,
                  icon: _eventIcon(item.type),
                  iconColor: _eventIconColor(item.type),
                  playerName: item.playerName ?? '',
                  extraText: item.extraText,
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  IconData _eventIcon(MatchEventType type) {
    switch (type) {
      case MatchEventType.goal:
        return Icons.sports_soccer;
      case MatchEventType.yellowCard:
        return Icons.crop_square;
      case MatchEventType.redCard:
        return Icons.crop_square;
      case MatchEventType.substitution:
        return Icons.swap_horiz;
      case MatchEventType.scoreSeparator:
        return Icons.remove;
    }
  }

  Color _eventIconColor(MatchEventType type) {
    switch (type) {
      case MatchEventType.goal:
        return Colors.black.withValues(alpha: 0.72);
      case MatchEventType.yellowCard:
        return const Color(0xFFFFD54F);
      case MatchEventType.redCard:
        return const Color(0xFFE53935);
      case MatchEventType.substitution:
        return const Color(0xFF2E7D32);
      case MatchEventType.scoreSeparator:
        return Colors.black;
    }
  }
}

class _EventContent extends StatelessWidget {
  const _EventContent({
    required this.alignEnd,
    required this.icon,
    required this.iconColor,
    required this.playerName,
    this.extraText,
  });

  final bool alignEnd;
  final IconData icon;
  final Color iconColor;
  final String playerName;
  final String? extraText;

  @override
  Widget build(BuildContext context) {
    final textAlign = alignEnd ? TextAlign.right : TextAlign.left;
    final crossAxis = alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: crossAxis,
      children: [
        Row(
          mainAxisAlignment: alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!alignEnd) ...[
              _EventIconChip(icon: icon, color: iconColor),
              6.w.horizontalSpace,
            ],
            Flexible(
              child: AutoSizeTextWidget(
                text: playerName,
                fontSize: 11.5.sp,
                colorText: AppColors.mainColorFont,
                textAlign: textAlign,
                maxLines: 1,
              ),
            ),
            if (alignEnd) ...[
              6.w.horizontalSpace,
              _EventIconChip(icon: icon, color: iconColor),
            ],
          ],
        ),
        if (extraText != null && extraText!.trim().isNotEmpty) ...[
          3.h.verticalSpace,
          AutoSizeTextWidget(
            text: extraText!,
            fontSize: 10.5.sp,
            fontWeight: FontWeight.w400,
            colorText: AppColors.fontColor,
            textAlign: textAlign,
            maxLines: 1,
          ),
        ],
      ],
    );
  }
}

class _EventIconChip extends StatelessWidget {
  const _EventIconChip({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (icon == Icons.crop_square) {
      // بطاقة (مربع ملون)
      return Container(
        width: 14.r,
        height: 14.r,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2.r),
        ),
      );
    }

    return Icon(icon, size: 16.r, color: color);
  }
}

class _TimelineCenter extends StatelessWidget {
  const _TimelineCenter({required this.minuteText});

  final String minuteText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AutoSizeTextWidget(
          text: minuteText,
          fontSize: 10.5.sp,
          fontWeight: FontWeight.w600,
          colorText: AppColors.fontColor2,
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
        6.h.verticalSpace,
        // Container(
        //   width: 8.r,
        //   height: 8.r,
        //   decoration: BoxDecoration(
        //     color: AppColors.secondaryColor.withValues(alpha: 0.15),
        //     shape: BoxShape.circle,
        //     border: Border.all(
        //       color: AppColors.secondaryColor.withValues(alpha: 0.35),
        //       width: 1,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class _ScoreSeparatorRow extends StatelessWidget {
  const _ScoreSeparatorRow({required this.scoreText});

  final String scoreText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.fontColor3.withValues(alpha: 0.4), thickness: 1, height: 1)),
        10.w.horizontalSpace,
        AutoSizeTextWidget(
          text: scoreText,
          fontSize: 10.5.sp,
          fontWeight: FontWeight.w600,
          colorText: AppColors.mainColorFont,
        ),
        10.w.horizontalSpace,
        Expanded(child: Divider(color: AppColors.fontColor3.withValues(alpha: 0.4), thickness: 1, height: 1)),
      ],
    );
  }
}

class _MatchHeader extends StatelessWidget {
  const _MatchHeader({
    required this.league,
    required this.round,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeScore,
    required this.awayScore,
    required this.status,
    required this.homeGoals,
    required this.awayGoals,
    required this.onEdit,
    required this.onShare,
    required this.onBack,
  });

  final String league;
  final String round;

  final TeamModel homeTeam;
  final TeamModel awayTeam;

  final int homeScore;
  final int awayScore;

  final String status;
  final List<String> homeGoals;
  final List<String> awayGoals;

  final VoidCallback onEdit;
  final VoidCallback onShare;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 10.h, bottom: 14.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: Opacity(
                opacity: 0.10,
                child: CustomPaint(
                  painter: _PatternPainter(),
                ),
              ),
            ),
          ),

          Column(
            children: [
              SizedBox(
                height: 34.h,
                child: Row(
                  children: [
                    IconButtonWidget(
                      iconColor: Colors.white,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          AutoSizeTextWidget(
                            text: league,
                            colorText: Colors.white,
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                          2.h.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                child: AutoSizeTextWidget(
                                  text: round,
                                  colorText: Colors.white.withValues(alpha: 0.85),
                                  fontSize: 10.5.sp,
                                  fontWeight: FontWeight.w500,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButtonWidget(
                      iconColor: AppColors.secondaryColor,
                    ),
                  ],
                ),
              ),

              10.h.verticalSpace,

              // ===== Teams + score (بنفس السطر تماماً) =====
              SizedBox(
                height: 40.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _TeamNameOnly(
                        name: homeTeam.teamName,
                        logoUrl: homeTeam.logoUrl,
                        alignEnd: true,
                      ),
                    ),
                    SizedBox(
                      width: 94.w,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoSizeTextWidget(
                              text: '$homeScore',
                              colorText: Colors.white,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            AutoSizeTextWidget(
                              text: ' - ',
                              colorText: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            AutoSizeTextWidget(
                              text: '$awayScore',
                              colorText: Colors.white,
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: _TeamNameOnly(
                        name: awayTeam.teamName,
                        logoUrl: awayTeam.logoUrl,
                        alignEnd: false,
                      ),
                    ),
                  ],
                ),
              ),

              6.h.verticalSpace,

              // ===== status + ball =====
              Row(
                children: [
                  Expanded(
                    child: _ScorersColumn(
                      details: homeGoals,
                      alignEnd: true,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        AutoSizeTextWidget(
                          text: status,
                          colorText: Colors.white.withValues(alpha: 0.75),
                          fontSize: 10.5.sp,
                          fontWeight: FontWeight.w500,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                        ),
                        6.h.verticalSpace,
                        Container(
                          width: 22.r,
                          height: 22.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.6),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            Icons.sports_soccer,
                            size: 12.r,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _ScorersColumn(
                      details: awayGoals,
                      alignEnd: false,
                    ),
                  ),
                ],
              ),

              8.h.verticalSpace,

              // ===== Scorers (هنا يتمدد الهيدر للأسفل فقط) =====

            ],
          ),
        ],
      ),
    );
  }
}

class _TeamNameOnly extends StatelessWidget {
  const _TeamNameOnly({
    required this.name,
    required this.alignEnd,
    this.logoUrl,
  });

  final String name;
  final bool alignEnd;
  final String? logoUrl;

  @override
  Widget build(BuildContext context) {
    final String? normalizedUrl = (logoUrl ?? '').trim().isEmpty ? null : logoUrl!.trim();

    final logo = SizedBox(
      width: 45.w,
      height:  45.h,
      child:
      //normalizedUrl == null
        //  ?
      _TeamLogoFallback(name: name)
          // : OnlineImagesWidget(
          //     imageUrl: normalizedUrl,
          //     circularImage: true,
          //     circularRadius: 9.r,
          //     size: Size(18.w, 18.h),
          //     fit: BoxFit.cover,
          //     backgroundColor: Colors.white.withValues(alpha: 0.18),
          //   ),
    );

    return Align(
      alignment: alignEnd ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!alignEnd) ...[
            logo,
            6.w.horizontalSpace,
          ],
          Flexible(
            child: AutoSizeTextWidget(
              text: name,
              colorText: Colors.white,
              fontSize: 13.5.sp,
              fontWeight: FontWeight.w600,
              textAlign: alignEnd ? TextAlign.right : TextAlign.left,
              maxLines: 1,
            ),
          ),
          if (alignEnd) ...[
            6.w.horizontalSpace,
            logo,
          ],
        ],
      ),
    );
  }
}

class _TeamLogoFallback extends StatelessWidget {
  const _TeamLogoFallback({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final trimmed = name.trim();
    final letter = trimmed.isNotEmpty ? trimmed.characters.first : '?';

    return Container(
      width: 18.w,
      height: 18.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: AutoSizeTextWidget(
       text:  letter.toUpperCase(),  colorText: Colors.white,
        fontSize: 10.sp,
        fontWeight: FontWeight.w700,

      ),
    );
  }
}

class _ScorersColumn extends StatelessWidget {
  const _ScorersColumn({
    required this.details,
    required this.alignEnd,
  });

  final List<String> details;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        for (final line in details)
          Padding(
            padding: EdgeInsets.only(bottom: 2.h),
            child: AutoSizeTextWidget(
              text: line,
              colorText: Colors.white.withValues(alpha: 0.75),
              fontSize: 10.5.sp,
              fontWeight: FontWeight.w400,
              textAlign: alignEnd ? TextAlign.right : TextAlign.left,
              maxLines: 1,
            ),
          ),
      ],
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
  });

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Padding(
        padding: EdgeInsets.all(6.r),
        child: SvgPicture.asset(
          icon,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
    );
  }
}

class _PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // دوائر صغيرة متكررة
    const double step = 18;
    const double radius = 4;

    for (double y = 0; y < size.height + step; y += step) {
      for (double x = 0; x < size.width + step; x += step) {
        final dx = x + (((y / step).floor().isEven) ? 0 : step / 2);
        canvas.drawCircle(Offset(dx, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
