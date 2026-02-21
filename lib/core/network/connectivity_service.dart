import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

/// فحص الاتصال بالشبكة والإنترنت + بث تغيّر الحالة.
///
/// استخدام [connectivity_plus] أكثر احترافية من polling.
/// ملاحظة مهمة: connectivity_plus يخبرك بنوع الشبكة (Wifi/Mobile) لكنه لا يضمن وجود إنترنت فعلي.
/// لذلك نضيف فحص إنترنت فعلي بسيط عبر DNS lookup.
class ConnectivityService {
  ConnectivityService({
    Connectivity? connectivity,
    this.lookupHost = 'saferah.dev-station.com',
    this.debounce = const Duration(milliseconds: 400),
  }) : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  /// Host بسيط لاختبار DNS (يمكن تغييره لاحقاً).
  final String lookupHost;

  /// لتقليل تردد الفحوصات عند تذبذب الشبكة (خصوصاً على Android).
  final Duration debounce;

  StreamSubscription<List<ConnectivityResult>>? _sub;
  final _controller = StreamController<bool>.broadcast();
  bool? _last;
  Timer? _debounceTimer;

  /// بث متواصل لحالة الاتصال: true/false.
  /// يبدأ أول مرة عند أول استماع.
  Stream<bool> get connectionStream {
    _ensureStarted();
    return _controller.stream;
  }

  /// يبث فقط عند التحول إلى Online (true).
  Stream<bool> get onOnline => connectionStream.where((v) => v);

  /// فحص إنترنت فعلي (DNS lookup).
  Future<bool> isOnline({Duration timeout = const Duration(seconds: 2)}) async {
    try {
      final lookup = await InternetAddress.lookup(lookupHost).timeout(timeout);
      return lookup.isNotEmpty && lookup.first.rawAddress.isNotEmpty;
    } on Exception {
      return false;
    }
  }

  void _ensureStarted() {
    if (_sub != null) return;

    // التحقق الأولي مرة واحدة
    () async {
      final results = await _connectivity.checkConnectivity();
      await _handleConnectivityResults(results);
    }();

    _sub = _connectivity.onConnectivityChanged.listen((results) {
      // Debounce: بعض الأجهزة تبعث أحداث كثيرة متتالية
      _debounceTimer?.cancel();
      _debounceTimer = Timer(debounce, () async {
        await _handleConnectivityResults(results);
      });
    });
  }

  Future<void> _handleConnectivityResults(List<ConnectivityResult> results) async {
    final hasNetwork = _hasAnyConnection(results);
    if (!hasNetwork) {
      _emitIfChanged(false);
      return;
    }

    // يوجد شبكة (Wifi/Mobile) => نتأكد من وجود إنترنت فعلي
    final online = await isOnline();
    _emitIfChanged(online);
  }

  bool _hasAnyConnection(List<ConnectivityResult> results) {
    return results.any((r) => r != ConnectivityResult.none);
  }

  void _emitIfChanged(bool value) {
    if (_last == value) return;
    _last = value;
    if (!_controller.isClosed) {
      _controller.add(value);
    }
  }

  Future<void> dispose() async {
    _debounceTimer?.cancel();
    _debounceTimer = null;
    await _sub?.cancel();
    _sub = null;
    await _controller.close();
  }
}
