import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';

class ViewPhoneNumberOrEmailWidget extends StatelessWidget {
  final String email;
  final String title;
  final bool editIcon;

  const ViewPhoneNumberOrEmailWidget({
    super.key,
    required this.email,
    required this.title,
    this.editIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.h.verticalSpace,
        AutoSizeTextWidget(
          text: title == 'email'
              ? "email:"
              : "${S.of(context).phoneNumber}:",
          fontSize: 13.sp,
          colorText: Colors.black87,
        ),
        6.h.verticalSpace,
        Container(
          height: 42.h,
          padding: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
            color: AppColors.greySwatch.shade100.withOpacity(.8),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            children: [
              Visibility(
                visible: editIcon,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.edit,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                ),
              ),
              8.w.horizontalSpace,
              AutoSizeTextWidget(
                text: email,
                fontSize: 12.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
