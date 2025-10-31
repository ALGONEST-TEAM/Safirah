import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class VerifyPinputWidget extends StatefulWidget {
  final TextEditingController verifyController;

  const VerifyPinputWidget({
    super.key,
    required this.verifyController,
  });

  @override
  State<VerifyPinputWidget> createState() => _VerifyPinputWidgetState();
}

class _VerifyPinputWidgetState extends State<VerifyPinputWidget>
    with WidgetsBindingObserver {
  late final FocusNode _focus;
  bool _wasFocused = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _focus = FocusNode();
    _focus.addListener(() => _wasFocused = _focus.hasFocus);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _wasFocused && mounted) {
      Future.microtask(() {
        if (!mounted) return;
        FocusScope.of(context).requestFocus(_focus);
        SystemChannels.textInput.invokeMethod('TextInput.show');
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: widget.verifyController,
      focusNode: _focus,
      autofocus: true,
      length: 6,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      autofillHints: const [AutofillHints.oneTimeCode],
      defaultPinTheme: PinTheme(
        width: 62.w,
        height: 44.h,
        textStyle: TextStyle(
          fontSize: 16.sp,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        decoration: BoxDecoration(
          color: const Color(0xfff4f6f9),
          borderRadius: BorderRadius.circular(4.sp),
          border: Border.all(color: Colors.black12),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 62.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: const Color(0xfff4f6f9),
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(4.sp),
        ),
      ),
    );
  }
}
