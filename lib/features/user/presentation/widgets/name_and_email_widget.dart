import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_icons.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/text_form_field.dart';
import '../../../../generated/l10n.dart';

class NameAndEmailWidget extends StatelessWidget {
  final TextEditingController name;
  // final TextEditingController email;

  const NameAndEmailWidget({
    super.key,
    required this.name,
    // required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.h.verticalSpace,
        AutoSizeTextWidget(
          text: S.of(context).name,
          fontSize: 11.sp,
          colorText: Colors.black87,
        ),
        6.h.verticalSpace,
        TextFormFieldWidget(
          controller: name,
          hintText: "${S.of(context).enter} ${S.of(context).name}",
          fieldValidator: (value) {
            if (value == null || value.toString().isEmpty) {
              return S.of(context).pleaseEnterYourName;
            }
          },
          prefix: Padding(
            padding: EdgeInsets.all(11.sp),
            child: SvgPicture.asset(
              AppIcons.profile,
              height: 14.h,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        12.h.verticalSpace,
        // AutoSizeTextWidget(
        //   text: "${S.of(context).email} (اختياري)",
        //   fontSize: 11.sp,
        //   colorText: Colors.black87,
        // ),
        // 6.h.verticalSpace,
        // TextFormFieldWidget(
        //   controller: email,
        //   type: TextInputType.emailAddress,
        //   hintText: "إدخل بريدك إلاكتروني",
        //   fieldValidator: (value) {
        //     final email = value?.trim() ?? '';
        //     if (email.isEmpty) return null;
        //     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        //     if (!emailRegex.hasMatch(email)) {
        //       return 'الرجاء إدخال بريد إلكتروني صالح';
        //     }
        //     return null;
        //   },
        //   prefix: Padding(
        //     padding: EdgeInsets.all(11.sp),
        //     child: SvgPicture.asset(
        //       AppIcons.email,
        //       height: 14.h,
        //     ),
        //   ),
        // ),
        // 12.h.verticalSpace,
      ],
    );
  }
}
