import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';

class MoreDetailsWidget extends StatelessWidget {
  final Widget page;
  final String describe;
  final String icon;

  const MoreDetailsWidget({
    super.key,
    required this.page,
    required this.describe,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheetWidget(context: context, page: page);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon),
            8.w.horizontalSpace,
            AutoSizeTextWidget(
              text: describe,
              colorText: Colors.black87,
              fontSize: 11.6.sp,
              fontWeight: FontWeight.w400,
            ),
            const Spacer(),
            SvgPicture.asset(AppIcons.arrowBottom),
          ],
        ),
      ),
    );
  }
}
