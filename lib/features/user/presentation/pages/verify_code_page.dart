import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../../core/helpers/navigateTo.dart';
import '../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../core/state/state.dart';
import '../../../../core/widgets/bottomNavbar/bottom_navigation_bar_widget.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../generated/l10n.dart';
import '../../../../services/auth/auth.dart';
import '../riverpod/user_riverpod.dart';
import '../widgets/resend_code_widget.dart';
import '../widgets/verify_pinput_widget.dart';
import 'sign_up_page.dart';

class VerifyCodePage extends ConsumerStatefulWidget {
  final String phoneNumber;

  const VerifyCodePage({super.key, required this.phoneNumber});

  @override
  ConsumerState<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends ConsumerState<VerifyCodePage>
    with CodeAutoFill {
  static const _otpLen = 6;

  final TextEditingController _verifyController = TextEditingController();

  bool _canAutoSubmit = true;

  @override
  void initState() {
    super.initState();
    listenForCode();

    _verifyController.addListener(_maybeAutoSubmit);
  }

  @override
  void codeUpdated() {
    final c = code ?? '';
    if (c.isNotEmpty) {
      _verifyController.text = c;
    }
  }

  void _maybeAutoSubmit() {
    final text = _verifyController.text.trim();
    if (text.length < _otpLen) {
      _canAutoSubmit = true;
      return;
    }
    if (_canAutoSubmit && text.length == _otpLen) {
      _canAutoSubmit = false;
      FocusManager.instance.primaryFocus?.unfocus();
      ref.read(checkOTPProvider.notifier).checkOTP(
            phoneNumber: widget.phoneNumber,
            otp: text,
          );
    }
  }

  @override
  void dispose() {
    cancel();
    _verifyController.removeListener(_maybeAutoSubmit);
    _verifyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final checkOTPState = ref.watch(checkOTPProvider);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${S.of(context).codeHasBeenSendTo} ${widget.phoneNumber}",
            style: TextStyle(fontSize: 11.4.sp, fontWeight: FontWeight.w600),
          ),
          24.h.verticalSpace,
          VerifyPinputWidget(verifyController: _verifyController),
          24.h.verticalSpace,
          ResendCodeWidget(
            phoneNumberOrEmail: widget.phoneNumber,
          ),
          24.h.verticalSpace,
          CheckStateInPostApiDataWidget(
            state: checkOTPState,
            hasMessageSuccess: checkOTPState.data.status == true,
            messageSuccess: S.of(context).loginSuccessful,
            functionSuccess: () async {
              if (checkOTPState.data.status == true) {
                Auth().login(checkOTPState.data);
                navigateAndFinish(context, const BottomNavigationBarWidget());
              } else {
                Navigator.of(context).pop();
                navigateTo(context, const SignUpPage());
              }
            },
            bottonWidget: DefaultButtonWidget(
              text: S.of(context).confirm,
              textSize: 14.4.sp,
              height: 40.h,
              isLoading: checkOTPState.stateData == States.loading,
              onPressed: () {
                final code = _verifyController.text.trim();
                if (code.length != _otpLen) return;
                FocusManager.instance.primaryFocus?.unfocus();
                ref.read(checkOTPProvider.notifier).checkOTP(
                      phoneNumber: widget.phoneNumber,
                      otp: code,
                    );
              },
            ),
          ),
          24.h.verticalSpace,
        ],
      ),
    );
  }
}
// class VerifyCodePage extends ConsumerStatefulWidget {
//   final String phoneNumber;
//
//   const VerifyCodePage({super.key, required this.phoneNumber});
//
//   @override
//   ConsumerState<VerifyCodePage> createState() => _VerifyCodePageState();
// }
//
// class _VerifyCodePageState extends ConsumerState<VerifyCodePage>
//     with CodeAutoFill {
//   static const _otpLen = 6;
//
//   final _formKey = GlobalKey<FormState>();
//   final _ctrl = TextEditingController();
//
//   /// علم يثبت أن التغيير القادم موثوق (من Retriever)
//   bool _fromRetriever = false;
//
//   /// لمنع تكرار السبمت مرة ثانية
//   bool _submittedOnce = false;
//
//   Future<void> printRuntimeSignature() async {
//     final sig = await SmsAutoFill().getAppSignature;
//     debugPrint('🔥 Runtime AppSignature: $sig');
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     printRuntimeSignature(); // يشير لِهاش هذه النسخة
//
//     // ✅ فعّل SMS Retriever (بدون صلاحيات/نافذة)
//     listenForCode();
//
//     // راقب تغيّر النص
//     _ctrl.addListener(_onTextChanged);
//   }
//
//   /// يُستدعى فقط عندما الرسالة مطابقة للتوقيع الصحيح
//   @override
//   void codeUpdated() {
//     final c = code ?? '';
//     if (c.isNotEmpty) {
//       _fromRetriever = true; // المصدر موثوق
//       _submittedOnce = false; // اسمح بمحاولة سبمت جديدة
//       _ctrl.text = c; // املأ الحقل
//       debugPrint('📩 SMS Retriever hit with code: $c');
//     }
//   }
//
//   void _onTextChanged() {
//     final text = _ctrl.text.trim();
//
//     // لو التغيير ليس من Retriever، تجاهله تماماً (امسح)
//     if (!_fromRetriever) {
//       if (text.isNotEmpty) {
//         debugPrint('❌ Ignoring non-Retriever change: $text');
//         // امسح أي لصق/اقتراح من الكيبورد أو المستخدم
//         _ctrl.clear();
//       }
//       return;
//     }
//
//     // هنا فقط لو _fromRetriever = true
//     if (text.length == _otpLen && !_submittedOnce) {
//       _submittedOnce = true;
//       _fromRetriever = false; // امنع أي تغييرات لاحقة غير موثوقة
//       FocusManager.instance.primaryFocus?.unfocus();
//       ref.read(checkOTPProvider.notifier).checkOTP(
//             phoneNumber: widget.phoneNumber,
//             otp: text,
//           );
//     }
//   }
//
//   @override
//   void dispose() {
//     cancel(); // ⛔️ إيقاف SMS Retriever
//     _ctrl.removeListener(_onTextChanged);
//     _ctrl.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final checkOTPState = ref.watch(checkOTPProvider);
//     final isLoading = checkOTPState.stateData == States.loading;
//
//     return Form(
//       key: _formKey,
//       child: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 14.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AutoSizeTextWidget(
//               text: "${S.of(context).codeHasBeenSendTo} ${widget.phoneNumber}",
//               fontSize: 11.4.sp,
//               fontWeight: FontWeight.w600,
//               colorText: AppColors.fontColor,
//             ),
//             24.h.verticalSpace,
//             VerifyPinputWidget(
//               verifyController: _ctrl
//             ),
//             // _VerifyPinput(controller: _ctrl, length: _otpLen),
//             24.h.verticalSpace,
//
//             ResendCodeWidget(
//               phoneNumberOrEmail: widget.phoneNumber,
//             ),
//             24.h.verticalSpace,
//
//             /// زر يدوي كـ fallback — إذا تبغى تمنعه تماماً،
//             /// تقدر تشيّكه فقط لما _fromRetriever=true
//             CheckStateInPostApiDataWidget(
//               state: checkOTPState,
//               hasMessageSuccess: checkOTPState.data.status == true,
//               messageSuccess: S.of(context).loginSuccessful,
//               functionSuccess: () async {
//                 if (checkOTPState.data.status == true) {
//                   Auth().login(checkOTPState.data);
//                   navigateAndFinish(context, const BottomNavigationBarWidget());
//                 } else {
//                   Navigator.of(context).pop();
//                   navigateTo(context, const SignUpPage());
//                 }
//               },
//               bottonWidget: DefaultButtonWidget(
//                 text: S.of(context).confirm,
//                 textSize: 14.4.sp,
//                 height: 40.h,
//                 isLoading: isLoading,
//                 onPressed: isLoading
//                     ? null
//                     : () {
//                         // لو تبغى تمنع الإدخال اليدوي تمامًا، احذف هذا البلوك أو اشترط _fromRetriever
//                         final code = _ctrl.text.trim();
//                         if (code.length != _otpLen || !_submittedOnce) return;
//                         FocusManager.instance.primaryFocus?.unfocus();
//                         ref.read(checkOTPProvider.notifier).checkOTP(
//                               phoneNumber: widget.phoneNumber,
//                               otp: code,
//                             );
//                       },
//               ),
//             ),
//             24.h.verticalSpace,
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _VerifyPinput extends StatefulWidget {
//   final TextEditingController controller;
//   final int length;
//
//   const _VerifyPinput({required this.controller, this.length = 6});
//
//   @override
//   State<_VerifyPinput> createState() => _VerifyPinputState();
// }
//
// class _VerifyPinputState extends State<_VerifyPinput>
//     with WidgetsBindingObserver {
//   late final FocusNode _focus;
//   bool _wasFocused = false;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _focus = FocusNode();
//     _focus.addListener(() => _wasFocused = _focus.hasFocus);
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed && _wasFocused && mounted) {
//       Future.microtask(() {
//         if (!mounted) return;
//         FocusScope.of(context).requestFocus(_focus);
//         SystemChannels.textInput.invokeMethod('TextInput.show');
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _focus.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Pinput(
//       controller: widget.controller,
//       focusNode: _focus,
//       autofocus: true,
//       length: widget.length,
//
//       // ⚠️ مهم: لا تتيح اقتراحات النظام حتى لا يلتقط “توقيع مزوّر”
//       // لا نضع autofillHints
//       // autofillHints: const [AutofillHints.oneTimeCode],
//
//       keyboardType: TextInputType.number,
//       enableSuggestions: false,
//       // يقلل اقتراحات الكيبورد
//       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//
//       defaultPinTheme: PinTheme(
//         width: 62.w,
//         height: 44.h,
//         textStyle: TextStyle(
//           fontSize: 16.sp,
//           color: Colors.black,
//           fontWeight: FontWeight.w600,
//         ),
//         decoration: BoxDecoration(
//           color: const Color(0xfff4f6f9),
//           borderRadius: BorderRadius.circular(4.sp),
//           border: Border.all(color: Colors.black12),
//         ),
//       ),
//       focusedPinTheme: PinTheme(
//         width: 62.w,
//         height: 44.h,
//         decoration: BoxDecoration(
//           color: const Color(0xfff4f6f9),
//           border: Border.all(color: Colors.black12),
//           borderRadius: BorderRadius.circular(4.sp),
//         ),
//       ),
//
//       validator: (value) {
//         final v = value?.trim() ?? '';
//         if (v.isEmpty || v.length != widget.length) {
//           return 'الرجاء إدخال رمز التحقق';
//         }
//         return null;
//       },
//     );
//   }
// }
