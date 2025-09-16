import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../riverpod/confirm_order_riverpod.dart';
import 'design_of_shipping_method_data_widget.dart';

class ListOfShippingMethodsWidget extends ConsumerStatefulWidget {
  final FormGroup form;

  const ListOfShippingMethodsWidget({super.key, required this.form});

  @override
  ConsumerState<ListOfShippingMethodsWidget> createState() =>
      _ListOfShippingMethodsWidgetState();
}

class _ListOfShippingMethodsWidgetState
    extends ConsumerState<ListOfShippingMethodsWidget> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(getConfirmOrderDataProvider);
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: state.data.deliveryTypes.length,
      itemBuilder: (context, index) {
        return DesignOfShippingMethodDataWidget(
          title: state.data.deliveryTypes[index].name,
          value: state.data.deliveryTypes[index].id.toString(),
          shippingMethodGroupValue:
              widget.form.control('shipping_method_id').value.toString(),
          onPressed: () {
            setState(() {
              widget.form.control('shipping_method_id').value =
                  state.data.deliveryTypes[index].id;
              print(widget.form.control('shipping_method_id').value);

              ref.refresh(confirmOrderProvider.notifier);
            });
          },
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 4.h),
    );
  }
}
