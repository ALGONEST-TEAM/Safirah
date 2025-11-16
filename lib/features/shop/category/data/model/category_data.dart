import 'package:hive/hive.dart';

part 'category_data.g.dart';

@HiveType(typeId: 3)
class CategoryData {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? nameEn;
  @HiveField(3)
  final String? image;
  final bool? hasChildren;

  CategoryData({
    this.id,
    this.name,
    this.nameEn,
    this.hasChildren,
    this.image,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      hasChildren: json['has_children'] ?? false,
      image: json['image'] ?? "",
    );
  }

  static List<CategoryData> fromJsonCategoryList(List<dynamic> json) {
    return json.map((e) => CategoryData.fromJson(e)).toList();
  }

  factory CategoryData.empty() => CategoryData(
        name: "",
        id: 0,
      );
}
