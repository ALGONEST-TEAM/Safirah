import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import '../../../../../../generated/l10n.dart';

class DialogListTitleWidget extends StatelessWidget {
  final String? title;

  const DialogListTitleWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: SizedBox(
                  width: double.infinity,
                  child: AutoSizeTextWidget(
                    text: title ?? S.of(context).addToList,
                    fontSize: 11.sp,
                    colorText: AppColors.fontColor,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              InkWellButtonWidget(
                icon: AppIcons.close,
                height: 13.h,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        4.h.verticalSpace,
        Divider(
          color: AppColors.greySwatch.shade50,
        ),
        4.h.verticalSpace,
      ],
    );
  }
}
