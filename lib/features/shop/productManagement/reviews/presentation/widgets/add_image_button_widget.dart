import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';

class AddImageButtonWidget extends StatelessWidget {
  final Widget showImageSource;

  const AddImageButtonWidget({super.key, required this.showImageSource});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainterWidget(),
      child: DefaultButtonWidget(
        text: '',
        withIcon: true,
        icon: AppIcons.addPhotos,
        background: AppColors.scaffoldColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return showImageSource;
            },
          );
        },
      ),
    );
  }
}

class DashedBorderPainterWidget extends CustomPainter {
  final double radius;

  DashedBorderPainterWidget({this.radius = 8});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.secondaryColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    const dashWidth = 2.0;
    const dashSpace = 1.5;

    // نرسم مستطيل بحواف دائرية
    final RRect rect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      Radius.circular(radius),
    );

    // نحول المستطيل لمسار (Path)
    final Path path = Path()..addRRect(rect);

    // دوال لتقطيع المسار (dashed effect)
    double dashLength = dashWidth;
    double dashGap = dashSpace;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final double nextDistance = distance + dashLength;
        canvas.drawPath(
          pathMetric.extractPath(distance, nextDistance),
          paint,
        );
        distance = nextDistance + dashGap;
      }
      distance = 0.0;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
