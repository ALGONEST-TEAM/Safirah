import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/text_form_field.dart';


class SearchInputWidget extends StatelessWidget {
  final TextEditingController search;

  final ValueChanged onChanged;

  const SearchInputWidget({
    super.key,
    required this.search,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.sp),
        child: TextFormFieldWidget(
          controller: search,
          type: TextInputType.text,
          hintText: "Search",
          fillColor: AppColors.greySwatch.shade50,
          onChanged: onChanged,
          prefix: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: SvgPicture.asset(
              AppIcons.search,
              height: 15.h,
              color: AppColors.greySwatch.shade500,
            ),
          ),
        ),
      ),
    );
  }
}
