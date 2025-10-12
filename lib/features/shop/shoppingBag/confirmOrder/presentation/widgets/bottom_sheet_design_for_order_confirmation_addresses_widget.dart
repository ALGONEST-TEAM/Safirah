import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../address/data/model/address_model.dart';
import '../../../../address/presentation/pages/add_or_update_address_page.dart';
import '../../../cart/data/model/cart_model.dart';
import '../riverpod/confirm_order_riverpod.dart';
import 'list_of_addresses_to_confirm_the_order_widget.dart';

class BottomSheetDesignForOrderConfirmationAddressesWidget
    extends ConsumerWidget {
  final List<CartModel> products;
  final List<AddressModel> address;

  final FormGroup form;

  const BottomSheetDesignForOrderConfirmationAddressesWidget({
    super.key,
    required this.products,
    required this.address,
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
            address: address,
            form: form,
          ),
          8.h.verticalSpace,
          DefaultButtonWidget(
            text: S.of(context).addANewAddress,
            withIcon: true,
            icon: AppIcons.plus,
            textSize: 12.4.sp,
            onPressed: () {
              navigateTo(
                context,
                AddOrUpdateAddressPage(
                  address: AddressModel.empty(),
                  onSuccess: () {
                    ref
                        .refresh(fetchOrderConfirmationDataProvider.notifier)
                        .getData(products: products, mode: FetchMode.refresh);
                    Navigator.of(context).pop();
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
