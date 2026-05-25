class PaymentMethodsModel {
  final int id;
  final String name;
  final String title;
  final int type;
  final bool isConnected;
  final String manualPointNumber;
  final String note;
  final String? image;

  PaymentMethodsModel({
    required this.id,
    required this.name,
    required this.title,
    required this.type,
    required this.isConnected,
    required this.manualPointNumber,
    required this.note,
    required this.image,
  });

  factory PaymentMethodsModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      title: json['title'] ?? '',
      type: json['type'] ?? 0,
      isConnected: _parseBool(json['is_connected'], fallback: true),
      manualPointNumber: json['manual_point_number']?.toString() ?? '',
      note: json['note']?.toString() ?? '',
      image: json['image'] ?? '',
    );
  }

  static List<PaymentMethodsModel> fromJsonList(List json) {
    return json.map((e) => PaymentMethodsModel.fromJson(e)).toList();
  }

  static PaymentMethodsModel empty() {
    return PaymentMethodsModel(
      id: 0,
      name: '',
      title: '',
      type: 0,
      isConnected: true,
      manualPointNumber: '',
      note: '',
      image: '',
    );
  }

  static bool _parseBool(dynamic value, {required bool fallback}) {
    if (value == null) return fallback;
    if (value is bool) return value;
    if (value is num) return value != 0;
    final normalized = value.toString().trim().toLowerCase();
    if (normalized.isEmpty) return fallback;
    return {'1', 'true', 'yes', 'on'}.contains(normalized);
  }
}

