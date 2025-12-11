import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class DivideGroupAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const DivideGroupAppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const BackButton(color: Colors.white),
      backgroundColor: AppColors.secondaryColor,
      title: const AutoSizeTextWidget(
        text: 'تقسيم المجموعات',
        colorText: Colors.white,
      ),
      centerTitle: true,
    );
  }
}

