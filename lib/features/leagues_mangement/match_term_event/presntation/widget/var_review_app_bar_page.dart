
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class VarReviewAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const VarReviewAppBarWidget({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: const BackButton(color: Colors.white),
      backgroundColor: AppColors.secondaryColor,
      title: const AutoSizeTextWidget(
        text: 'VAR',
        colorText: Colors.white,
      ),
    );
  }
}