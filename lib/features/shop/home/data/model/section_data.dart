import 'package:hive_flutter/adapters.dart';
import '../../../category/data/model/category_data.dart';

part 'section_data.g.dart';

@HiveType(typeId: 1)
class SectionData {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? nameEn;
  @HiveField(3)
  final List<CategoryData>? category;
  @HiveField(4)
  final String? hasSubSection;

  SectionData({
    this.id,
    this.name,
    this.nameEn,
    this.category,
    this.hasSubSection,
  });

  factory SectionData.fromJson(Map<String, dynamic> json) {
    return SectionData(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      nameEn: json['name_en'] ?? "",
      hasSubSection: json['has_sub'],
      category: CategoryData.fromJsonCategoryList(json['categories'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  static List<SectionData> fromJsonSectionList(List<dynamic> json) {
    return json.map((e) => SectionData.fromJson(e)).toList();
  }

  factory SectionData.empty() => SectionData(name: "", nameEn: "", id: 0);
}
