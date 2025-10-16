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
  final int? categoryLevel;
  final bool? hasChildren;

  CategoryData({
    this.id,
    this.name,
    this.nameEn,
    this.categoryLevel,
    this.hasChildren,
    this.image,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      categoryLevel: json['category_level'] ?? 0,
      hasChildren: json['has_children'] ?? false,
      image: json['image'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static List<CategoryData> fromJsonCategoryList(List<dynamic> json) {
    return json.map((e) => CategoryData.fromJson(e)).toList();
  }

  factory CategoryData.empty() => CategoryData(
        name: "",
        categoryLevel: 0,
        id: 0,
      );
  static final fakeCategoriesData = List.filled(
    20,
    CategoryData(
      name: "",
      id: 0,
    ),
  );
}
