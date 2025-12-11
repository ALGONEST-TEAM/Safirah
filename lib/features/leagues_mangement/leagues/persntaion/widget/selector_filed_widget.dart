import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/auto_size_text_widget.dart';

class SelectorFieldWidget extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;

  const SelectorFieldWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: label,
          fontSize: 12.sp,
          colorText: Colors.black,
        ),
        SizedBox(height: 6.h),
        InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeTextWidget(
                    text: value,
                    textAlign: TextAlign.start,
                    fontSize: 13.sp,
                    // colorText: Colors.black87,
                    colorText: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Icon(Icons.expand_more, color: Colors.black54, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
