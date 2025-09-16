import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../riverpod/confirm_order_riverpod.dart';
import 'address_card_to_confirm_the_order_widget.dart';

class ListOfAddressesToConfirmTheOrderWidget extends ConsumerStatefulWidget {
  final FormGroup form;

  const ListOfAddressesToConfirmTheOrderWidget({
    super.key,
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
    var state = ref.watch(getConfirmOrderDataProvider);

    return Flexible(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: state.data.userAddresses.length,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          itemBuilder: (context, index) {
            return AddressCardToConfirmTheOrderWidget(
              address: state.data.userAddresses[index].address,
              city: state.data.userAddresses[index].city!.name.toString(),
              addressGroupValue:
                  widget.form.control('address_id').value.toString(),
              district:
                  state.data.userAddresses[index].district!.name.toString(),
              value: state.data.userAddresses[index].id.toString(),
              onPressed: () {
                setState(() {
                  widget.form.control('address_id').value =
                      state.data.userAddresses[index].id;
                  widget.form.control('address').value =
                      state.data.userAddresses[index].address;
                  widget.form.control('district').value =
                      "${state.data.userAddresses[index].city!.name} - ${state.data.userAddresses[index].district!.name} ";
      
                  ref.refresh(confirmOrderProvider.notifier);
                });
                Navigator.of(context).pop();
              },
            );
          }),
    );
  }
}
