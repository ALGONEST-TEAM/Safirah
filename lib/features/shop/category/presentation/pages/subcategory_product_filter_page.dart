import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../productManagement/filterProducts/presentation/state_mangment/riverpod.dart';
import '../../../productManagement/filterProducts/presentation/view/main_filter_widget.dart';
import '../../../productManagement/filterProducts/presentation/view/products_sort_option_widget.dart';
import '../../../productManagement/filterProducts/presentation/view/sub_filter_drawer_widget.dart';
import '../../../productManagement/search_product/presntation/state_mangment/riverpod.dart';
import '../riverpod/category_riverpod.dart';
import '../widgets/subcategory_filter_app_bar_widget.dart';
import '../widgets/subcategory_column_list_widget.dart';
import '../widgets/subcategory_product_list_widget.dart';
import '../widgets/subcategory_row_list_widget.dart';
import '../widgets/shimmer_sub_category_widget.dart';

class SubcategoryProductFilterPage extends ConsumerStatefulWidget {
  final int? idCategory;
  final String? nameSearch;
  final String nameCategoryForHintSearch;
  final bool isSearchPage;

  const SubcategoryProductFilterPage({
    super.key,
    this.idCategory,
    this.nameSearch,
    required this.nameCategoryForHintSearch,
    required this.isSearchPage,
  });

  @override
  ConsumerState<SubcategoryProductFilterPage> createState() =>
      _SubcategoryProductFilterPageState();
}

class _SubcategoryProductFilterPageState
    extends ConsumerState<SubcategoryProductFilterPage> {
  ScrollController _scrollController = ScrollController();
  bool pinCategoriesToTop = false;
  Timer? _debounceTimer;

  int get _categoryId => widget.idCategory ?? 00;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final shouldPin = _scrollController.offset > kToolbarHeight + 40.h;
    if (shouldPin != pinCategoriesToTop) {
      setState(() => pinCategoriesToTop = shouldPin);
    }
    _handlePagination();
  }

  void _handlePagination() {
    if (!mounted) return;

    final selectedSizes = ref.watch(selectedSizesProvider(_categoryId));
    final selectedColors = ref.watch(selectedColorsProvider(_categoryId));
    final selectedCategory = ref.watch(selectedCategoryProvider(_categoryId));
    final selectedOption =
        ref.watch(selectProductsSortOptionProvider(_categoryId));

    final reachedBottom = _scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent;
    if (!reachedBottom) return;

    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      final hasFilters = selectedColors.isNotEmpty ||
          selectedSizes.isNotEmpty ||
          selectedCategory != null ||
          selectedOption != null;

      if (hasFilters) {
        ref
            .read(filterProductProvider(_categoryId).notifier)
            .getProductOfFilter(
              sortOption: selectedOption,
              idColor: selectedColors,
              idSize: selectedSizes,
              idSubCategory: selectedCategory,
              nameSearch:
                  widget.isSearchPage ? widget.nameCategoryForHintSearch : '',
              moreData: true,
            );

      } else {
        widget.isSearchPage
            ? ref
                .read(
                    informationSearchProvider(widget.nameSearch ?? '').notifier)
                .getInformationSearch(moreData: true)
            : ref
                .read(categoryProvider(_categoryId).notifier)
                .getMainCategoryAndAllProduct(moreData: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.isSearchPage
        ? ref.watch(informationSearchProvider(widget.nameSearch ?? ''))
        : ref.watch(categoryProvider(_categoryId));
    final stateFilter = ref.watch(filterProductProvider(_categoryId));
    return Scaffold(
      appBar:
          state.stateData == States.loading || state.stateData == States.error
              ? const SubcategoryStatusAppBar()
              : null,
      body: SafeArea(
        top: false,
        child: CheckStateInGetApiDataWidget(
          state: state,
          widgetOfLoading: const ShimmerSubCategoryWidget(),
          refresh: () {
            widget.isSearchPage
                ? ref.invalidate(
                    informationSearchProvider(widget.nameSearch ?? ''))
                : ref.invalidate(categoryProvider(_categoryId));
          },
          widgetOfData: CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildSliverAppBar(state, widget.nameCategoryForHintSearch),
              _buildMainFilterWidget(state),
              SliverToBoxAdapter(
                child: ProductsSortOptionWidget(
                  idCategory: _categoryId,
                  nameSearch: widget.isSearchPage == false
                      ? ''
                      : widget.nameCategoryForHintSearch,
                ),
              ),
              SubcategoryProductListWidget(
                state: state,
                stateFilter: stateFilter,
                categoryId: _categoryId,
              ),
            ],
          ),
        ),
      ),
      endDrawer: SubFilterDrawerWidget(
        sizeFilterList: state.data.sizeFilter ?? [],
        colorFilterList: state.data.colorFilter ?? [],
        categoryFilterList: state.data.category ?? [],
        idCategory: _categoryId,
        nameSearch: widget.nameSearch ?? '',
        isSearchFilter: widget.isSearchPage,
      ),
    );
  }

  // ===================== APP BAR =====================
  SliverAppBar _buildSliverAppBar(state, String hintTextSearch) {
    return subcategoryFilterAppBarWidget(
      idCategory: widget.idCategory ?? 0,
      viewType: _getViewType(state),
      context: context,
      hintTextSearch: hintTextSearch,
      flexibleSpace: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfData: SubcategoryColumnListWidget(
          category: state.data.category ?? [],
          parentIdCategory: _categoryId,
          nameSearch:
              widget.isSearchPage ? widget.nameCategoryForHintSearch : '',
        ),
      ),
      bottom: state.data.category.isNotEmpty
          ? _buildSliverBottom(state)
          : const PreferredSize(
              preferredSize: Size(0, 0),
              child: SizedBox.shrink(),
            ),
    );
  }

  int _getViewType(state) {
    if (state.data.category?.isNotEmpty ?? false) {
      return state.data.category![0].hasChildren == true ? 1 : 2;
    }
    return 0;
  }

  PreferredSize _buildSliverBottom(state) {
    return PreferredSize(
      preferredSize: Size.fromHeight(pinCategoriesToTop ? 40.h : 0),
      child: pinCategoriesToTop
          ? CheckStateInGetApiDataWidget(
              state: state,
              widgetOfData: SubcategoryRowListWidget(
                category: state.data.category!,
                parentIdCategory: _categoryId,
                nameSearch:
                    widget.isSearchPage ? widget.nameCategoryForHintSearch : '',
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  // ===================== FILTERS =====================
  SliverToBoxAdapter _buildMainFilterWidget(state) {
    return SliverToBoxAdapter(
      child: Builder(
        builder: (context) {
          return MainFilterWidget(
            unitFilterList: state.data.unitFilter ?? [],
            categoryFilterList: state.data.category ?? [],
            sizeFilterList: state.data.sizeFilter ?? [],
            colorFilterList: state.data.colorFilter ?? [],
            idCategory: _categoryId,
            nameSearch: widget.nameCategoryForHintSearch,
            isSearchFilter: widget.isSearchPage,
            onTapFilter: () => Scaffold.of(context).openEndDrawer(),
          );
        },
      ),
    );
  }
}
