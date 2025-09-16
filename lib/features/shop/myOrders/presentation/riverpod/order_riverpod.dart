import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../data/model/order_details_model.dart';
import '../../data/model/order_model.dart';
import '../../data/repos/order_repo.dart';

final getAllOrdersProvider = StateNotifierProvider.autoDispose<
    GetAllOrdersController, DataState<OrdersModel>>(
  (ref) {
    return GetAllOrdersController();
  },
);

class GetAllOrdersController extends StateNotifier<DataState<OrdersModel>> {
  GetAllOrdersController()
      : super(DataState<OrdersModel>.initial(OrdersModel.empty())) {
    getData();
  }

  final _controller = OrderReposaitory();

  Future<void> getData({bool moreData = false}) async {
    if (moreData &&
        state.data.currentPage >= state.data.lastPage) {
      return;
    }
    if (moreData) {
      state = state.copyWith(state: States.loadingMore);
    } else {
      state = state.copyWith(state: States.loading);
    }

    final nextPage = moreData ? state.data.currentPage + 1 : 1;

    final result = await _controller.getAllOrders(page: nextPage);

    result.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (newData) {
        final updatedOrders = moreData
            ? [...state.data.orders, ...newData.orders]
            : newData.orders;

        state = state.copyWith(
          state: States.loaded,
          data: state.data.copyWith(
            data: updatedOrders,
            currentPage: newData.currentPage,
            lastPage: newData.lastPage,
          ),
        );
      },
    );
  }
}

final orderDetailsProvider = StateNotifierProvider.autoDispose
    .family<OrderDetailsController, DataState<OrderDetailsModel>, int>(
  (ref, int id) {
    return OrderDetailsController(id);
  },
);

class OrderDetailsController
    extends StateNotifier<DataState<OrderDetailsModel>> {
  final int id;

  OrderDetailsController(this.id)
      : super(DataState<OrderDetailsModel>.initial(OrderDetailsModel.empty())) {
    getData();
  }

  final _controller = OrderReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.orderDetails(id: id);
    data.fold(
      (failure) {
        state = state.copyWith(state: States.error, exception: failure);
      },
      (orderDetailsData) {
        state = state.copyWith(
          state: States.loaded,
          data: orderDetailsData,
        );
      },
    );
  }
}
