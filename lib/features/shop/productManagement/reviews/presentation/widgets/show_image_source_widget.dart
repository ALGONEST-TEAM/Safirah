import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../generated/l10n.dart';

class ShowImageSourceWidget extends StatefulWidget {
  final List<File> images;

  final Function(List<File>) onImagePicked;

  const ShowImageSourceWidget(
      {super.key, required this.images, required this.onImagePicked});

  @override
  State<ShowImageSourceWidget> createState() => _ShowImageSourceWidgetState();
}

class _ShowImageSourceWidgetState extends State<ShowImageSourceWidget> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      widget.images.add(File(pickedFile.path));
      widget.onImagePicked(widget.images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        S.of(context).chooseImageSource,
        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      content: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(AppIcons.takePhoto),
                      8.h.verticalSpace,
                      Text(
                        S.of(context).takePhoto,
                        style: TextStyle(
                          fontSize: 10.8.sp,
                          color: AppColors.fontColor2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            10.w.horizontalSpace,
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(AppIcons.gallery),
                      8.h.verticalSpace,
                      Text(
                        S.of(context).gallery,
                        style: TextStyle(
                          fontSize: 10.8.sp,
                          color: AppColors.fontColor2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
