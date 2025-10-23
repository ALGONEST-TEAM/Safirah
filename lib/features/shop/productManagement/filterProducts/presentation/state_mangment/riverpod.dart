import 'package:flutter_riverpod/legacy.dart';

import '../../../../../../core/state/data_state.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../generated/l10n.dart';
import '../../../detailsProducts/data/model/paginated_products_list_data.dart';
import '../../data/reposaitory/reposaitory.dart';

final selectedColorsProvider =
    StateNotifierProvider.family<SelectedColorsNotifier, List<int>, int>(
  (ref, idCategory) => SelectedColorsNotifier(),
);

class SelectedColorsNotifier extends StateNotifier<List<int>> {
  SelectedColorsNotifier() : super([]);

  void toggleColor(int idColor) {
    if (state.contains(idColor)) {
      state = List.from(state)..remove(idColor);
    } else {
      state = List.from(state)..add(idColor);
    }
  }

  void clear() {
    state = [];
  }
}

final selectedSizesProvider =
    StateNotifierProvider.family<SelectedSizesNotifier, List<int>, int>(
  (ref, idCategory) => SelectedSizesNotifier(),
);

class SelectedSizesNotifier extends StateNotifier<List<int>> {
  SelectedSizesNotifier() : super([]);

  void toggleSize(int idSize) {
    if (state.contains(idSize)) {
      state = List.from(state)..remove(idSize);
    } else {
      state = List.from(state)..add(idSize);
    }
  }

  void clear() {
    state = [];
  }
}

final selectedCategoryProvider =
    StateNotifierProvider.family<SelectedCategoryNotifier, int?, int>(
  (ref, idCategory) => SelectedCategoryNotifier(),
);

class SelectedCategoryNotifier extends StateNotifier<int?> {
  SelectedCategoryNotifier() : super(null);

  void selectCategory(int idCategory) {
    if (state == idCategory) {
      state = null;
    } else {
      state = idCategory;
    }
  }

  void clear() {
    state = null;
  }
}

final selectedSortIndexProvider =
    StateProvider.family<int, int>((ref, idCategory) => 0);

final sortOptionTitleProvider =
    StateProvider.family<String?, int>((ref, idCategory) => S.current.forYou);

final selectProductsSortOptionProvider = StateNotifierProvider.family<
    SelectProductsSortOptionNotifier, int?, int>(
  (ref, idCategory) => SelectProductsSortOptionNotifier(),
);

class SelectProductsSortOptionNotifier extends StateNotifier<int?> {
  SelectProductsSortOptionNotifier() : super(null);

  void selectOption(int option) {
    state = option;

    print("OOOOOOOO $state");
  }

  void clear() {
    state = null;
  }
}

final filterProductProvider = StateNotifierProvider.family<
    FilterProductNotifier,
    DataState<PaginatedProductsList>,
    int>((ref, idCategory) => FilterProductNotifier(idCategory));

class FilterProductNotifier
    extends StateNotifier<DataState<PaginatedProductsList>> {
  FilterProductNotifier(this.idCategory)
      : super(DataState<PaginatedProductsList>.initial(
            PaginatedProductsList.empty()));

  final int idCategory;

  final _controller = FilterReposaitory();

  Future<void> getProductOfFilter({
    List<int>? idSize,
    List<int>? idUnit,
    var idColor,
    bool moreData = false,
    int? idSubCategory,
    String? nameSearch,
    int? sortOption,

  }) async {
    if (moreData) {
      state = state.copyWith(state: States.loadingMore);
    } else {
      state = state.copyWith(state: States.loading);
    }

    final int page = moreData ? state.data.currentPage + 1 : 1;

    final data = await _controller.getProductOfFilter(
      idSize: idSize ?? [],
      idColor: idColor,
      idCategory: idCategory,
      page: page,
      idSubCategory: idSubCategory,
      nameSearch: nameSearch,
      sortOption: sortOption,
    );

    data.fold(
      (f) {
        state = state.copyWith(state: States.error, exception: f);
      },
      (product) {
        if (moreData) {
          final updatedData = state.data.copyWith(
            data: [...state.data.data, ...product.data],
            currentPage: product.currentPage,
          );
          state = state.copyWith(state: States.loaded, data: updatedData);
        } else {
          state = state.copyWith(state: States.loaded, data: product);
        }
      },
    );
  }
}
