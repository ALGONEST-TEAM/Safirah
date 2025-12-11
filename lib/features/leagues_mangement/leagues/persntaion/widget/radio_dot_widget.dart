
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioDotWidget extends StatelessWidget {
  final bool selected;

  const RadioDotWidget({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18.w,
      height: 18.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? const Color(0xFF1E1846) : Colors.grey.shade400,
          width: 2,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        width: 8.w,
        height: 8.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? const Color(0xFF1E1846) : Colors.transparent,
        ),
      ),
    );
  }
}
