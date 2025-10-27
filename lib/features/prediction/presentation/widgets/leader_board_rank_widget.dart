import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/auto_size_text_widget.dart';

enum Movement { up, down, none }

class LeaderBoardRankWidget extends StatelessWidget {
  final int rank;
  final Movement movement;

  const LeaderBoardRankWidget({
    super.key,
    required this.rank,
    this.movement = Movement.none,
  });

  Color _movementColor(Movement m) {
    switch (m) {
      case Movement.up:
        return Colors.green;
      case Movement.down:
        return Colors.red;
      case Movement.none:
      default:
        return Colors.grey;
    }
  }

  IconData _movementIcon(Movement m) {
    switch (m) {
      case Movement.up:
        return Icons.arrow_circle_up;
      case Movement.down:
        return Icons.arrow_circle_down;
      case Movement.none:
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
            text:rank.toString(),
            fontSize: 11.6.sp,
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
