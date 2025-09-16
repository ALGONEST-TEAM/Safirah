import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../generated/l10n.dart';

class AddImageButtonWidget extends StatelessWidget {
  final Widget showImageSource;

  const AddImageButtonWidget({super.key, required this.showImageSource});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(1, 1),
      child: ElevatedButton.icon(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return showImageSource;
              });
        },
        icon: const Icon(
          Icons.camera_alt,
          color: AppColors.primaryColor,
        ),
        label:  Text(
          S.of(context).addPhotos,
          style: const TextStyle(color: AppColors.primaryColor),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 8.h,
            horizontal: 14.w,
          ),
        ),
      ),
    );
  }
}
