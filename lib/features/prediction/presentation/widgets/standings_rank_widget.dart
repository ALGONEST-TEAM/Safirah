import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';

class StandingsRankWidget extends StatelessWidget {
  final num rank;
  final String movement;
  final Color fontColor;

  const StandingsRankWidget({
    super.key,
    required this.rank,
    required this.movement,
    this.fontColor = Colors.black,
  });

  Color _movementColor(String m) {
    switch (m) {
      case 'up':
        return Colors.green;
      case 'down':
        return Colors.red;
      case 'idle':
      default:
        return Colors.grey;
    }
  }

  IconData _movementIcon(String m) {
    switch (m) {
      case 'up':
        return Icons.arrow_circle_up;
      case 'down':
        return Icons.arrow_circle_down;
      case 'idle':
      default:
        return Icons.cloud_circle_sharp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56.w,
      child: Row(
        children: [
          AutoSizeTextWidget(
            text: rank.toString(),
            fontSize: 11.6.sp,
            colorText: fontColor,
          ),
          SizedBox(width: 8.w),
          Icon(
            _movementIcon(movement),
            size: 16.6.sp,
            color: _movementColor(movement),
          ),
        ],
      ),
    );
  }
}
