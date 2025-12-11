import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class ButtonOfOrganizerWidget extends StatelessWidget {
  const ButtonOfOrganizerWidget({super.key,required this.onTap,required this.title});
 final GestureTapCallback onTap;
 final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r)
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 6.0.w,vertical: 8.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppIcons.league,width: 16.w,height: 16.h,),
              AutoSizeTextWidget(text:title,fontSize: 11.5.sp,)
            ],
          ),
        ),
      ),
    );
  }
}
