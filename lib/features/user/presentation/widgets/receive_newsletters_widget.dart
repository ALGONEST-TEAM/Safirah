import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';

class ReceiveNewslettersWidget extends StatefulWidget {
  const ReceiveNewslettersWidget({super.key});

  @override
  State<ReceiveNewslettersWidget> createState() =>
      _ReceiveNewslettersWidgetState();
}

class _ReceiveNewslettersWidgetState extends State<ReceiveNewslettersWidget> {
  bool isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isAgreed = !isAgreed;
              });
            },
            child: Container(
              height: 21.h,
              width: 21.w,
              decoration: BoxDecoration(
                color: isAgreed ? AppColors.primaryColor : Colors.transparent,
                border: Border.all(color: Colors.black26, width: 1),
                shape: BoxShape.circle,
              ),
              child: isAgreed
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18,
                    )
                  : null,
            ),
          ),
          8.w.horizontalSpace,
          Expanded(
            child: AutoSizeTextWidget(
              text: "تلقى رسائل اخبارية ونصائح حصرية حول الاناقة من جـــــي"
                  " عبر رسائل القصيرة",
              colorText: AppColors.fontColor,
              fontSize: 11.sp,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
