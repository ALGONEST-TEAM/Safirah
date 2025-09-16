import 'like_status_model.dart';

class ReviewData {
  final int id;
  final dynamic reviewValue;
  final String comment;
  final List<String>? image;
  final String createdAt;
  final int userId;
  final String userName;
  final int reviewLikeCount;
  final List<LikeStatusModel> likeStatus;
  final dynamic colorId;
  final String? colorName;
  final String? colorHex;
  final int? sizeId;
  final String? sizeValue;

  ReviewData({
    required this.id,
    required this.reviewValue,
    required this.comment,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.reviewLikeCount,
    required this.likeStatus,
    this.image,
    this.colorId,
    this.colorHex,
    this.colorName,
    this.sizeValue,
    this.sizeId,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      id: json['id'] ?? 0,
      reviewValue: json['review_value'] ?? 0.0,
      comment: json['comment'] ?? '',
      image:
          List<String>.from(json['images']?.map((item) => item['image']) ?? []),
      createdAt: json['created_at'] ?? '',
      userId: json['user_id'] ?? 0,
      userName: json['user_name'] ?? '',
      reviewLikeCount: json['review_like_count'] ?? 0,
      likeStatus: List<LikeStatusModel>.from(
        (json['like_status'] ?? List<LikeStatusModel>.empty).map(
          (e) => LikeStatusModel.fromJson(e),
        ),
      ),
      colorId: json['color_id'],
      colorHex: json['color_hex'] ?? '',
      colorName: json['color_name'] ?? '',
      sizeId: json['parent_measuring_id'] as int?,
      sizeValue: json['measuring_value'] ?? '',
    );
  }

}
