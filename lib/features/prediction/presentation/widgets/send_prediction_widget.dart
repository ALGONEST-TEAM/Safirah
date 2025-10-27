import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../generated/l10n.dart';
import 'matches_widget.dart';
import 'prediction_fields_widget.dart';
import 'team_widget.dart';

class SendPredictionWidget extends StatefulWidget {
  final String title;
  final MatchItem items;

  const SendPredictionWidget(
      {super.key, required this.title, required this.items});

  @override
  State<SendPredictionWidget> createState() => _SendPredictionWidgetState();
}

class _SendPredictionWidgetState extends State<SendPredictionWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _homeController = TextEditingController();
  final TextEditingController _awayController = TextEditingController();

  @override
  void dispose() {
    _homeController.dispose();
    _awayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeTextWidget(
              text: widget.title,
              fontSize: 10.6.sp,
            ),
            Divider(
              height: 18.h,
              color: AppColors.fontColor2.withValues(alpha: .15),
            ),
            AutoSizeTextWidget(
              text: "السبت 15 يناير 2025",
              fontSize: 10.6.sp,
            ),
            Divider(
              height: 18.h,
              color: AppColors.fontColor2.withValues(alpha: .15),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TeamWidget(
                  name: widget.items.home,
                  image: widget.items.image,
                  alignRight: true,
                  fontSize: 11.8.sp,
                  sizeImage: Size(26.w, 26.h),
                  width: 120.w,
                ),
                Expanded(
                  child: AutoSizeTextWidget(
                    text: widget.items.time,
                    fontSize: 13.6.sp,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                ),
                TeamWidget(
                  name: widget.items.away,
                  image: widget.items.awayImage,
                  alignRight: false,
                  fontSize: 11.8.sp,
                  sizeImage: Size(26.w, 26.h),
                  width: 120.w,
                ),
              ],
            ),
            PredictionFieldsWidget(
              homeController: _homeController,
              awayController: _awayController,
            ),
            20.h.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: DefaultButtonWidget(
                    text: S.of(context).confirm,
                    height: 38.h,
                    borderRadius: 12.sp,
                    textSize: 12.sp,
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;
                    },
                  ),
                ),
                30.w.horizontalSpace,
                Expanded(
                  child: DefaultButtonWidget(
                    text: S.of(context).cancel,
                    height: 38.h,
                    borderRadius: 12.sp,
                    textSize: 12.sp,
                    background: AppColors.scaffoldColor,
                    textColor: AppColors.fontColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
