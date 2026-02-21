import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../services/auth/auth.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/notifications/presentation/state_mangment/notifications_riverpod.dart';
import '../../features/user/presentation/pages/log_in_page.dart';
import '../helpers/navigateTo.dart';
import '../theme/app_colors.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const MainAppBarWidget({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(40.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: AutoSizeTextWidget(
        text: title,
        fontSize: 14.8.sp,
        fontWeight: FontWeight.w600,
      ),
      actions: [
        Consumer(builder: (context, ref, _) {
          final unread = ref.watch(unreadCountProvider);

          return Stack(
            clipBehavior: Clip.none,
            children: [
              IconButtonWidget(
                icon: AppIcons.notification,
                height: 20.h,
                onPressed: () async {
                  if (!Auth().loggedIn) {
                    navigateTo(context, const LogInPage());
                  } else {
                    navigateTo(context, const NotificationsPage());
                    ref.read(unreadCountProvider.notifier).refresh();
                  }
                },
              ),
              if (unread > 0)
                Positioned(
                  left: unread >= 10 ? 4.w : 6.w,
                  top: 1,
                  child: Container(
                    padding: EdgeInsets.all(unread >= 10 ? 1.6.sp : 2.sp),
                    decoration: BoxDecoration(
                      color: AppColors.dangerColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                    ),
                    child: AutoSizeTextWidget(
                      text: unread > 99 ? '99+' : ' $unread ',
                      colorText: Colors.white,
                      fontSize: 7.2.sp,
                      minFontSize: 6,
                    ),
                  ),
                ),
            ],
          );
        }),
      ],
    );
  }
}
