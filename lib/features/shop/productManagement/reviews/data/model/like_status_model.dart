class LikeStatusModel {
  final int id;
  final int userId;
  final int reviewId;
  final int status;

  LikeStatusModel({
    required this.id,
    required this.userId,
    required this.reviewId,
    required this.status,
  });

  factory LikeStatusModel.fromJson(Map<String, dynamic> json) {
    return LikeStatusModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      reviewId: json['review_id'] ?? 0.0,
      status: json['status'] ?? 0,
    );
  }
  factory LikeStatusModel.empty() => LikeStatusModel(
    id: 0,
    userId: 0,
    reviewId: 0,
    status: 0,
  );
}