import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';


class RequiredInputsWidget extends StatelessWidget {
  final FormGroup form;
  final String value;
  final String requiredText;

  const RequiredInputsWidget({
    super.key,
    required this.form,
    required this.value,
    required this.requiredText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (form.control(value).invalid)
          StreamBuilder(
            stream: form.control(value).touchChanges,
            builder: (context, snapshot) {
              if (snapshot.data == true) {

                return Padding(
                  padding: EdgeInsets.only(top: 8.h, left: 12.w, right: 12.w),
                  child: AutoSizeTextWidget(
                    text: requiredText,
                    fontSize: 10.6.sp,
                    colorText: AppColors.dangerSwatch.shade400,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
      ],
    );
  }
}


// SchedulerBinding.instance.addPostFrameCallback((_) {
// showFlashBarWarring(
// context: context,
// message: requiredText,
// );
// });