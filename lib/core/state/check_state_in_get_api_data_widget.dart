import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helpers/flash_bar_helper.dart';
import '../network/errors/app_exception_message.dart';
import '../state/state.dart';
import '../theme/app_colors.dart';
import '../widgets/error_widget.dart';
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
    print(state.stateData);

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

class CheckStateInStreamWidget<T> extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // previous data if exists (Riverpod keeps last AsyncData in some transitions)
    final previousData = async.asData?.value;

    // 1) LOADING
    if (async.isLoading) {
      if (keepPreviousDataWhileLoading && previousData != null) {
        // show old data + small loader
        return Stack(
          children: [
            _buildDataOrEmpty(previousData),
            const _TopLoader(),
          ],
        );
      }

      return loadingWidget ??
          const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          );
    }

    // 2) ERROR
    if (async.hasError) {
      final error = async.error;

      // ✅ قاعدة إلزامية: إذا عندك بيانات قديمة -> FlashBar فقط + اعرض البيانات القديمة
      if (previousData != null) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          showFlashBarError(
            context: context,
            title: MessageOfError.get(error as Object).first,
            text: MessageOfError.get(error as Object).last,
          );
        });

        return _buildDataOrEmpty(previousData);
      }

      // إذا لا توجد بيانات قديمة: اعرض Error Widget مع زر refresh (إن توفر)
      return Center(
        child: ErrorsWidget(
          title: MessageOfError.get(error as Object).first,
          subTitle: MessageOfError.get(error as Object).last,
          onPressed: onRefresh == null ? null : () => onRefresh!(),
        ),
      );
    }

    // 3) DATA
    final data = async.asData!.value;
    return _buildDataOrEmpty(data);
  }

  Widget _buildDataOrEmpty(T data) {
    if (isEmpty(data)) {
      return emptyBuilder?.call() ?? const SizedBox.shrink();
    }
    return dataBuilder(data);
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
