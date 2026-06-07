import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';


class CheckBoxForCartProductsWidget extends StatelessWidget {
  final bool value;
  final ValueChanged onChanged;

  const CheckBoxForCartProductsWidget(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
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
              width: 1.5,
            );
          }
          return BorderSide(
            color: AppColors.fontColor2.withOpacity(.6),
            width: 1.2,
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
          return Colors.white;
        },
      ),
    );
  }
}
