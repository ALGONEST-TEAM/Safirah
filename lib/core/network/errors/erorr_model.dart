import '../../../generated/l10n.dart';

class ErrorsModel {
  final String title;
  final dynamic subTittle;

  ErrorsModel({
    required this.title,
    required this.subTittle,
  });

  factory ErrorsModel.fromJson(Map<String, dynamic> json) {
    final rawSubTitle = json['sub_title'];

    String parsedSubTitle;

    if (rawSubTitle is List) {
      parsedSubTitle = rawSubTitle.join('\n');
    } else if (rawSubTitle is String) {
      parsedSubTitle = rawSubTitle;
    } else {
      parsedSubTitle = S.current.pleaseTryAgain;
    }
    return ErrorsModel(
      title: json['title'] ?? '',
      subTittle: parsedSubTitle,
    );
  }
}
