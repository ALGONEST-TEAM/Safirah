import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:safirah/core/theme/app_colors.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../address/data/model/address_model.dart';
import '../../../cart/data/model/cart_model.dart';
import 'bottom_sheet_design_for_order_confirmation_addresses_widget.dart';
import '../../../../../../core/widgets/general_design_for_order_details_widget.dart';
import 'required_inputs_widget.dart';

class AddressToConfirmTheOrderWidget extends StatelessWidget {
  final List<CartModel> products;
  final List<AddressModel> address;
  final FormGroup form;
  final VoidCallback? onSelectionChanged;

  const AddressToConfirmTheOrderWidget({
    super.key,
    required this.products,
    required this.address,
    required this.form,
    this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: StreamBuilder<Object?>(
            stream: form.control('address').valueChanges,
            initialData: form.control('address').value,
            builder: (context, snapshot) {
              return StreamBuilder<Object?>(
                stream: form.control('city_name').valueChanges,
                initialData: form.control('city_name').value,
                builder: (context, snapshot) {
                  return StreamBuilder<Object?>(
                    stream: form.control('district').valueChanges,
                    initialData: form.control('district').value,
                    builder: (context, snapshot) {
                      final addressValue =
                          (form.control('address').value as String?)?.trim() ??
                              '';
                      final cityName = (form.control('city_name').value
                                  as String?)
                              ?.trim() ??
                          '';
                      final district = (form.control('district').value
                                  as String?)
                              ?.trim() ??
                          '';
                      final locationSummary = [cityName, district]
                          .where((item) => item.isNotEmpty)
                          .join(' - ');

                      return GeneralDesignForOrderDetailsWidget(
                        title: S.of(context).deliveryAddress,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              AppIcons.deliveryAddress,
                              height: 44.h,
                            ),
                            8.w.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  AutoSizeTextWidget(
                                    text: addressValue.isEmpty
                                        ? S.of(context).address
                                        : addressValue,
                                    fontSize: 12.4.sp,
                                    colorText: AppColors.mainColorFont,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  if (locationSummary.isNotEmpty) ...[
                                    4.h.verticalSpace,
                                    AutoSizeTextWidget(
                                      text: locationSummary,
                                      fontSize: 10.4.sp,
                                      colorText: AppColors.fontColor2,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              AppIcons.arrowLeft,
                              height: 16.h,
                            ),
                            4.w.horizontalSpace,
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
          onTap: () async {
            await scrollShowModalBottomSheetWidget(
              context: context,
              title: S.of(context).yourAddress,
              page: BottomSheetDesignForOrderConfirmationAddressesWidget(
                products: products,
                address: address,
                form: form,
              ),
            );

            if (!context.mounted) return;
            onSelectionChanged?.call();
          },
        ),
        RequiredInputsWidget(
          form: form,
          value: 'address',
          requiredText: S.of(context).addressIsRequired,
        ),
      ],
    );
  }
}
