import 'offers_model.dart';
import 'section_data.dart';

class SectionsAndOffersData {
  final List<SectionData>? section;

  final List<OffersModel>? offers;

  SectionsAndOffersData({
    this.section,
    this.offers,
  });

  factory SectionsAndOffersData.fromJson(Map<String, dynamic> json) {
    return SectionsAndOffersData(
      section: SectionData.fromJsonSectionList(json['sections'] ?? []),
      offers: OffersModel.fromJsonList(json['banners'] ?? []),
    );
  }

  static List<SectionsAndOffersData> fromJsonCategoryList(List json) {
    return json.map((e) => SectionsAndOffersData.fromJson(e)).toList();
  }

  factory SectionsAndOffersData.empty() => SectionsAndOffersData(
        section: [],
        offers: [],
      );
}
