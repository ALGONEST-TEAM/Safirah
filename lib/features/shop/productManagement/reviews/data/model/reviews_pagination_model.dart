import 'review_data.dart';

class PaginatedReviewsModel {
  final List<ReviewData> data;
  final dynamic currentPage;
  final int lastPage;

  PaginatedReviewsModel({
    required this.data,
    required this.currentPage,
    required this.lastPage,

  });

  factory PaginatedReviewsModel.fromJson(Map<String, dynamic> json) {
    return PaginatedReviewsModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => ReviewData.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['current_page'] ?? 0,
      lastPage: json['last_page']??0,

    );
  }

  factory PaginatedReviewsModel.empty() => PaginatedReviewsModel(
        currentPage: 0,
        lastPage: 0,
        data: [],
      );

  PaginatedReviewsModel copyWith({
    List<ReviewData>? data,
    int? currentPage,
    int? lastPage,
  }) {
    return PaginatedReviewsModel(
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,

    );
  }
}
