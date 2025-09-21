import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListOfSelectedImagesToAddAReviewWidget extends StatelessWidget {
  final List<File> images;

  const ListOfSelectedImagesToAddAReviewWidget(
      {super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 18.h),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Image.file(
          images[index],
          fit: BoxFit.cover,
        );
      },
    );
  }
}
