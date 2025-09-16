import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PaginationHelper {
  final ScrollController scrollController;
  final WidgetRef ref;

  final Future<void> Function() onLoadMoreData; // دالة لتحميل البيانات
  bool _isLoading = false;
  Timer? _debounce;

  PaginationHelper({
    required this.scrollController,
    required this.ref,
    required this.onLoadMoreData,  // تمرير دالة تحميل البيانات هنا
  });

  void dispose() {
    _debounce?.cancel();
  }

  void onScrollForPagination() {
    if (!_isMounted()) return;

    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), _handleScroll);
  }

  void _handleScroll() async {
    if (!_isMounted()) return;

    final scrollPosition = scrollController.position.pixels;
    final maxScrollExtent = scrollController.position.maxScrollExtent;

    if (scrollPosition >= maxScrollExtent * 0.9) {
      if (!_isLoading) {
        _setLoadingState(true);
        try {
          // استدعاء الدالة الممررة لتحميل البيانات من الخارج
          await onLoadMoreData();
        } catch (e) {
          print("Error loading data: $e");
        } finally {
          _setLoadingState(false);
        }
      }
    }
  }

  bool _isMounted() {
    return scrollController.hasClients && ref.context.mounted;
  }

  void _setLoadingState(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
    }
  }
}
