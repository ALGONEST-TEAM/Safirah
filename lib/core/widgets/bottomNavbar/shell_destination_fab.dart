import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class ShellDestinationFab extends StatelessWidget {
  const ShellDestinationFab({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.buttonHeight = 56,
    this.backgroundColor = Colors.white,
    this.splashColor,
    this.innerBackgroundColor = const Color(0xFF2C2265),
    this.iconPadding = const EdgeInsets.all(14),
    this.elevation = 0,
  });

  final String label;
  final Widget icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final double buttonHeight;
  final Color backgroundColor;
  final Color? splashColor;
  final Color innerBackgroundColor;
  final EdgeInsetsGeometry iconPadding;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: tooltip ?? label,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: buttonHeight,
            child: Tooltip(
              message: tooltip ?? label,
              child: FloatingActionButton.large(
                onPressed: onPressed,
                backgroundColor: backgroundColor,
                splashColor: splashColor,
                elevation: elevation,
                shape: const CircleBorder(),
                child: Container(
                  padding: iconPadding,
                  decoration: BoxDecoration(
                    color: innerBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: icon,
                ),
              ),
            ),
          ),
          Positioned(
            top: buttonHeight + 2,
            child: IgnorePointer(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





