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
import '../../../../../../services/auth/auth.dart';
import '../../../../../payment/data/model/payment_request_context_model.dart';
import '../../../../../payment/presentation/riverpod/payment_riverpod.dart';
import '../../../../../payment/presentation/widget/payment_action_button_widget.dart';
import '../../../../../payment/presentation/widget/payment_methods_section_widget.dart';
import '../../../cart/data/model/cart_model.dart';
import '../../data/model/confirm_order_model.dart';
import '../riverpod/confirm_order_riverpod.dart';
import '../widgets/address_to_confirm_the_order_widget.dart';
import '../widgets/bill_widget.dart';
import '../../../../../../core/widgets/general_design_for_order_details_widget.dart';
import '../widgets/list_of_shipping_methods_widget.dart';
import '../widgets/order_confirmation_product_card_widget.dart';
import '../widgets/order_success_dialog_widget.dart';
import '../widgets/required_inputs_widget.dart';

class ConfirmOrderPage extends ConsumerStatefulWidget {
  final List<CartModel> products;

  const ConfirmOrderPage({super.key, required this.products});

  @override
  ConsumerState<ConfirmOrderPage> createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends ConsumerState<ConfirmOrderPage> {
  final TextEditingController couponCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _confirmOrderController = ConfirmOrderController();

  String _normalizeLocalPhone(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.startsWith('967') && digits.length > 9) {
      return digits.substring(digits.length - 9);
    }
    return digits;
  }

  String? _validatePhone(BuildContext context, String? value) {
    final phone = _normalizeLocalPhone(value ?? '');
    if (phone.isEmpty) {
      return 'قم بإدخال رقم الهاتف';
    }
    if (phone.length < 9) {
      return S.of(context).phoneMustBe9Digits;
    }
    if (!phone.startsWith('7')) {
      return S.of(context).phoneMustStartWith7;
    }
    return null;
  }

  ConfirmOrderModel _buildConfirmOrderModel({
    required List<CartModel> cart,
    required String couponCode,
  }) {
    final printNotes = <int, String>{
      for (final item in cart)
        item.id: ((item.isPrintable ?? 0) != 0)
            ? ref.read(printCtrlProvider(item.id)).text.trim()
            : '',
    };
    final formData = _confirmOrderController.form.group.value;

    return ConfirmOrderModel(
      cartProducts: cart,
      addressId: formData['address_id'] as int,
      paymentId: formData['payment_method'] as int,
      deliveryTypeId: formData['shipping_method_id'] as int,
      copon: couponCode,
      printNotesById: printNotes,
    );
  }

  PaymentRequestContextModel _buildPaymentRequest({
    required ConfirmOrderModel confirmOrderModel,
    required num totalPayable,
  }) {
    final initialPhone = _normalizeLocalPhone(Auth().phoneNumber);
    return PaymentRequestContextModel(
      confirmOrderModel: confirmOrderModel,
      depositAmount: totalPayable.toDouble(),
      initialPhoneNumber: initialPhone,
      phoneMaxLength: 9,
      phoneValidator: _validatePhone,
      phoneNumberMapper: _normalizeLocalPhone,
      floosakTargetPhoneMapper: (value) => '967${_normalizeLocalPhone(value)}',
    );
  }

  bool _validateBeforePaymentOpen(
    BuildContext context,
  ) {
    if (!_confirmOrderController.validateAndNotify(context)) return false;

    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      showFlashBarWarring(
        context: context,
        message: S.of(context).pleaseEnterProductPrintDescription,
      );
      return false;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    return true;
  }

  void _handlePaymentSuccess({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    resetPaymentSelectionState(ref);
    CompleteOrder.successDialog(context);
  }

  @override
  void initState() {
    super.initState();
    _confirmOrderController.form.reset();
    _confirmOrderController.form.group.control('payment_method').reset();
  }

  @override
  void dispose() {
    couponCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = ref.read(fetchOrderConfirmationDataProvider.notifier);
    final state = ref.watch(fetchOrderConfirmationDataProvider);

    num? shippingPrice;
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).confirmOrder),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: ReactiveFormBuilder(
            form: () => _confirmOrderController.form.group,
            builder: (context, form, child) {
              shippingPrice = form.value['shipping_price'] as num?;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddressToConfirmTheOrderWidget(
                    products: widget.products,
                    address: state.data.userAddresses,
                    form: form,
                    onSelectionChanged: () => setState(() {}),
                  ),
                  // GeneralDesignForOrderDetailsWidget(
                  //   title: S.of(context).paymentMethod,
                  //   child: ListOfPaymentMethodWidget(
                  //     payMethods: state.data.paymentMethods,
                  //     form: form,
                  //   ),
                  // ),
                  // GeneralDesignForOrderDetailsWidget(
                  //   title: S.of(context).paymentMethod,
                  //   child: ListOfPaymentMethodWidget(
                  //     paymentData: payState.data,
                  //   ),
                  // ),
                  12.h.verticalSpace,
                  PaymentMethodsSectionWidget(
                    title: S.of(context).paymentMethod,
                    onMethodSelected: (method) {
                      _confirmOrderController.form.group
                          .control('payment_method')
                          .value = method.id;
                    },
                  ),

                  // RequiredInputsWidget(
                  //   form: form,
                  //   value: 'payment_method',
                  //   requiredText: S.of(context).pleaseChoseAPaymentMethod,
                  // ),
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
                            if (widget.products.isEmpty) {
                              return;
                            }
                            ctrl.getData(
                              products: widget.products,
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
        child: PaymentActionButtonWidget(
          paymentRequestBuilder: (context, ref) => _buildPaymentRequest(
            confirmOrderModel: _buildConfirmOrderModel(
              cart: state.data.products,
              couponCode: couponCodeController.text,
            ),
            totalPayable: state.data.billData?.totalPayable ?? 0,
          ),
          buttonText: S.of(context).confirmOrder,
          height: 41.h,
          onBeforeOpen: (context, ref) => _validateBeforePaymentOpen(context),
          onPaymentSuccess: (context, ref, purchaseId) => _handlePaymentSuccess(
              context: context,
              ref: ref,
            ),
        ),
      ),
    );
  }
}
