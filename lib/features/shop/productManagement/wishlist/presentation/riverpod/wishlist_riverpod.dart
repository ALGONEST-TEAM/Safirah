import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../../../core/state/data_state.dart';
import '../../../../../../core/state/state.dart';
import '../../../detailsProducts/data/model/product_data.dart';
import '../../data/model/list_model.dart';
import '../../data/repos/wishlist_repo.dart';

final getAllWishesProductsProvider = StateNotifierProvider<GetAllWishesProductsController,
    DataState<List<ProductData>>>(
  (ref) {
    return GetAllWishesProductsController();
  },
);

class GetAllWishesProductsController
    extends StateNotifier<DataState<List<ProductData>>> {
  GetAllWishesProductsController() : super(DataState.initial([])) {
    getData();
  }

  final _controller = WishlistReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.getAllWishesProducts();
    data.fold((failure) {
      state = state.copyWith(state: States.error, exception: failure);
    }, (newData) {
      state = state.copyWith(state: States.loaded, data: newData);
    });
  }
}

final getAllListProvider =
    StateNotifierProvider<GetAllListController, DataState<List<ListModel>>>(
  (ref) {
    return GetAllListController();
  },
);

class GetAllListController extends StateNotifier<DataState<List<ListModel>>> {
  GetAllListController() : super(DataState<List<ListModel>>.initial([])) {
    getData();
  }

  final _controller = WishlistReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);

    final data = await _controller.getAllList();
    data.fold((failure) {
      if (mounted) {
        state = state.copyWith(state: States.error, exception: failure);
      }
    }, (newData) {
      if (mounted) {
        state = state.copyWith(state: States.loaded, data: newData);
      }
    });
  }
}

final getProductsByListProvider = StateNotifierProvider.autoDispose
    .family<GetProductsByListController, DataState<List<ProductData>>, int>(
  (ref, int listId) {
    return GetProductsByListController(listId);
  },
);

class GetProductsByListController
    extends StateNotifier<DataState<List<ProductData>>> {
  GetProductsByListController(this.listId) : super(DataState.initial([])) {
    getData();
  }

  final int listId;
  final _controller = WishlistReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.getProductsByList(listId);
    data.fold((failure) {
      state = state.copyWith(state: States.error, exception: failure);
    }, (newData) {
      state = state.copyWith(state: States.loaded, data: newData);
    });
  }
}

final wishlistProvider =
    StateNotifierProvider.autoDispose<WishlistController, DataState<Unit>>(
  (ref) {
    return WishlistController();
  },
);

class WishlistController extends StateNotifier<DataState<Unit>> {
  WishlistController() : super(DataState<Unit>.initial(unit));
  final _controller = WishlistReposaitory();

  final List<int> _selectedWishlist = [];

  List<int> get selectedWishlist => _selectedWishlist;

  void toggleAllWishlistProductsSelection(
    bool isChecked,
    List<int> allWishlistProducts,
  ) {
    if (isChecked) {
      selectedWishlist.clear();
      selectedWishlist.addAll(allWishlistProducts.map((product) => product));
    } else {
      selectedWishlist.clear();
    }
    state = state.copyWith(state: States.initial);
  }

  bool isAllWishlistProductsSelected(List<int> allWishlistProducts) {
    return selectedWishlist.length == allWishlistProducts.length &&
        allWishlistProducts
            .every((wishlist) => selectedWishlist.any((w) => w == wishlist));
  }

  void toggleWishlistProductsSelection(bool isChecked, int productId) {
    if (isChecked) {
      _selectedWishlist.add(productId);
    } else {
      _selectedWishlist.removeWhere((w) => w == productId);
    }
    state = state.copyWith(state: States.initial);
  }

  Future<void> addWishlist({
    required int productId,
  }) async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.addWishlist(productId);
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }

  Future<void> deleteWishlist({
    required List<int> productsIds,
  }) async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.deleteWishlist(productsIds);
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }

  Future<void> createAnewListAndAddProducts({
    required int listId,
    required String listName,
    required List<int> productsIds,
  }) async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.createAnewListAndAddProducts(
      listId,
      listName,
      productsIds,
    );
    data.fold((f) {
      if (mounted) {
        state = state.copyWith(state: States.error, exception: f);
      }
    }, (data) {
      if (mounted) {
        state = state.copyWith(state: States.loaded);
      }
    });
  }

  Future<void> renameTheList({
    required int listId,
    required String listName,
  }) async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.renameTheList(
      listId,
      listName,
    );
    data.fold((f) {
      if (mounted) {
        state = state.copyWith(state: States.error, exception: f);
      }
    }, (data) {
      if (mounted) {
        state = state.copyWith(state: States.loaded);
      }
    });
  }

  Future<void> deleteList({
    required int listId,
  }) async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.deleteList(listId);
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }

  Future<void> deleteListProducts({
    required int listId,
    required List<int> productsIds,
  }) async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.deleteListProducts(listId, productsIds);
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded);
    });
  }
}


