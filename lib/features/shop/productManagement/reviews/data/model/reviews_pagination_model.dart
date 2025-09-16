import 'review_data.dart';

class PaginatedReviewsModel {
  final List<ReviewData> data;
  final dynamic currentPage;

  PaginatedReviewsModel({
    required this.data,
    required this.currentPage,
  });

  factory PaginatedReviewsModel.fromJson(Map<String, dynamic> json) {
    return PaginatedReviewsModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => ReviewData.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentPage: json['current_page'] ?? 0,
    );
  }

  factory PaginatedReviewsModel.empty() => PaginatedReviewsModel(
        currentPage: 0,
        data: [],
      );

  PaginatedReviewsModel copyWith({
    List<ReviewData>? data,
    int? currentPage,
  }) {
    return PaginatedReviewsModel(
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
