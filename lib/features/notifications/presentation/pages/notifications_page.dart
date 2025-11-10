import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../generated/l10n.dart';
import '../state_mangment/notifications_riverpod.dart';
import '../widget/list_of_notifications_widget.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(notificationProvider);
    return Scaffold(
      appBar: SecondaryAppBarWidget(
        title: S.of(context).notificationsTitle,
        fontSize: 15.sp,
      ),
      body: SafeArea(
        top: false,
        child: CheckStateInGetApiDataWidget(
          state: state,
          refresh: () {
            ref.refresh(notificationProvider);
          },
          widgetOfData: state.data.isEmpty
              ? SizedBox(
                  width: double.infinity,
                  height: 300.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 8.h,
                    children: [
                      Icon(
                        Icons.notifications_off_outlined,
                        size: 66.sp,
                        color: AppColors.primaryColor,
                      ),
                      AutoSizeTextWidget(
                        text: "${S.of(context).notificationsTitle} ${S.of(context).empty}",
                        fontSize: 15.sp,
                      ),
                    ],
                  ),
                )
              : ListOfNotificationsWidget(
                  getNotifications: state.data,
                ),
        ),
      ),
    );
  }
}
