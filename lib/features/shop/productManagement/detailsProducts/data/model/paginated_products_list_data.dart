import 'package:hive_flutter/adapters.dart';

import 'product_data.dart';
part 'paginated_products_list_data.g.dart';

@HiveType(typeId: 2)
class PaginatedProductsList {
  @HiveField(5)
  final List<ProductData> data;
  @HiveField(1)
  final int currentPage;
  @HiveField(2)
  final int? lastPage;
  final int? totalProduct;
  final int? perPage;
  PaginatedProductsList({
    required this.data,
    required this.currentPage,
     this.lastPage,
    this.totalProduct,
    this.perPage
  });

  factory PaginatedProductsList.fromJson(Map<String, dynamic> json) {
    return PaginatedProductsList(
      data: (json['data'] as List<dynamic>)
          .map((e) => ProductData.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['current_page'] as int,
      lastPage: json['last_page'] as int,
      totalProduct: json['total'],
      perPage: json['per_page']
    );
  }

  factory PaginatedProductsList.empty() => PaginatedProductsList(
    currentPage: 0,
    lastPage: 0,
    data: [],
  );

  // copy
  PaginatedProductsList copyWith({
    List<ProductData>? data,
    int? total,
    int? currentPage,
    int? lastPages,
  }) {
    return PaginatedProductsList(
      data: data ?? this.data,

      currentPage: currentPage ?? this.currentPage,
      lastPage:lastPages??lastPage

    );
  }
}
