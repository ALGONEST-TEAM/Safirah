import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/bottomNavbar/button_bottom_navigation_bar_design_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../../core/widgets/text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../cart/data/model/cart_model.dart';
import '../riverpod/confirm_order_riverpod.dart';
import '../widgets/address_to_confirm_the_order_widget.dart';
import '../widgets/bill_widget.dart';
import '../../../../../../core/widgets/general_design_for_order_details_widget.dart';
import '../widgets/list_of_payment_method_widget.dart';
import '../widgets/list_of_shipping_methods_widget.dart';
import '../widgets/order_confirmation_product_card_widget.dart';
import '../widgets/order_success_dialog_widget.dart';
import '../widgets/required_inputs_widget.dart';

class ConfirmOrderPage extends ConsumerWidget {
  final List<CartModel> products;

  ConfirmOrderPage({super.key, required this.products});

  final TextEditingController couponCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    var confirmOrderState = ref.watch(confirmOrderProvider);
    final ctrl = ref.read(fetchOrderConfirmationDataProvider.notifier);
    final state = ref.watch(fetchOrderConfirmationDataProvider);

    var shippingPrice;
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).confirmOrder),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: ReactiveFormBuilder(
            form: () => ConfirmOrderController.form.group,
            builder: (context, form, child) {
              shippingPrice = form.value['shipping_price'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddressToConfirmTheOrderWidget(
                    products: products,
                    address: state.data.userAddresses,
                    form: form,
                  ),
                  GeneralDesignForOrderDetailsWidget(
                    title: S.of(context).paymentMethod,
                    child: ListOfPaymentMethodWidget(
                      payMethods: state.data.paymentMethods,
                      form: form,
                    ),
                  ),
                  RequiredInputsWidget(
                    form: form,
                    value: 'payment_method',
                    requiredText: S.of(context).pleaseChoseAPaymentMethod,
                  ),
                  GeneralDesignForOrderDetailsWidget(
                    title: S.of(context).shippingMethod,
                    child: ListOfShippingMethodsWidget(
                      deliveryTypes: state.data.deliveryTypes,
                      form: form,
                    ),
                  ),
                  RequiredInputsWidget(
                    form: form,
                    value: 'shipping_method_id',
                    requiredText: S.of(context).pleaseChoseAShippingMethod,
                  ),
                  GeneralDesignForOrderDetailsWidget(
                    title: S.of(context).haveACouponOrDiscountVoucher,
                    child: TextFormFieldWidget(
                      controller: couponCodeController,
                      textAlign: TextAlign.center,
                      hintText: "xxx - xxx",
                      fillColor: AppColors.scaffoldColor,
                      suffixIcon: CheckStateInPostApiDataWidget(
                        state: state,
                        messageSuccess: S.of(context).couponVerificationSuccess,
                        functionSuccess: () {},
                        hasMessageSuccess:
                            ctrl.lastMode == FetchMode.coupon ? true : false,
                        bottonWidget: DefaultButtonWidget(
                          text: S.of(context).verify,
                          width: 58.w,
                          textSize: 10.sp,
                          height: 30.h,
                          minFontSize: 6,
                          background: AppColors.primaryColor,
                          isLoading: state.stateData == States.loading &&
                              ctrl.lastMode == FetchMode.coupon,
                          onPressed: () {
                            if (products.isEmpty) {
                              return;
                            }
                            ctrl.getData(
                              products: products,
                              couponCode: couponCodeController.text,
                              mode: FetchMode.coupon,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  4.h.verticalSpace,
                  Column(
                    children: state.data.products.map((items) {
                      final needs = (items.isPrintable ?? 0) != 0;
                      final ctrl =
                          needs ? ref.watch(printCtrlProvider(items.id)) : null;
                      return OrderConfirmationProductCardWidget(
                        data: items,
                        printableController: ctrl,
                      );
                    }).toList(),
                  ),
                  BillWidget(
                    deliveryCost: shippingPrice ?? 0,
                    billData: state.data.billData!,
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: ButtonBottomNavigationBarDesignWidget(
        child: CheckStateInPostApiDataWidget(
          state: confirmOrderState,
          hasMessageSuccess: false,
          functionSuccess: () {
            CompleteOrder.successDialog(context, ref);
          },
          bottonWidget: DefaultButtonWidget(
            text: S.of(context).confirmOrder,
            height: 41.h,
            isLoading: confirmOrderState.stateData == States.loading,
            onPressed: () {
              final notifier = ref.read(confirmOrderProvider.notifier);

              if (!notifier.validateAndNotify(context)) return;

              final isValid = _formKey.currentState!.validate();
              if (!isValid) {
                showFlashBarWarring(
                    context: context,
                    message: S.of(context).pleaseEnterProductPrintDescription);
              } else {
                FocusManager.instance.primaryFocus?.unfocus();
                notifier.confirmOrder(
                  context: context,
                  cart: state.data.products,
                  copon: couponCodeController.text,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
