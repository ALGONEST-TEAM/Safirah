import 'package:hive/hive.dart';

import '../../../home/data/model/section_data.dart';
import '../../../home/data/model/section_with_product_data.dart';
import '../../../productManagement/detailsProducts/data/model/paginated_products_list_data.dart';

class SectionLocalDataSource {
  SectionLocalDataSource();

  int cacheExpireTimeInSeconds = 3600;

  Future<void> updateCacheWithPagination(
      {required List<dynamic>? imageBanner,
        required List<SectionData> section,
        required  PaginatedProductsList products,
        required  int idSection,
        required int idFilter,
        required int pageNumber}) async {
    try {
      var box = await Hive.openBox(
          'section_${idSection}_filter_${idFilter}_page_$pageNumber');
      SectionAndProductData data = SectionAndProductData(
          sections: section, product: products, imageBanner: imageBanner);
      final DateTime currentTime = DateTime.now();
      await box.put('last_update_time', currentTime.toIso8601String());
      await box.put('section_and_products', data);

      print(
          "Data cached for section $idSection, filter $idFilter, page $pageNumber");
    } catch (e) {
      print('Error while updating cache: $e');
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
          print(
              'Cache expired for section $idSection, filter $idFilter, page $pageNumber');
          return null;
        }

        print(
            'Loaded data from cache for section $idSection, filter $idFilter, page $pageNumber');
        return cachedData;
      }

      print(
          'No valid data found in cache for section $idSection, filter $idFilter, page $pageNumber');
      return null;
    } catch (e) {
      print('Error while getting section from cache: $e');
      return null;
    }
  }
 static Future<void> clearCache() async {
    try {
      await Hive.deleteFromDisk();
      print("All cache data cleared successfully.");
    } catch (e) {
      print("Error while clearing cache: $e");
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
      print("Cleared cache for section $idSection, filter $idFilter");
    } else if (idSection != null) {
      var box = await Hive.openBox('section_$idSection');
      await box.clear();
      print("Cleared cache for section $idSection");
    } else {
      var box = await Hive.openBox('section');
      await box.clear();
      print("Cleared all cache");
    }
  }
  // Future<void> updateCacheWithAllSectionsData(SectionWithCategoryOfAllData data) async {
  //   try {
  //     var box = await Hive.openBox('all_sections_and_products');
  //
  //     // إضافة البيانات إلى الكاش
  //     final DateTime currentTime = DateTime.now();
  //     await box.put('last_update_time', currentTime.toIso8601String());
  //     await box.put('all_sections_and_products', data);
  //
  //     print("Data cached for all sections and products.");
  //
  //     // إغلاق الكاش بعد استخدامه
  //     await box.close();
  //   } catch (e) {
  //     print('Error while updating cache for all sections: $e');
  //   }
  // }
  //
  // // جلب البيانات من الكاش
  // Future<SectionWithCategoryOfAllData?> getAllSectionsFromCache() async {
  //   try {
  //     var box = await Hive.openBox('all_sections_and_products');
  //
  //     // جلب البيانات من الكاش
  //     SectionWithCategoryOfAllData? cachedData = box.get('all_sections_and_products');
  //     String? lastUpdateTimeStr = box.get('last_update_time');
  //
  //     if (cachedData != null && lastUpdateTimeStr != null) {
  //       DateTime lastUpdateTime = DateTime.parse(lastUpdateTimeStr);
  //       final DateTime currentTime = DateTime.now();
  //
  //       // التحقق من صلاحية البيانات في الكاش
  //       if (currentTime.difference(lastUpdateTime).inSeconds > cacheExpireTimeInSeconds) {
  //         print('Cache expired for all sections and products.');
  //         await box.close(); // إغلاق الكاش بعد التحقق من صلاحية البيانات
  //         return null; // الكاش منتهي الصلاحية
  //       }
  //
  //       print('Loaded all sections and products data from cache.');
  //       await box.close(); // إغلاق الكاش بعد استخدامه
  //       return cachedData;
  //     }
  //
  //     print('No valid data found in cache for all sections and products.');
  //     await box.close(); // إغلاق الكاش بعد الفشل في العثور على بيانات
  //     return null; // لا يوجد بيانات صالحة في الكاش
  //   } catch (e) {
  //     print('Error while getting all sections and products from cache: $e');
  //     return null; // حدوث خطأ أثناء الحصول على البيانات من الكاش
  //   }
  // }

  // مسح الكاش
  // Future<void> clearCache() async {
  //   try {
  //     var box = await Hive.openBox('all_sections_and_products');
  //     await box.clear(); // مسح الكاش
  //     print("Cleared all sections and products cache.");
  //
  //     // إغلاق الكاش بعد مسحه
  //     await box.close();
  //   } catch (e) {
  //     print('Error while clearing cache: $e');
  //   }
  // }
}


