import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';

class CheckBoxForWishlistWidget extends StatelessWidget {
  final bool value;
  final ValueChanged onChanged;
  final Color? fillColor;
  final Color? borderColor;

  const CheckBoxForWishlistWidget({
    super.key,
    required this.value,
    required this.onChanged,
    this.fillColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: value == true ? 1.05 : 1.2,
      child: Checkbox(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryColor,
        checkColor: Colors.white,
        shape: const CircleBorder(),
        side: WidgetStateBorderSide.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return const BorderSide(
                color: AppColors.primaryColor,
                width: 1,
              );
            }
            return BorderSide(
              color: borderColor ?? AppColors.whiteColor,
              width: 1,
            );
          },
        ),
        visualDensity: const VisualDensity(
          horizontal: -4,
        ),
        fillColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primaryColor;
            }
            return fillColor ?? Colors.black12;
          },
        ),
      ),
    );
  }
}
