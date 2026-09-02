import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../data/model/match_lineups_model.dart';
import '../../provider/match_details_providers.dart';
import 'match_lineups_player_on_pitch_widget.dart';
import 'match_lineups_player_position_widget.dart';

class MatchLineupsTacticalPitchWidget extends ConsumerWidget {
  final List<MatchLineupPlayerModel> startingXI;
  final bool showHomeTeam;
  final String formation;
  final String teamName;
  final int? matchId;

  const MatchLineupsTacticalPitchWidget({
    super.key,
    required this.startingXI,
    required this.showHomeTeam,
    required this.formation,
    required this.teamName,
    this.matchId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tacticalState = matchId != null
        ? ref.watch(matchTacticalPitchProvider(matchId!))
        : null;

    final currentFormation =
        tacticalState != null ? tacticalState.formation : formation;
    final positionedPlayers =
        tacticalState != null ? tacticalState.positionedPlayers : const <TacticalPitchPlayerItem>[];

    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: AspectRatio(
        aspectRatio: 0.90,
        child: Container(
          color: Colors.white,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double w = constraints.maxWidth;
              final double h = constraints.maxHeight;
              final double slotW = (w * 0.15).clamp(40.0, 60.0);
              final bool isRtl = Directionality.of(context) == TextDirection.rtl;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // A. Pitch background
                  Positioned.fill(
                    child: CustomPaint(
                      size: Size(w, h),
                      painter: _PitchPainter(),
                    ),
                  ),

                  // B. Players placed by precalculated provider fractions
                    for (int i = 0; i < positionedPlayers.length; i++)
                      MatchLineupsPlayerPositionWidget(
                        item: positionedPlayers[i],
                        w: w,
                        h: h,
                        slotW: slotW,
                        isRtl: isRtl,
                        showHomeTeam: showHomeTeam,
                        index: i,
                      ),

                  // C. Bottom badge (Formation badge)
                  Positioned(
                    right: 12.w,
                    bottom: 8.h,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 380),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.88, end: 1.0)
                              .animate(animation),
                          child: child,
                        ),
                      ),
                      child: _FormationBadgeWidget(
                        key: ValueKey(currentFormation),
                        formation: currentFormation,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FormationBadgeWidget extends StatelessWidget {
  final String formation;
  const _FormationBadgeWidget({
    super.key,
    required this.formation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xff1b5e20).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: AutoSizeTextWidget(
        text: formation.isNotEmpty ? formation : '4-4-2',
        fontSize: 13.sp,
        fontWeight: FontWeight.w800,
        colorText: Colors.white,
      ),
    );
  }
}

class _PitchPainter extends CustomPainter {
  _PitchPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    const yTopLine = 0.115;
    const yBotLine = 0.891;

    final pitchTopY = h * 0.078;
    final goalLineY = h * 1.0;

    final pitchSurfacePath = Path()
      ..moveTo(w * 0.082, pitchTopY)
      ..lineTo(w * 0.916, pitchTopY)
      ..lineTo(w * 1.343, goalLineY)
      ..lineTo(w * -0.346, goalLineY)
      ..close();

    const baseGreen = Color(0xff31813F);
    canvas.drawPath(pitchSurfacePath, Paint()..color = baseGreen);

    canvas.save();
    canvas.clipPath(pitchSurfacePath);
    const darkGreen = Color(0xff2A7036);
    const int numStripes = 11;
    final stripeH = (goalLineY - pitchTopY) / numStripes;
    for (int i = 0; i < numStripes; i++) {
      if (i.isEven) {
        final top = pitchTopY + i * stripeH;
        final bot = top + stripeH;
        canvas.drawRect(
          Rect.fromLTRB(w * -0.5, top, w * 1.5, bot),
          Paint()..color = darkGreen,
        );
      }
    }
    canvas.restore();

    final lp = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    const yTopGoal = 0.140;
    const yTopPen = 0.203;
    const yCenter = 0.382;
    const yBotPen = 0.644;
    const yBotGoal = 0.803;

    double leftX(double fH) {
      final f = (fH - yTopLine) / (yBotLine - yTopLine);
      return w * (0.148 + f * (-0.080 - 0.148));
    }

    double rightX(double fH) {
      final f = (fH - yTopLine) / (yBotLine - yTopLine);
      return w * (0.852 + f * (1.080 - 0.852));
    }

    double wAt(double fH) => rightX(fH) - leftX(fH);

    void drawHLine(double fH) {
      canvas.drawLine(Offset(leftX(fH), h * fH), Offset(rightX(fH), h * fH), lp);
    }

    void drawBox(double topH, double botH, double insetFrac) {
      final tl = Offset(leftX(topH) + wAt(topH) * insetFrac, h * topH);
      final tr = Offset(rightX(topH) - wAt(topH) * insetFrac, h * topH);
      final bl = Offset(leftX(botH) + wAt(botH) * insetFrac, h * botH);
      final br = Offset(rightX(botH) - wAt(botH) * insetFrac, h * botH);
      final path = Path()
        ..moveTo(tl.dx, tl.dy)
        ..lineTo(tr.dx, tr.dy)
        ..lineTo(br.dx, br.dy)
        ..lineTo(bl.dx, bl.dy)
        ..close();
      canvas.drawPath(path, lp);
    }

    drawHLine(yTopLine);
    drawHLine(yBotLine);
    drawHLine(yCenter);

    canvas.drawLine(Offset(leftX(yTopLine), h * yTopLine), Offset(leftX(yBotLine), h * yBotLine), lp);
    canvas.drawLine(Offset(rightX(yTopLine), h * yTopLine), Offset(rightX(yBotLine), h * yBotLine), lp);

    drawBox(yTopLine, yTopPen, 0.175);
    drawBox(yTopLine, yTopGoal, 0.36);

    drawBox(yBotPen, yBotLine, 0.175);
    drawBox(yBotGoal, yBotLine, 0.36);

    const yCircTop = 0.311;
    const yCircBot = 0.468;
    canvas.drawOval(Rect.fromLTRB(w * 0.36, h * yCircTop, w * 0.64, h * yCircBot), lp);
    canvas.drawCircle(Offset(w / 2, h * yCenter), 2.5, Paint()..color = Colors.white.withValues(alpha: 0.6));

    canvas.save();
    canvas.clipRect(Rect.fromLTRB(0, h * yTopPen, w, h));
    canvas.drawOval(Rect.fromLTRB(w * 0.40, h * (yTopPen - 0.021), w * 0.60, h * 0.224), lp);
    canvas.restore();

    canvas.save();
    canvas.clipRect(Rect.fromLTRB(0, 0, w, h * yBotPen));
    canvas.drawOval(Rect.fromLTRB(w * 0.40, h * 0.601, w * 0.60, h * (yBotPen + 0.043)), lp);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
