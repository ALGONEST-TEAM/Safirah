import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../riverpod/confirm_order_riverpod.dart';
import 'payment_method_widget.dart';

class ListOfPaymentMethodWidget extends ConsumerStatefulWidget {
  final FormGroup form;

  const ListOfPaymentMethodWidget({super.key, required this.form});

  @override
  ConsumerState<ListOfPaymentMethodWidget> createState() =>
      _ListOfPaymentMethodWidgetState();
}

class _ListOfPaymentMethodWidgetState
    extends ConsumerState<ListOfPaymentMethodWidget> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(getConfirmOrderDataProvider);

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.data.paymentMethods.length,
      padding: EdgeInsets.symmetric(vertical: 4.h),
      itemBuilder: (context, index) {
        return PaymentMethodWidget(
          name: state.data.paymentMethods[index].name,
          value: state.data.paymentMethods[index].id.toString(),
          paymentMethodGroupValue:
              widget.form.control('payment_method').value.toString(),
          onPressed: () {
            setState(() {
              widget.form.control('payment_method').value =
                  state.data.paymentMethods[index].id;
              ref.refresh(confirmOrderProvider.notifier);
            });
          },
        );
      },
      separatorBuilder: (context, index) => Divider(
        color: AppColors.fontColor.withOpacity(.4),
        thickness: 0.7,
        height: 12.h,
      ),
    );
  }
}
