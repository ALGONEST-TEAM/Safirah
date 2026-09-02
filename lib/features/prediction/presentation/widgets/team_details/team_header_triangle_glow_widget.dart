import 'package:flutter/material.dart';

class TeamHeaderTriangleGlowWidget extends StatelessWidget {
  final Color glowColor;
  final double expandRatio;

  const TeamHeaderTriangleGlowWidget({
    super.key,
    required this.glowColor,
    this.expandRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _TeamHeaderTriangleGlowPainter(
            glowColor: glowColor,
            expandRatio: expandRatio,
          ),
        ),
      ),
    );
  }
}

class _TeamHeaderTriangleGlowPainter extends CustomPainter {
  final Color glowColor;
  final double expandRatio;

  _TeamHeaderTriangleGlowPainter({
    required this.glowColor,
    required this.expandRatio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (glowColor == Colors.transparent || glowColor.alpha == 0) return;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final double centerX = size.width / 2;

    // Luminous soft tint for the top bright edge
    final Color coreColor = Color.lerp(glowColor, Colors.white, 0.45) ?? glowColor;

    // ══════════════════════════════════════════════════════════════════════
    // LAYER 1: Wide Top-Edge Ambient Light (Zero black halo, pure alpha fade)
    // ══════════════════════════════════════════════════════════════════════
    final topAmbientPaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.0, -1.25),
        radius: 1.1,
        colors: [
          coreColor.withValues(alpha: 0.32),
          glowColor.withValues(alpha: 0.14),
          glowColor.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.50, 1.0],
      ).createShader(rect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 22);

    canvas.drawRect(rect, topAmbientPaint);

    // ══════════════════════════════════════════════════════════════════════
    // LAYER 2: Main Inverted Triangle Glow (Soft, wide top -> V-Triangle)
    // ══════════════════════════════════════════════════════════════════════
    final outerPath = Path();
    // Wide top base
    final double outerTopHalfWidth = size.width * 0.44;
    // Tapers down under the logo
    final double outerBottomHalfWidth = size.width * 0.10;
    final double outerBottomY = size.height * 1.12;

    outerPath.moveTo(centerX - outerTopHalfWidth, -15);
    outerPath.lineTo(centerX + outerTopHalfWidth, -15);
    outerPath.lineTo(centerX + outerBottomHalfWidth, outerBottomY);
    outerPath.lineTo(centerX - outerBottomHalfWidth, outerBottomY);
    outerPath.close();

    final outerConePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          glowColor.withValues(alpha: 0.34),
          glowColor.withValues(alpha: 0.16),
          glowColor.withValues(alpha: 0.03),
          glowColor.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.30, 0.65, 0.90],
      ).createShader(rect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 28);

    canvas.drawPath(outerPath, outerConePaint);

    // ══════════════════════════════════════════════════════════════════════
    // LAYER 3: Inner Focused Core (Soft spotlight on logo)
    // ══════════════════════════════════════════════════════════════════════
    final innerPath = Path();
    final double innerTopHalfWidth = size.width * 0.26;
    final double innerBottomHalfWidth = size.width * 0.04;
    final double innerBottomY = size.height * 0.92;

    innerPath.moveTo(centerX - innerTopHalfWidth, -10);
    innerPath.lineTo(centerX + innerTopHalfWidth, -10);
    innerPath.lineTo(centerX + innerBottomHalfWidth, innerBottomY);
    innerPath.lineTo(centerX - innerBottomHalfWidth, innerBottomY);
    innerPath.close();

    final innerConePaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          coreColor.withValues(alpha: 0.30),
          coreColor.withValues(alpha: 0.12),
          coreColor.withValues(alpha: 0.0),
        ],
        stops: const [0.0, 0.35, 0.70],
      ).createShader(rect)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);

    canvas.drawPath(innerPath, innerConePaint);
  }

  @override
  bool shouldRepaint(covariant _TeamHeaderTriangleGlowPainter oldDelegate) {
    return oldDelegate.glowColor != glowColor ||
        oldDelegate.expandRatio != expandRatio;
  }
}

