import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class AppRestartController extends StatefulWidget {
  final Widget child;
  static _AppRestartControllerState? _state;

  const AppRestartController({
    super.key,
    required this.child,
  });

  static Future<void> restartApp(BuildContext context) async {
    await _state?.restart();
  }

  @override
  _AppRestartControllerState createState() {
    _state = _AppRestartControllerState();
    return _state!;
  }
}

class _AppRestartControllerState extends State<AppRestartController> {
  Key _key = UniqueKey();

  Future<void> restart() async {
    await Hive.deleteFromDisk();

    // تغيير مفتاح `ProviderScope` لإعادة تشغيل جميع Providers
    setState(() {
      _key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      key: _key, // إعادة بناء ProviderScope عند تغيير المفتاح
      child: widget.child,
    );
  }
}
