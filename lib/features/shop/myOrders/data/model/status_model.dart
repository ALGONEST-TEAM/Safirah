class StatusModel {
  final int? id;
  final String? name;
  final String? color;

  StatusModel({
    this.id,
    this.name,
    this.color,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      id: json['id'] as int?,
      name: json['name'] ?? '',
      color: json['color'] ?? '',
    );
  }

  factory StatusModel.empty() => StatusModel(
    id: 0,
    name: '',
    color: '',
  );
}