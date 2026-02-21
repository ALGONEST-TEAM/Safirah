import 'package:dio/dio.dart';

import 'pagination_data/paginated_model.dart';
import 'state.dart';

class DataState<T> {
  States stateData;
  final Object? exception;
  final T data;

  DataState({
    required this.stateData,
    this.exception,
    required this.data,
  });

  factory DataState.initial(T data) {
    return DataState(
      stateData: States.initial,
      data: data,
    );
  }

  DataState<T> copyWith({
    required States state,
    Object? exception,
    T? data,
  }) {
    return DataState(
      stateData: state,
      exception: exception,
      data: data ?? this.data,
    );
  }
}

extension DataStateExtension<T> on DataState<PaginationModel<T>> {
  DataState<PaginationModel<T>> success(PaginationModel<T> newData, bool moreData) {
    return copyWith(
      state: States.loaded,
      data: data.copyWith(
        data: moreData ? [...data.data, ...newData.data] : newData.data,
        currentPage: newData.currentPage,
        lastPage: newData.lastPage,
      ),
    );
  }
}
enum RefreshStatus { idle, loading, error }

class RefreshState {
  final RefreshStatus status;
  final DioException? exception;

  const RefreshState({
    required this.status,
    this.exception,
  });

  factory RefreshState.idle() => const RefreshState(status: RefreshStatus.idle);

  RefreshState copyWith({
    RefreshStatus? status,
    DioException? exception,
  }) {
    return RefreshState(
      status: status ?? this.status,
      exception: exception,
    );
  }
}
