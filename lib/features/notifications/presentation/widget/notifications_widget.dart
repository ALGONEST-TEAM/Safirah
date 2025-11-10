import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../state_mangment/notifications_riverpod.dart';

class NotificationsWidget extends ConsumerWidget {
  final String title;
  final String message;
  final String date;
  final String? readAt;
  final int index;
  const NotificationsWidget({
    super.key,
    required this.title,
    required this.message,
    required this.date,
    required this.readAt,
    required this.index,

  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final isRead = readAt != null;

    return InkWell(
      onTap: (){
         ref.read(notificationProvider.notifier).markAsRead(index: index);

      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    color:  isRead ? Colors.grey.shade300 : AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  child: Icon(
                    Icons.notifications,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                ),
                12.w.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: AutoSizeTextWidget(
                              text: title,
                              fontSize: 11.6.sp,
                              maxLines: 4,
                            ),
                          ),
                          8.w.horizontalSpace,
                          Padding(
                            padding: EdgeInsets.only(top: 3.h),
                            child: AutoSizeTextWidget(
                              text: date,
                              fontSize: 8.sp,
                              colorText: AppColors.fontColor,
                              maxLines: 4,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AutoSizeTextWidget(
                        text: message,
                        colorText: AppColors.fontColor,
                        fontSize: 10.6.sp,
                        maxLines: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
