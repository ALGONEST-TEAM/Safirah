import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../generated/l10n.dart';
import '../riverpod/user_riverpod.dart';

class ResendCodeWidget extends ConsumerStatefulWidget {
  final String phoneNumberOrEmail;

  const ResendCodeWidget({
    super.key,
    required this.phoneNumberOrEmail,
  });

  @override
  ConsumerState<ResendCodeWidget> createState() => _ResendCodeWidgetState();
}

class _ResendCodeWidgetState extends ConsumerState<ResendCodeWidget> {
  Timer? _timer;
  int countDown = 60;
  bool canResend = false;

  nn() {}

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();

    _timer!.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countDown > 0) {
          countDown--;
        } else {
          canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void resend() {
    if (canResend) {
      setState(() {
        countDown = 60;
        canResend = false;
      });
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(userProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeTextWidget(
          text: S.of(context).resendCodeIN,
          fontSize: 12.sp,
          colorText: AppColors.fontColor,
          textAlign: TextAlign.center,
        ),
        canResend ? 6.w.horizontalSpace : 3.w.horizontalSpace,
        canResend
            ? state.stateData == States.loading
                ? SpinKitThreeBounce(
                    color: AppColors.primaryColor,
                    size: 17.sp,
                  )
                : CheckStateInPostApiDataWidget(
                    state: state,
                    hasMessageSuccess: false,
                    functionSuccess: () {
                      resend();
                    },
                    bottonWidget: InkWell(
                      onTap: () {
                        // ref.read(userProvider.notifier).resendOTP(
                        //       phoneNumberOrEmail: widget.phoneNumberOrEmail,
                        //     );
                      },
                      child: Text(
                        S.of(context).resend,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
            : AutoSizeTextWidget(
                text:
                    "00:${countDown < 10 ? "0${countDown.toString()}" : countDown.toString()}",
                colorText: AppColors.primaryColor,
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w700,
              ),
      ],
    );
  }
}
