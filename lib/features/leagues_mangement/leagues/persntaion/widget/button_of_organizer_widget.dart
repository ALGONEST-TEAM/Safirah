import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class ButtonOfOrganizerWidget extends StatelessWidget {
  const ButtonOfOrganizerWidget({
    super.key,
    required this.onTap,
    required this.title,
    this.isAvailable,
    this.availabilityHint,
  });
 final GestureTapCallback onTap;
 final String title;
 final bool? isAvailable;
 final String? availabilityHint;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 6.0.w,vertical: 4.h),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r)
          ),
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10.0.w,vertical: 14.h),
            child: Row(
               mainAxisSize: MainAxisSize.max,
              children: [
                SvgPicture.asset(AppIcons.league,width: 16.w,height: 16.h,),
                4.w.horizontalSpace,
                 Expanded(
                   child: AutoSizeTextWidget(text:title,fontSize: 11.5.sp,),
                 ),
                 if (isAvailable != null)
                   Tooltip(
                     message: (availabilityHint ?? '').trim().isNotEmpty
                         ? availabilityHint!
                         : (isAvailable == true ? 'متاح الآن' : 'غير متاح حالياً'),
                     child: Container(
                       width: 8.w,
                       height: 8.w,
                       decoration: BoxDecoration(
                         color: isAvailable == true ? Colors.green : Colors.red,
                         shape: BoxShape.circle,
                       ),
                     ),
                   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
