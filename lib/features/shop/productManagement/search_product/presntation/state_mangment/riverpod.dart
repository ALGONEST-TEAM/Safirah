import 'package:flutter_riverpod/legacy.dart';
import '../../../../../../core/state/data_state.dart';
import '../../../../../../core/state/state.dart';
import '../../../../category/data/model/category_and_product_data.dart';
import '../../../detailsProducts/data/model/paginated_products_list_data.dart';
import '../../data/model/search_data.dart';
import '../../data/reposaitory/reposaitory.dart';

class SearchHistoryNotifier extends StateNotifier<List<String>> {


  SearchHistoryNotifier() : super([]){
    loadSearchHistory();
  }

  Future<void> loadSearchHistory() async {
    final history = await SearchRepository().getSearchHistory();
    state = history;
  }

  Future<void> addSearchHistory(String item) async {
    await SearchRepository().saveSearchHistory(item);
    await loadSearchHistory();
  }
  Future<void> deleteSearchItem(String item) async {
    await SearchRepository().clearItemSearchHistory(item);
    await loadSearchHistory();
  }


  Future<void> clearSearchHistory() async {
    await SearchRepository().clearSearchHistory();
    await loadSearchHistory();
  }
}
final searchHistoryProvider = StateNotifierProvider<SearchHistoryNotifier, List<String>>((ref) {
  return SearchHistoryNotifier();
});

final searchNameProvider = StateNotifierProvider.family<SearchNameNotifier,
    DataState<List<SearchData>>,String>((ref,charcterSearch) => SearchNameNotifier(charcterSearch));

class SearchNameNotifier extends StateNotifier<DataState<List<SearchData>>> {
  SearchNameNotifier(this.charcterSearch)
      : super(DataState<List<SearchData>>.initial([])){
    getNameSearchInfo();
  }
  final String charcterSearch;
  final _controller = SearchRepository();

  Future<void> getNameSearchInfo() async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.getNamesOfInformationSearch(charcterSearch);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (userData) {
      state = state.copyWith(state: States.loaded, data: userData);
    });
  }

}

final informationSearchProvider = StateNotifierProvider.family<InformationSearchNotifier,
    DataState<CategoryAndProductData>,String>((ref,nameSearch) => InformationSearchNotifier(nameSearch));

class InformationSearchNotifier extends StateNotifier<DataState<CategoryAndProductData>> {
  InformationSearchNotifier(this.nameSearch)
      : super(DataState<CategoryAndProductData>.initial(CategoryAndProductData.empty())){
    getInformationSearch();
  }
  final String nameSearch;
  final _controller = SearchRepository();

  Future<void> getInformationSearch({bool moreData = false}) async {
    if(moreData ==true){
      state = state.copyWith(state: States.loadingMore);
    }else{
      state = state.copyWith(state: States.loading);

    }
    int page = state.data.product!.currentPage+1;

    final user = await _controller.getSearchInformation(nameSearch,page);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (category) {
      var oldData = state.data;
      if (oldData.product!.data.isNotEmpty) {

        PaginatedProductsList productData;
        productData=oldData.product!.copyWith(
          data: [...oldData.product!.data,...category.product!.data],
          currentPage: category.product!.currentPage,
        );
        oldData = oldData.copyWith(products: productData);
      }
      else{
        oldData =category;
      }
      state = state.copyWith(state: States.loaded, data: oldData);

    });
  }
}