import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/widgets/product_list_widget.dart';
import '../../../../../core/widgets/skeletonizer_widget.dart';
import '../../../productManagement/detailsProducts/data/model/product_data.dart';
import '../../../productManagement/filterProducts/presentation/state_mangment/riverpod.dart';

class SubcategoryProductListWidget extends ConsumerWidget {
  final dynamic state;
  final dynamic stateFilter;
  final int categoryId;

  const SubcategoryProductListWidget({
    super.key,
    required this.state,
    required this.stateFilter,
    required this.categoryId,
  });

  bool _noFiltersSelected(WidgetRef ref) {
    final selectedSizes = ref.watch(selectedSizesProvider(categoryId));
    final selectedColors = ref.watch(selectedColorsProvider(categoryId));
    final selectedCategory = ref.watch(selectedCategoryProvider(categoryId));
    final selectedOption =
        ref.watch(selectProductsSortOptionProvider(categoryId));

    return selectedSizes.isEmpty &&
        selectedColors.isEmpty &&
        selectedCategory == null &&
        selectedOption == null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noFilters = _noFiltersSelected(ref);

    final isLoading = stateFilter.stateData == States.loading;
    final isLoadingMore = stateFilter.stateData == States.loadingMore;

    final products = noFilters
        ? state.data.product?.data ?? []
        : stateFilter.data.data ?? [];

    return SliverToBoxAdapter(
      child: isLoading
          ? SkeletonizerWidget(
              child: ProductListWidget(
                product: ProductData.fakeProductData,
                isLoadingMore: isLoadingMore,
              ),
            )
          : ProductListWidget(
              product: products,
              isLoadingMore: isLoadingMore,
            ),
    );
  }
}
