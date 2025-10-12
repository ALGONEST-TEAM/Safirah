import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../data/model/payment_methods_model.dart';
import '../riverpod/confirm_order_riverpod.dart';
import 'payment_method_widget.dart';

class ListOfPaymentMethodWidget extends ConsumerStatefulWidget {
  final List<PaymentMethodsModel> payMethods;

  final FormGroup form;

  const ListOfPaymentMethodWidget({
    super.key,
    required this.payMethods,
    required this.form,
  });

  @override
  ConsumerState<ListOfPaymentMethodWidget> createState() =>
      _ListOfPaymentMethodWidgetState();
}

class _ListOfPaymentMethodWidgetState
    extends ConsumerState<ListOfPaymentMethodWidget> {
  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.payMethods.length,
      padding: EdgeInsets.symmetric(vertical: 4.h),
      itemBuilder: (context, index) {
        return PaymentMethodWidget(
          name: widget.payMethods[index].name,
          value: widget.payMethods[index].id.toString(),
          paymentMethodGroupValue:
              widget.form.control('payment_method').value.toString(),
          onPressed: () {
            setState(() {
              widget.form.control('payment_method').value =
                  widget.payMethods[index].id;
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
