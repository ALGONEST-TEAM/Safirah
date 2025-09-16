import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class ViewEmailWidget extends StatelessWidget {
  final String email;

  const ViewEmailWidget({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: AppColors.greySwatch.shade100.withOpacity(.8),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context);
            },
            child: const Icon(
              Icons.edit,
              color: AppColors.primaryColor,
              size: 20,
            ),
          ),
          8.w.horizontalSpace,
          AutoSizeTextWidget(
            text: email,
            fontSize: 12.sp,
          ),
        ],
      ),
    );
  }
}
