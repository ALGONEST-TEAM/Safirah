import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/buttons/icon_button_widget.dart';

class AppBarToUserWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarToUserWidget({super.key});

  @override
  Size get preferredSize => Size.fromHeight(36.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      leading: IconButtonWidget(
        iconColor: AppColors.primaryColor,
        height: 30.h,
      ),
    );
  }
}
