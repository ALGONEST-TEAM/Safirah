import 'package:flutter/material.dart';

import '../../../../../core/widgets/auto_size_text_widget.dart';

class VarReviewDescriptionWidget extends StatelessWidget {
  const VarReviewDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AutoSizeTextWidget(
          text: "قم بمراجعة الحكام المساعدين لتأكيد أو إلغاء الحدث.",
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w400,
        ),
        AutoSizeTextWidget(
          text: "الوقت الضائع محسوب بالكامل في حالة التأخير.",
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}
