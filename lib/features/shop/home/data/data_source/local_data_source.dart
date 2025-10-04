import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import '../../../home/data/model/section_data.dart';
import '../../../home/data/model/section_with_product_data.dart';
import '../../../productManagement/detailsProducts/data/model/paginated_products_list_data.dart';

class SectionLocalDataSource {
  SectionLocalDataSource();

  int cacheExpireTimeInSeconds = 3600;

  Future<void> updateCacheWithPagination({
    required List<SectionData> section,
    required PaginatedProductsList products,
    required int idSection,
    required int idFilter,
    required int pageNumber,
  }) async {
    try {
      var box = await Hive.openBox(
          'section_${idSection}_filter_${idFilter}_page_$pageNumber');
      SectionAndProductData data =
          SectionAndProductData(sections: section, product: products);
      final DateTime currentTime = DateTime.now();
      await box.put('last_update_time', currentTime.toIso8601String());
      await box.put('section_and_products', data);

      debugPrint(
          "Data cached for section $idSection, filter $idFilter, page $pageNumber");
    } catch (e) {
      debugPrint('Error while updating cache: $e');
    }
  }

  Future<SectionAndProductData?> getSectionFromCache(
      int idSection, int idFilter, int pageNumber) async {
    try {
      var box = await Hive.openBox(
          'section_${idSection}_filter_${idFilter}_page_$pageNumber');

      SectionAndProductData? cachedData = box.get('section_and_products');
      String? lastUpdateTimeStr = box.get('last_update_time');

      if (cachedData != null && lastUpdateTimeStr != null) {
        DateTime lastUpdateTime = DateTime.parse(lastUpdateTimeStr);
        final DateTime currentTime = DateTime.now();

        // التحقق من صلاحية البيانات في الكاش
        if (currentTime.difference(lastUpdateTime).inSeconds >
            cacheExpireTimeInSeconds) {
          debugPrint(
              'Cache expired for section $idSection, filter $idFilter, page $pageNumber');
          return null;
        }

        debugPrint(
            'Loaded data from cache for section $idSection, filter $idFilter, page $pageNumber');
        return cachedData;
      }

      debugPrint(
          'No valid data found in cache for section $idSection, filter $idFilter, page $pageNumber');
      return null;
    } catch (e) {
      debugPrint('Error while getting section from cache: $e');
      return null;
    }
  }

  static Future<void> clearCache() async {
    try {
      await Hive.deleteFromDisk();
      debugPrint("All cache data cleared successfully.");
    } catch (e) {
      debugPrint("Error while clearing cache: $e");
    }
  }

  Future<void> clearCaches({int? idSection, int? idFilter}) async {
    if (idSection != null && idFilter != null) {
      var box = await Hive.openBox('section_$idSection');
      box.keys
          .where((key) =>
              key.startsWith('section_${idSection}_filter_${idFilter}_'))
          .forEach((key) async {
        await box.delete(key);
      });
      debugPrint("Cleared cache for section $idSection, filter $idFilter");
    } else if (idSection != null) {
      var box = await Hive.openBox('section_$idSection');
      await box.clear();
      debugPrint("Cleared cache for section $idSection");
    } else {
      var box = await Hive.openBox('section');
      await box.clear();
      debugPrint("Cleared all cache");
    }
  }
}
