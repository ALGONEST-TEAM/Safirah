import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/auto_size_text_widget.dart';

class TeamTileWidget extends StatelessWidget {
  final String name;
  final String? avatarUrl;
  final VoidCallback onTap;

  const TeamTileWidget(
      {super.key, required this.name,
        this.avatarUrl,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage:
              avatarUrl != null ? FileImage(File(avatarUrl!)) : null,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(width: 10),
            Expanded(child: AutoSizeTextWidget(text: name, fontSize: 14.sp)),
          ],
        ),
      ),
    );
  }
}
