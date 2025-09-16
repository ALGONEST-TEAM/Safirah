import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/state/data_state.dart';
import '../../../../../../core/state/state.dart';
import '../../../cart/data/model/cart_model.dart';
import '../../data/model/check_copon_model.dart';
import '../../data/model/confirm_order_data_model.dart';
import '../../data/model/confirm_order_model.dart';
import '../../data/model/discount_copon_data.dart';
import '../../data/repos/confirm_order_repo.dart';
import '../widgets/order_data_form_widget.dart';

final getConfirmOrderDataProvider = StateNotifierProvider.autoDispose<
    GetConfirmOrderDataController, DataState<ConfirmOrderDataModel>>(
  (ref) => GetConfirmOrderDataController(),
);

class GetConfirmOrderDataController
    extends StateNotifier<DataState<ConfirmOrderDataModel>> {
  GetConfirmOrderDataController()
      : super(DataState<ConfirmOrderDataModel>.initial(
            ConfirmOrderDataModel.empty())) {
    getData();
  }

  final _controller = ConfirmOrderReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.getConfirmOrderData();

    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

final confirmOrderProvider =
    StateNotifierProvider.autoDispose<ConfirmOrderController, DataState<Unit>>(
  (ref) {
    return ConfirmOrderController();
  },
);

class ConfirmOrderController extends StateNotifier<DataState<Unit>> {
  ConfirmOrderController() : super(DataState<Unit>.initial(unit));

  final _controller = ConfirmOrderReposaitory();
  static OrderDataFormController form = OrderDataFormController();

  bool isValid() {
    form.group.markAllAsTouched();
    return form.group.valid;
  }

  Future<void> confirmOrder({
    required List<CartModel> cart,
    required String note,
    required String unitPrice,
  }) async {
    if (!isValid()) return;

    state = state.copyWith(state: States.loading);
    var formData = form.group.value;

    final data = await _controller.confirmOrder(
      confirmOrderModel: ConfirmOrderModel(
        cartProducts: cart,
        addressId: formData['address_id'] as int,
        paymentId: formData['payment_method'] as int,
        deliveryTypeId: formData['shipping_method_id'] as int,
        note: note,
        unitPrice: unitPrice,
        phoneNumber:"773551738",
      ),
    );

    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }
}


final checkCoponProvider = StateNotifierProvider.autoDispose<
    CheckCoponNotifier, DataState<DiscountProductFromCoponModel>>(
      (ref) => CheckCoponNotifier(),
);

class CheckCoponNotifier
    extends StateNotifier<DataState<DiscountProductFromCoponModel>> {
  CheckCoponNotifier()
      : super(DataState<DiscountProductFromCoponModel>.initial(
      DiscountProductFromCoponModel.empty()));

  final _controller = ConfirmOrderReposaitory();

  Future<void> getData({required CheckCoponModel copon }) async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.checkCopon(copon);

    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}