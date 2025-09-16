import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';


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
        'تحديد طريقة اختيار صورة',
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.white,
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 38.r,
                    ),
                    4.h.verticalSpace,
                    Text(
                      'كاميرا',
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.photo_library, size: 38.r),
                    4.h.verticalSpace,
                    Text(
                      'الهاتف',
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
