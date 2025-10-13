import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../generated/l10n.dart';

class EditProfileAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const EditProfileAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.secondaryColor,
      surfaceTintColor: AppColors.secondaryColor,
      centerTitle: true,
      automaticallyImplyLeading: false,
      toolbarHeight: 74.h,
      elevation: 0.0,
      title: AutoSizeTextWidget(
        text: S.of(context).editProfile,
        colorText: Colors.white,
        fontSize: 14.8.sp,
      ),
      leading: const IconButtonWidget(iconColor: Colors.white),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(74.h);
}
