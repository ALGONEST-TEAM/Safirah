
import 'package:hive/hive.dart';

class SearchLocalDataSource {
  Future<Box> _openBox() async {
    return await Hive.openBox('searchHistory');
  }

  Future<void> saveSearchHistory(String query) async {
    final box = await _openBox();
    if (!box.values.contains(query)) {
      await box.add(query);
    }

  }

  Future<List<String>> getSearchHistory() async {
    final box = await _openBox();
    return box.values.toList().cast<String>();  // استرجاع النصوص المخزنة
  }

  Future<void> clearSearchHistory() async {
    final box = await _openBox();
    await box.clear();
  }

  Future<void> deleteSearchHistoryItem(String item) async {
    final box = await _openBox();
    final index = box.values.toList().indexOf(item);

    if (index != -1) {
      await box.deleteAt(index);
    }
  }
}
