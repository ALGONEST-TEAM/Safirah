
import 'copon_data.dart';

class PaginatedCoponList {
  final List<CoponData> data;
  final int currentPage;
  final int? lastPage;
  final int? totalProduct;
  final int? perPage;
  PaginatedCoponList({
    required this.data,
    required this.currentPage,
    this.lastPage,
    this.totalProduct,
    this.perPage
  });

  factory PaginatedCoponList.fromJson(Map<String, dynamic> json) {
    return PaginatedCoponList(
        data: (json['data'] as List<dynamic>)
            .map((e) => CoponData.fromJson(e as Map<String, dynamic>))
            .toList(),
        currentPage: json['current_page'] as int,
        lastPage: json['last_page'] as int,
        totalProduct: json['total'],
        perPage: json['per_page']
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'data': data.map((e) => e.toJson()).toList(),
  //     'total': total,
  //     'current_page': currentPage,
  //     'per_page': perPage,
  //   };
  // }

  factory PaginatedCoponList.empty() => PaginatedCoponList(
    currentPage: 0,
    lastPage: 0,
    data: [],
  );

  // copy
  PaginatedCoponList copyWith({
    List<CoponData>? data,
    int? total,
    int? currentPage,
    int? lastPages,
  }) {
    return PaginatedCoponList(
        data: data ?? this.data,

        currentPage: currentPage ?? this.currentPage,
        lastPage:lastPages??lastPage

    );
  }
}
