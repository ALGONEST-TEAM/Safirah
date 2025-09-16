import 'order_data_model.dart';

class OrdersModel {
  final int currentPage;
  final List<OrderDataModel> orders;
  final int totalPages;
  final int perPage;
  final int lastPage;

  const OrdersModel({
    required this.orders,
    required this.currentPage,
    required this.totalPages,
    required this.perPage,
    required this.lastPage,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    return OrdersModel(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      orders: OrderDataModel.fromJsonList(json['data']),
      perPage: json['per_page'],
      totalPages: json['total'],
    );
  }

  factory OrdersModel.empty() => const OrdersModel(
        currentPage: 0,
        totalPages: 0,
        perPage: 0,
        lastPage: 0,
        orders: [],
      );

  OrdersModel copyWith({
    List<OrderDataModel>? data,
    int? lastPage,
    int? totalPages,
    int? currentPage,
  }) {
    return OrdersModel(
      orders: data ?? orders,
      totalPages: totalPages ?? this.totalPages,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
