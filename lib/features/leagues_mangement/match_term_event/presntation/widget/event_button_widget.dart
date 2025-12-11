// presentation/widgets/event_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventButtonWidget extends ConsumerWidget {
  final String iconPath;
  final Color color;
  final int count;
  final Future<void> Function(BuildContext, WidgetRef) onPressed;

  const EventButtonWidget({
    super.key,
    required this.iconPath,
    required this.color,
    required this.count,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => onPressed(context, ref),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset(iconPath, color: color),
          if (count > 0)
            Positioned(
              right: -5,
              top: -5,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
