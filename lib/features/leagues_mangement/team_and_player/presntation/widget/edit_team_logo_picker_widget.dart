import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';

class EditTeamLogoPickerWidget extends StatelessWidget {
  final String? logoPath;
  final ImagePicker picker;
  final ValueChanged<String?> onLogoChanged;

  const EditTeamLogoPickerWidget({
    super.key,
    required this.logoPath,
    required this.picker,
    required this.onLogoChanged,
  });

  Future<void> _pickLogo(BuildContext context, ImageSource source) async {
    final XFile? file = await picker.pickImage(source: source, imageQuality: 70);
    if (file == null) return;
    onLogoChanged(file.path);
  }

  Future<void> _showLogoSourceSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('اختيار من المعرض'),
                  onTap: () async {
                    Navigator.of(ctx).pop();
                    await _pickLogo(context, ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('التقاط من الكاميرا'),
                  onTap: () async {
                    Navigator.of(ctx).pop();
                    await _pickLogo(context, ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeTextWidget(
          text: 'شعار الفريق',
          fontSize: 12.sp,
          colorText: Colors.black,
        ),
        SizedBox(height: 6.h),
        GestureDetector(
          onTap: () async {
            await _showLogoSourceSheet(context);
          },
          child: Container(
            height: 90.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              image: logoPath != null
                  ? DecorationImage(
                image: FileImage(File(logoPath!)),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: logoPath == null
                ? const Icon(Icons.upload, color: Colors.grey)
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}

