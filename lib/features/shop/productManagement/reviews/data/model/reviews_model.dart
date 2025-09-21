import 'reviews_pagination_model.dart';

class ReviewsModel {
  final dynamic rates;
  final int total;
  final List<CounterModel> counter;
  final PaginatedReviewsModel review;

  ReviewsModel({
    required this.rates,
    required this.total,
    required this.counter,
    required this.review,
  });

  factory ReviewsModel.fromJson(Map<String, dynamic> json) {
    return ReviewsModel(
      rates: json['rates'] ,
      total: json['totle'] ?? 0,
      counter: List<CounterModel>.from((json['counter'] ?? List<CounterModel>.empty())
          .map((e) => CounterModel.fromJson(e))),
      review: json['review'] == null
          ? PaginatedReviewsModel.empty()
          : PaginatedReviewsModel.fromJson(
              json['review'] as Map<String, dynamic>),
    );
  }

  factory ReviewsModel.empty() => ReviewsModel(
        rates: 0,
        total: 0,
        counter: [],
        review: PaginatedReviewsModel.empty(),
      );

  ReviewsModel copyWith({
    double? rates,
    int? total,
    List<CounterModel>? counter,
    PaginatedReviewsModel? review,
  }) {
    return ReviewsModel(
      rates: rates ?? this.rates,
      total: total ?? this.total,
      counter: counter ?? this.counter,
      review: review ?? this.review,
    );
  }
}

class CounterModel {
  final String? name;
  final int? value;

  CounterModel({
    required this.name,
    required this.value,
  });

  factory CounterModel.fromJson(Map<String, dynamic> json) {
    return CounterModel(
      name: json['name'] ??"",
      value: json['value'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
    };
  }
}
