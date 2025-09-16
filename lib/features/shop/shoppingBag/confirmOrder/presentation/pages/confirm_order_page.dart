import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/bottomNavbar/button_bottom_navigation_bar_design_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../../core/widgets/skeletonizer_widget.dart';
import '../../../../../../core/widgets/text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../../../cart/presentation/riverpod/cart_riverpod.dart';
import '../../data/model/check_copon_model.dart';
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
  ConfirmOrderPage({super.key});

  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    var confirmOrderState = ref.watch(confirmOrderProvider);
    var getConfirmOrderDataState = ref.watch(getConfirmOrderDataProvider);
    var checkCoponState = ref.watch(checkCoponProvider);
    var cartState = ref.watch(cartProvider.notifier);
    var formData;
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).confirmOrder),
      body: CheckStateInGetApiDataWidget(
        state: getConfirmOrderDataState,
        widgetOfData: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: ReactiveFormBuilder(
            form: () => ConfirmOrderController.form.group,
            builder: (context, form, child) {
              formData = form.value['shipping_method_id'];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddressToConfirmTheOrderWidget(
                    form: form,
                  ),
                  RequiredInputsWidget(
                    form: form,
                    value: 'payment_method',
                    requiredText: S.of(context).pleaseChoseAPaymentMethod,
                  ),
                  GeneralDesignForOrderDetailsWidget(
                    title: S.of(context).paymentMethod,
                    child: ListOfPaymentMethodWidget(
                      form: form,
                    ),
                  ),
                  RequiredInputsWidget(
                    form: form,
                    value: 'shipping_method_id',
                    requiredText: S.of(context).pleaseChoseAShippingMethod,
                  ),
                  GeneralDesignForOrderDetailsWidget(
                    title: S.of(context).shippingMethod,
                    child: ListOfShippingMethodsWidget(
                      form: form,
                    ),
                  ),
                  GeneralDesignForOrderDetailsWidget(
                    title: S.of(context).haveACouponOrDiscountVoucher,
                    child: TextFormFieldWidget(
                      controller: noteController,
                      textAlign: TextAlign.center,
                      hintText: "xxx - xxx",
                      fillColor: AppColors.scaffoldColor,
                      suffixIcon: CheckStateInPostApiDataWidget(
                          state: checkCoponState,
                          messageSuccess: 'تمت عملية التحقق من الكوبون بنجاح',
                          functionSuccess: () {},
                          hasMessageSuccess: true,
                          bottonWidget: DefaultButtonWidget(
                            text: 'تحقق',
                            width: 58.w,
                            textSize: 10.sp,
                            height: 30.h,
                            minFontSize: 6,
                            background: AppColors.primaryColor,
                            isLoading:
                                checkCoponState.stateData == States.loading,
                            onPressed: () {
                              CheckCoponModel copon = CheckCoponModel(
                                cartProducts: cartState.selectedProducts,
                                codeCopon: noteController.text,
                              );
                              ref
                                  .read(checkCoponProvider.notifier)
                                  .getData(copon: copon);
                            },
                          )),
                    ),
                  ),
                  4.h.verticalSpace,
                  Visibility(
                    visible: checkCoponState.stateData != States.loading,
                    replacement: Column(
                      children: cartState.selectedProducts.map((items) {
                        return SkeletonizerWidget(
                            child: OrderConfirmationProductCardWidget(
                          data: items,
                          isCheckCopon: true,
                          productInCopon: true,
                        ));
                      }).toList(),
                    ),
                    child: Visibility(
                      visible: checkCoponState.data.status == true,
                      replacement: Column(
                        children: cartState.selectedProducts.map((items) {
                          return OrderConfirmationProductCardWidget(
                            data: items,
                            isCheckCopon: false,
                            productInCopon: false,
                          );
                        }).toList(),
                      ),
                      child: Column(
                        children: checkCoponState.data.discountProductData!
                            .map((items) {
                          return OrderConfirmationProductCardWidget(
                            data: items,
                            isCheckCopon: checkCoponState.data.status ?? false,
                            productInCopon: items.hasCopon ?? false,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: checkCoponState.stateData != States.loading,
                    replacement: SkeletonizerWidget(
                      child: BillWidget(
                        deliveryCost: formData == 2 ? 2000 : 800,
                        total: cartState.calculateSelectedTotalPrice(),
                        hasCopon: false,
                        coponValue: 0,
                        totalAfterDiscount: 0,
                      ),
                    ),
                    child: Visibility(
                      visible: checkCoponState.data.status == true,
                      replacement: BillWidget(
                        deliveryCost: formData == 2 ? 2000 : 800,
                        hasCopon: false,
                        total: cartState.calculateSelectedTotalPrice(),
                        totalAfterDiscount:
                            cartState.calculateSelectedTotalPrice() +
                                (formData == 2 ? 2000 : 800),
                        coponValue: 0,
                      ),
                      child: BillWidget(
                        hasCopon: true,
                        deliveryCost: formData == 2 ? 2000 : 800,
                        coponValue: double.tryParse(
                            checkCoponState.data.discountTotal.toString())!,
                        totalAfterDiscount: double.tryParse(checkCoponState
                                .data.orderTotalAfterDiscount
                                .toString()) ??
                            cartState.calculateSelectedTotalPrice() +
                                (formData == 2 ? 2000 : 800),
                        total: cartState.calculateSelectedTotalPrice(),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: getConfirmOrderDataState.stateData == States.loaded
          ? ButtonBottomNavigationBarDesignWidget(
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
                    ref.read(confirmOrderProvider.notifier).confirmOrder(
                          cart: cartState.selectedProducts,
                          note: noteController.text,
                          unitPrice: cartState
                              .calculateSelectedTotalPrice()
                              .toString(),
                        );
                  },
                ),
              ),
            )
          : null,
    );
  }
}
