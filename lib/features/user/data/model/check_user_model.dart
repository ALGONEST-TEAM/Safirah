class CheckUserModel {
  final String type;
  final String input;
  final String status;

  CheckUserModel({
    required this.type,
    required this.input,
    required this.status,
  });

  factory CheckUserModel.fromJson(Map<String, dynamic> json) {
    return CheckUserModel(
      type: json['type'] ?? "",
      input: json['input'] ?? "",
      status: json['status'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'input': input,
      'status': status,
    };
  }

  factory CheckUserModel.empty() => CheckUserModel(
        type: '',
        input: '',
        status: '',
      );
}
