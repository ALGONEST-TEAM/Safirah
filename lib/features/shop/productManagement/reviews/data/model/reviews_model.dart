import 'reviews_pagination_model.dart';

class ReviewsModel {
  final dynamic rates;
  final int total;
  final List<Counter> counter;
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
      counter: List<Counter>.from((json['counter'] ?? List<Counter>.empty())
          .map((e) => Counter.fromJson(e))),
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
    List<Counter>? counter,
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

class Counter {
  final String? name;
  final int? value;

  Counter({
    required this.name,
    required this.value,
  });

  factory Counter.fromJson(Map<String, dynamic> json) {
    return Counter(
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
