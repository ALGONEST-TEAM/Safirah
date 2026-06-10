import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/auto_size_text_widget.dart';
import '../../data/model/payment_methods_model.dart';
import '../riverpod/payment_riverpod.dart';
import 'list_of_pay_method_widget.dart';

class PaymentMethodsSectionWidget extends ConsumerStatefulWidget {
  final String title;
  final ValueChanged<PaymentMethodsModel>? onMethodSelected;
  final bool excludeCashOnDelivery;
  final VoidCallback? onPaymentMethodCleared;

  const PaymentMethodsSectionWidget({
    super.key,
    required this.title,
    this.onMethodSelected,
    this.excludeCashOnDelivery = false,
    this.onPaymentMethodCleared,
  });

  @override
  ConsumerState<PaymentMethodsSectionWidget> createState() =>
      _PaymentMethodsSectionWidgetState();
}

class _PaymentMethodsSectionWidgetState
    extends ConsumerState<PaymentMethodsSectionWidget> {
  static const _cashOnDeliveryMethodName = 'cash_on_delivery';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _clearCashOnDeliverySelectionIfNeeded();
    });
  }

  @override
  void didUpdateWidget(covariant PaymentMethodsSectionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.excludeCashOnDelivery != oldWidget.excludeCashOnDelivery) {
      _clearCashOnDeliverySelectionIfNeeded();
    }
  }

  void _clearCashOnDeliverySelectionIfNeeded() {
    if (!widget.excludeCashOnDelivery) return;

    final selectedMethod = ref.read(selectedPayMethodProvider);
    if (selectedMethod?.name != _cashOnDeliveryMethodName) return;

    ref.read(selectedPayMethodProvider.notifier).state = null;
    ref.read(selectedPayMethodErrorProvider.notifier).state = null;
    widget.onPaymentMethodCleared?.call();
  }

  List<PaymentMethodsModel> _visiblePaymentMethods(
    List<PaymentMethodsModel> paymentMethods,
  ) {
    if (!widget.excludeCashOnDelivery) return paymentMethods;

    return paymentMethods
        .where((method) => method.name != _cashOnDeliveryMethodName)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final payState = ref.watch(getAllPaymentMethodsProvider);
    final errorMessage = ref.watch(selectedPayMethodErrorProvider);
    final visiblePaymentMethods = _visiblePaymentMethods(payState.data);

    return CheckStateInGetApiDataWidget(
      state: payState,
      refresh: () {
        ref.invalidate(getAllPaymentMethodsProvider);
      },
      widgetOfData: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(
              text: widget.title,
              fontSize: 11.sp,
            ),
            8.h.verticalSpace,
            if (errorMessage != null)
              Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: AutoSizeTextWidget(
                  text: errorMessage,
                  fontSize: 10.sp,
                  colorText: AppColors.dangerColor,
                ),
              ),
            ListOfPaymentMethodWidget(
              paymentData: visiblePaymentMethods,
              onMethodSelected: widget.onMethodSelected,
            ),
          ],
        ),
      ),
      widgetOfLoading: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeTextWidget(
              text: widget.title,
              fontSize: 11.sp,
            ),
            14.h.verticalSpace,
            const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


