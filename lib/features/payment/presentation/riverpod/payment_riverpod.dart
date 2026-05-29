import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/state/data_state.dart';
import '../../../../core/state/state.dart';
import '../../data/model/floosak_payment_session_model.dart';
import '../../data/model/payment_methods_model.dart';
import '../../data/model/payment_request_context_model.dart';
import '../../data/reposaitory/payment_reposaitory.dart';

final getAllPaymentMethodsProvider = StateNotifierProvider.autoDispose<
    GetAllPaymentMethodsController, DataState<List<PaymentMethodsModel>>>(
  (ref) => GetAllPaymentMethodsController(),
);

class GetAllPaymentMethodsController
    extends StateNotifier<DataState<List<PaymentMethodsModel>>> {
  GetAllPaymentMethodsController()
      : super(DataState<List<PaymentMethodsModel>>.initial([])) {
    getData();
  }

  final _controller = PaymentReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.getAllPaymentMethods();

    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

final selectedPayMethodProvider =
    StateProvider<PaymentMethodsModel?>((ref) => null);

final selectedPayMethodErrorProvider = StateProvider<String?>((ref) => null);

void resetPaymentSelectionState(WidgetRef ref) {
  ref.read(selectedPayMethodProvider.notifier).state = null;
  ref.read(selectedPayMethodErrorProvider.notifier).state = null;
}

void refreshPaymentExecutionState(WidgetRef ref) {
  ref.invalidate(confirmPaymentProvider);
  ref.invalidate(startFloosakPaymentProvider);
  ref.invalidate(confirmFloosakPaymentProvider);
}

final confirmPaymentProvider =
    StateNotifierProvider<ConfirmPaymentNotifier, DataState<bool>>(
        (ref) => ConfirmPaymentNotifier());

class ConfirmPaymentNotifier extends StateNotifier<DataState<bool>> {
  ConfirmPaymentNotifier() : super(DataState<bool>.initial(false));
  final _controller = PaymentReposaitory();

  Future<void> confirmPayment({
    required PaymentRequestContextModel paymentRequest,
    required String payMethodName,
    required String voucher,
    required int amount,
    required String phoneNumber,
    String? purchaseId,
  }) async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.confirmPayment(
      paymentRequest: paymentRequest,
      payMethodName: payMethodName,
      voucher: voucher,
      amount: amount,
      phoneNumber: phoneNumber,
      purchaseId: purchaseId,
    );
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (_) {
      state = state.copyWith(
        state: States.loaded,
      );
    });
  }
}

final startFloosakPaymentProvider = StateNotifierProvider.autoDispose<
    StartFloosakPaymentNotifier, DataState<FloosakPaymentSessionModel>>(
  (ref) => StartFloosakPaymentNotifier(),
);

class StartFloosakPaymentNotifier
    extends StateNotifier<DataState<FloosakPaymentSessionModel>> {
  StartFloosakPaymentNotifier()
      : super(
          DataState<FloosakPaymentSessionModel>.initial(
            FloosakPaymentSessionModel.empty(),
          ),
        );

  final _controller = PaymentReposaitory();

  Future<void> startPayment({
    required PaymentRequestContextModel paymentRequest,
    required String payMethodName,
    required String phoneNumber,
    required int amount,
  }) async {
    state = state.copyWith(state: States.loading);
    final result = await _controller.startFloosakPayment(
      paymentRequest: paymentRequest,
      payMethodName: payMethodName,
      phoneNumber: phoneNumber,
      amount: amount,
    );
    result.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}

final confirmFloosakPaymentProvider = StateNotifierProvider.autoDispose<
    ConfirmFloosakPaymentNotifier, DataState<bool>>(
  (ref) => ConfirmFloosakPaymentNotifier(),
);

class ConfirmFloosakPaymentNotifier extends StateNotifier<DataState<bool>> {
  ConfirmFloosakPaymentNotifier() : super(DataState<bool>.initial(false));

  final _controller = PaymentReposaitory();

  Future<void> confirmPayment({
    required PaymentRequestContextModel paymentRequest,
    required FloosakPaymentSessionModel session,
    required String otp,
  }) async {
    state = state.copyWith(state: States.loading);
    final result = await _controller.confirmFloosakPayment(
      paymentRequest: paymentRequest,
      session: session,
      otp: otp,
    );
    result.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (_) {
      state = state.copyWith(state: States.loaded);
    });
  }
}

