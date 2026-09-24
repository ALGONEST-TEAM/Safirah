import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helpers/flash_bar_helper.dart';
import '../network/errors/app_exception_message.dart';
import '../state/state.dart';
import '../theme/app_colors.dart';
import '../widgets/error_widget.dart';
import '../widgets/logo_shimmer_widget.dart';
import 'data_state.dart';

class CheckStateInGetApiDataWidget extends StatelessWidget {
  final Widget? widgetOfData;
  final Widget? widgetOfLoading;
  final VoidCallback? refresh;
  final DataState state;
  final bool errorMessage;

  const CheckStateInGetApiDataWidget({
    super.key,
    required this.state,
    this.widgetOfData,
    this.widgetOfLoading,
    this.refresh,
    this.errorMessage = false,
  });

  @override
  Widget build(BuildContext context) {
    // NOTE: Avoid spamming logs on rebuilds.
    // print(state.stateData);

    if (state.stateData == States.loaded ||
        state.stateData == States.loadingMore) {
      return widgetOfData!;
    } else if (state.stateData == States.error) {
      if (errorMessage) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          showFlashBarError(
            context: context,
            title: MessageOfError.get(state.exception as Object).first,
            text: MessageOfError.get(state.exception as Object).last,
          );
          state.stateData = States.initial;
        });
      } else {
        return Center(
          child: ErrorsWidget(
            title: MessageOfError.get(state.exception as Object).first,
            subTitle: MessageOfError.get(state.exception as Object).last,
            onPressed: refresh,
          ),
        );
      }
    } else if (state.stateData == States.loading) {
      return widgetOfLoading ??
          const Center(
              child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ));
    } else {
      return const SizedBox();
    }
    return const SizedBox();
  }
}

class CheckStateInStreamWidget<T> extends StatefulWidget {
  /// async value from StreamProvider / FutureProvider
  final AsyncValue<T> async;

  /// build UI when data exists
  final Widget Function(T data) dataBuilder;

  /// optional empty widget builder (if data is "empty")
  final Widget Function()? emptyBuilder;

  /// optional refresh callback
  final Future<void> Function()? onRefresh;

  /// optional loader widget
  final Widget? loadingWidget;

  /// define emptiness for T (because generic)
  final bool Function(T data) isEmpty;

  /// keep previous data while loading
  final bool keepPreviousDataWhileLoading;

  const CheckStateInStreamWidget({
    super.key,
    required this.async,
    required this.dataBuilder,
    required this.isEmpty,
    this.emptyBuilder,
    this.onRefresh,
    this.loadingWidget,
    this.keepPreviousDataWhileLoading = true,
  });

  @override
  State<CheckStateInStreamWidget<T>> createState() =>
      _CheckStateInStreamWidgetState<T>();
}

class _CheckStateInStreamWidgetState<T>
    extends State<CheckStateInStreamWidget<T>> {
  T? _lastValidData;

  @override
  void initState() {
    super.initState();
    _captureValidData(widget.async);
  }

  @override
  void didUpdateWidget(covariant CheckStateInStreamWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _captureValidData(widget.async);
  }

  void _captureValidData(AsyncValue<T> async) {
    final current = async.asData?.value;
    if (current != null && !widget.isEmpty(current)) {
      _lastValidData = current;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ✅ الاحتفاظ بالبيانات السابقة لتجنب أي وميض (Flicker) أثناء إعادة الجلب أو التحميل
    final current = widget.async.asData?.value;
    final hasValidCurrent = current != null && !widget.isEmpty(current);
    final previousData = hasValidCurrent
        ? current
        : (widget.keepPreviousDataWhileLoading && _lastValidData != null
            ? _lastValidData
            : current);

    // 1) LOADING
    if (widget.async.isLoading) {
      if (widget.keepPreviousDataWhileLoading && previousData != null) {
        // عرض البيانات القديمة مع مؤشر تحميل خفيف بأعلى الصفحة دون وميض
        return Stack(
          children: [
            _buildDataOrEmpty(previousData),
            const _TopLoader(),
          ],
        );
      }

      return widget.loadingWidget ??
          const Center(
            child: LogoShimmerWidget(),
          );
    }

    // 2) ERROR
    if (widget.async.hasError) {
      final error = widget.async.error;
      final safeError = error ?? Exception('Unknown error');

      // ✅ قاعدة إلزامية: إذا توفرت بيانات سابقة -> FlashBar فقط مع استمرار عرض البيانات
      if (previousData != null) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          showFlashBarError(
            context: context,
            title: MessageOfError.get(safeError).first,
            text: MessageOfError.get(safeError).last,
          );
        });

        return _buildDataOrEmpty(previousData);
      }

      // إذا لا توجد بيانات قديمة: اعرض Error Widget مع زر refresh (إن توفر)
      return Center(
        child: ErrorsWidget(
          title: MessageOfError.get(safeError).first,
          subTitle: MessageOfError.get(safeError).last,
          onPressed: widget.onRefresh == null ? null : () => widget.onRefresh!(),
        ),
      );
    }

    // 3) DATA
    final data = hasValidCurrent ? current : (previousData ?? current);
    if (data != null) {
      return _buildDataOrEmpty(data);
    }

    return widget.loadingWidget ??
        const Center(
          child: LogoShimmerWidget(),
        );
  }

  Widget _buildDataOrEmpty(T data) {
    if (widget.isEmpty(data)) {
      if (widget.emptyBuilder != null) return widget.emptyBuilder!.call();

      const content = Center(child: Text('لا توجد بيانات'));

      if (widget.onRefresh != null) {
        return RefreshIndicator(
          onRefresh: widget.onRefresh!,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: const [SizedBox(height: 280), content],
          ),
        );
      }

      return content;
    }

    if (widget.onRefresh != null) {
      return RefreshIndicator(
        onRefresh: widget.onRefresh!,
        child: widget.dataBuilder(data),
      );
    }

    return widget.dataBuilder(data);
  }
}

class _TopLoader extends StatelessWidget {
  const _TopLoader();

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      top: 12,
      left: 0,
      right: 0,
      child: Center(
        child: SizedBox(
          height: 28,
          width: 28,
          child: CircularProgressIndicator(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
