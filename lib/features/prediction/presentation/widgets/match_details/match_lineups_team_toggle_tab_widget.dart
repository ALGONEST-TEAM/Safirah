import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class MatchLineupsTeamToggleTabWidget extends StatelessWidget {
  final String title;
  final bool isHome;
  final bool showHomeTeam;
  final ValueChanged<bool> onToggle;

  const MatchLineupsTeamToggleTabWidget({
    super.key,
    required this.title,
    required this.isHome,
    required this.showHomeTeam,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = showHomeTeam == isHome;
    return GestureDetector(
      onTap: () => onToggle(isHome),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        alignment: Alignment.center,
        child: AutoSizeTextWidget(
          text: title.isNotEmpty ? title : (isHome ? 'صاحب الأرض' : 'الضيف'),
          fontSize: 12.5.sp,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          colorText: isSelected ? Colors.white : AppColors.fontColor,
          maxLines: 1,
        ),
      ),
    );
  }
}
