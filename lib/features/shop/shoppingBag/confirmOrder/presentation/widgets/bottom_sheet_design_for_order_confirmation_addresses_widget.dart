import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../address/data/model/address_model.dart';
import '../../../../address/presentation/pages/add_or_update_address_page.dart';
import '../riverpod/confirm_order_riverpod.dart';
import 'list_of_addresses_to_confirm_the_order_widget.dart';

class BottomSheetDesignForOrderConfirmationAddressesWidget
    extends ConsumerWidget {
  final FormGroup form;

  const BottomSheetDesignForOrderConfirmationAddressesWidget({
    super.key,
    required this.form,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 11.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListOfAddressesToConfirmTheOrderWidget(
            form: form,
          ),
          8.h.verticalSpace,
          DefaultButtonWidget(
            text: S.of(context).addANewAddress,
            textSize: 12.6.sp,
            onPressed: () {
              navigateTo(
                context,
                AddOrUpdateAddressPage(
                  address: AddressModel.empty(),
                  onSuccess: () {
                    ref.refresh(getConfirmOrderDataProvider);
                    Navigator.of(context).pop();
                  },
                  locationIsEmpty: true,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
