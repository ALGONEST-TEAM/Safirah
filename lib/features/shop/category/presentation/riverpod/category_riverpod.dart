import 'package:flutter_riverpod/legacy.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../productManagement/detailsProducts/data/model/paginated_products_list_data.dart';
import '../../data/model/category_and_product_data.dart';
import '../../data/reposaitory/reposaitory.dart';

final categoryProvider = StateNotifierProvider.family<
    CategoryNotifier,
    DataState<CategoryAndProductData>,
    int>((ref, idCategory) => CategoryNotifier(idCategory));

class CategoryNotifier
    extends StateNotifier<DataState<CategoryAndProductData>> {
  CategoryNotifier(this.idCategory)
      : super(DataState<CategoryAndProductData>.initial(
            CategoryAndProductData.empty())) {
    getMainCategoryAndAllProduct();
  }

  final int idCategory;
  final _controller = CategoryReposaitories();

  Future<void> getMainCategoryAndAllProduct({bool moreData = false}) async {
    if (moreData) {
      state = state.copyWith(state: States.loadingMore);
    } else {
      state = state.copyWith(state: States.loading);
    }

    int page = state.data.product!.currentPage + 1;

    final user =
        await _controller.getMainCategoryAndAllProductData(idCategory, page);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (category) {
      var oldData = state.data;

      if (oldData.product?.data.isNotEmpty ?? false) {
        PaginatedProductsList updatedProductData = oldData.product!.copyWith(
          data: [...oldData.product!.data, ...category.product!.data],
          currentPage: category.product!.currentPage,
        );
        oldData = oldData.copyWith(
          products: updatedProductData,
        );
      } else {
        oldData = category;
      }

      state = state.copyWith(state: States.loaded, data: oldData);
    });
  }
}
