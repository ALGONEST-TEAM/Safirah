class NotificationsModel {
  final String? id;
  int? userId;
  final String title;
  final String message;
  final String date;
  final String? readAt;

  NotificationsModel({
    this.id,
    this.userId,
    required this.title,
    required this.message,
    required this.date,
    this.readAt,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      id: json['id'] ??"",
      userId: json['user_id'] != null
          ? int.tryParse(json['user_id'].toString())
          : null,
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      date: json['created_at'] ?? '',
      readAt: json['read_at'] ?? null,
    );
  }

  static List<NotificationsModel> fromJsonList(List json) {
    return json.map((e) => NotificationsModel.fromJson(e)).toList();
  }
}
