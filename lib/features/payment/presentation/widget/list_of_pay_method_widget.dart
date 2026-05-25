import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/payment_methods_model.dart';
import '../riverpod/payment_riverpod.dart';
import 'pay_method_card_widget.dart';

class ListOfPaymentMethodWidget extends ConsumerWidget {
  final List<PaymentMethodsModel> paymentData;
  final ValueChanged<PaymentMethodsModel>? onMethodSelected;

  const ListOfPaymentMethodWidget({
    super.key,
    required this.paymentData,
    this.onMethodSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPayMethod = ref.watch(selectedPayMethodProvider);

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: paymentData.length,
      padding: EdgeInsets.symmetric(vertical: 4.h),
      itemBuilder: (context, index) {
        final method = paymentData[index];
        return PayMethodCardWidget(
          name: method.title,
          value: method.id.toString(),
          paymentMethodGroupValue: selectedPayMethod?.id.toString() ?? '',
          image: method.image ?? '',
          onPressed: () {
            ref.read(selectedPayMethodProvider.notifier).state = method;
            ref.read(selectedPayMethodErrorProvider.notifier).state = null;
            onMethodSelected?.call(method);
          },
        );
      },
      separatorBuilder: (context, index) => 10.h.verticalSpace,
    );
  }
}

