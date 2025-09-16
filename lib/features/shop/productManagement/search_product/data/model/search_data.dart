
class SearchData {
  final int? id;
  final String? name;
  SearchData({this.id,this.name});

  factory SearchData.fromJson(Map<String, dynamic> json) {
    return SearchData(
       id: json['id'],
       name: json['name']
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static List<SearchData> fromJsonSearchList(List json) {
    return json.map((e) => SearchData.fromJson(e)).toList();
  }

  factory SearchData.empty() => SearchData(

  );
}
