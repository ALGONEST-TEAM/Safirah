import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../address/data/model/address_model.dart';
import '../../../../../payment/presentation/riverpod/payment_riverpod.dart';
import 'address_card_to_confirm_the_order_widget.dart';

class ListOfAddressesToConfirmTheOrderWidget extends ConsumerStatefulWidget {
  final List<AddressModel> address;
  final FormGroup form;

  const ListOfAddressesToConfirmTheOrderWidget({
    super.key,
    required this.address,

    required this.form,
  });

  @override
  ConsumerState<ListOfAddressesToConfirmTheOrderWidget> createState() =>
      _ListOfAddressesToConfirmTheOrderWidgetState();
}

class _ListOfAddressesToConfirmTheOrderWidgetState
    extends ConsumerState<ListOfAddressesToConfirmTheOrderWidget> {
  @override
  Widget build(BuildContext context) {

    return Flexible(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.address.length,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          itemBuilder: (context, index) {
            return AddressCardToConfirmTheOrderWidget(
              address: widget.address[index].address,
              city: widget.address[index].city!.name.toString(),
              addressGroupValue:
                  widget.form.control('address_id').value.toString(),
              district:
              widget.address[index].district!.name.toString(),
              value: widget.address[index].id.toString(),
              onPressed: () {
                final selectedAddress = widget.address[index];
                final currentAddressId =
                    widget.form.control('address_id').value as int?;
                final hasAddressChanged = currentAddressId != selectedAddress.id;

                widget.form.control('address_id').updateValue(selectedAddress.id);
                widget.form
                    .control('address')
                    .updateValue(selectedAddress.address);
                widget.form
                    .control('district')
                    .updateValue(selectedAddress.district!.name);
                widget.form
                    .control('city_name')
                    .updateValue(selectedAddress.city!.name);

                if (hasAddressChanged) {
                  widget.form.control('shipping_method_id').reset();
                  widget.form.control('shipping_price').reset();
                }

                refreshPaymentExecutionState(ref);
                Navigator.of(context).pop();
              },
            );
          }),
    );
  }
}
