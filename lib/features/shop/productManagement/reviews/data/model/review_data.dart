class ReviewData {
  final int id;
  final dynamic reviewValue;
  final String comment;
  final List<String>? image;
  final String createdAt;
  final int userId;
  final String userName;
  final int reviewLikeCount;
  final int likeStatus;
  final dynamic colorId;
  final String? colorName;
  final String? colorHex;
  final int? sizeId;
  final String? sizeValue;
  final int? numberId;
  final String? numberName;

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
    this.numberId,
    this.numberName,
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
      likeStatus: json['like_status'] ?? 0,
      colorId: json['color_id'],
      colorHex: json['color_hex'] ?? '',
      colorName: json['color_name'] ?? '',
      sizeId: json['parent_measuring_id'] as int?,
      sizeValue: json['measuring_value'] ?? '',
      numberId: json['number_id'] ?? 0,
      numberName: json['number_value'] ?? "",
    );
  }

  static List<ReviewData> fromJsonList(List<dynamic> json) {
    return json.map((e) => ReviewData.fromJson(e)).toList();
  }
}
