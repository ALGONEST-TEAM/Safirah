import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../../core/state/data_state.dart';
import '../../../../../../core/state/state.dart';
import '../../../cart/data/model/cart_model.dart';
import '../../data/model/confirm_order_data_model.dart';
import '../../data/model/confirm_order_model.dart';
import '../../data/repos/confirm_order_repo.dart';
import '../widgets/order_data_form_widget.dart';

final fetchOrderConfirmationDataProvider = StateNotifierProvider.autoDispose<
    FetchOrderConfirmationDataController, DataState<ConfirmOrderDataModel>>(
  (ref) => FetchOrderConfirmationDataController(),
);

enum FetchMode { confirm, coupon,refresh }

class FetchOrderConfirmationDataController
    extends StateNotifier<DataState<ConfirmOrderDataModel>> {
  FetchOrderConfirmationDataController()
      : super(
          DataState<ConfirmOrderDataModel>.initial(
            ConfirmOrderDataModel.empty(),
          ),
        );

  final _controller = ConfirmOrderReposaitory();
  FetchMode? lastMode;

  Future<void> getData({
    required List<CartModel> products,
    String? couponCode,
    required FetchMode mode,
  }) async {
    lastMode = mode;

    state = state.copyWith(state: States.loading);

    final data = await _controller.fetchOrderConfirmationData(
      products: products,
      couponCode: couponCode,
    );

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
    return ConfirmOrderController(ref);
  },
);

class ConfirmOrderController extends StateNotifier<DataState<Unit>> {
  ConfirmOrderController(this._ref) : super(DataState<Unit>.initial(unit));
  final Ref _ref;

  final _controller = ConfirmOrderReposaitory();
  static OrderDataFormController form = OrderDataFormController();

  bool isValid() {
    form.group.markAllAsTouched();
    return form.group.valid;
  }

  Future<void> confirmOrder({
    required List<CartModel> cart,
    required String copon,
  }) async {
    if (!isValid()) return;
    final printNotes = <int, String>{
      for (final p in cart)
        p.id: ((p.isPrintable ?? 0) != 0)
            ? _ref.read(printCtrlProvider(p.id)).text.trim()
            : '',
    };
    state = state.copyWith(state: States.loading);
    var formData = form.group.value;

    final data = await _controller.confirmOrder(
      confirmOrderModel: ConfirmOrderModel(
        cartProducts: cart,
        addressId: formData['address_id'] as int,
        paymentId: formData['payment_method'] as int,
        deliveryTypeId: formData['shipping_method_id'] as int,
        copon: copon,
        printNotesById: printNotes,
      ),
    );

    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }
}

final printCtrlProvider =
    Provider.autoDispose.family<TextEditingController, int>((ref, lineKey) {
  final c = TextEditingController();
  ref.onDispose(c.dispose);
  return c;
});
