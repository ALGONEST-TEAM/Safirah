import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../../core/state/data_state.dart';
import '../../../../../core/state/state.dart';
import '../../../home/data/model/section_with_product_data.dart';
import '../../../productManagement/detailsProducts/data/model/paginated_products_list_data.dart';
import '../../data/model/offer_products_model.dart';
import '../../data/model/sections_and_offers_data.dart';
import '../../data/reposaitory/reposaitories.dart';

final homeTabIndexProvider = StateProvider<int>((ref) => 0);

final sectionProvider =
    StateNotifierProvider<SectionNotifier, DataState<SectionsAndOffersData>>(
        (ref) => SectionNotifier());

class SectionNotifier extends StateNotifier<DataState<SectionsAndOffersData>> {
  SectionNotifier()
      : super(DataState<SectionsAndOffersData>.initial(
            SectionsAndOffersData.empty())) {
    getAllSectionAndAllOffers();
  }

  int idSection = 1;

  final _controller = SectionReposaitory();

  Future<void> getAllSectionAndAllOffers() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.getAllSectionAndAllOffersData();
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (section) {
      state = state.copyWith(state: States.loaded, data: section);
    });
  }
}

final subSectionProvider = StateNotifierProvider.family<SubSectionNotifier,
    DataState<SectionAndProductData>, Tuple2<int, int>>(
  (ref, params) => SubSectionNotifier(
    ref,
    params.value1,
    params.value2,
  ),
);

class SubSectionNotifier
    extends StateNotifier<DataState<SectionAndProductData>> {
  SubSectionNotifier(this.ref, this.idSection, this.idFilter)
      : super(DataState<SectionAndProductData>.initial(
            SectionAndProductData.empty())) {
    getSubSectionData();
  }

  Ref ref;
  final int idSection;
  int idFilter;
  final _controller = SectionReposaitory();

  // خريطة لتخزين البيانات الخاصة بكل فلتر
  Map<int, PaginatedProductsList> filterProductMap = {};

  Future<void> getSubSectionData(
      {bool moreData = false, bool isRefresh = false}) async {
    if (moreData) {
      state = state.copyWith(state: States.loadingMore);
    } else {
      state = state.copyWith(state: States.loading);
    }

    int page = isRefresh ? 1 : state.data.product!.currentPage + 1;

    final data =
        await _controller.getSectionData(idSection, page, isRefresh, idFilter);
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (section) {
      var oldData = state.data;

      // إذا كانت البيانات الخاصة بالـ `idFilter` غير موجودة، نقوم بإنشاء قائمة جديدة
      if (!filterProductMap.containsKey(idFilter)) {
        filterProductMap[idFilter] = section.product!;
      } else {
        // إذا كانت البيانات موجودة بالفعل، نقوم بإضافة المنتجات الجديدة
        var existingData = filterProductMap[idFilter]!;
        var updatedData = existingData.copyWith(
          data: [...existingData.data, ...section.product!.data],
          currentPage: section.product!.currentPage,
        );
        filterProductMap[idFilter] = updatedData;
      }

      // إذا لم يكن هناك بيانات سابقة، نقوم بتخزين البيانات القادمة في الـ `filterProductMap`
      if (oldData.product!.data.isNotEmpty && !isRefresh) {
        PaginatedProductsList productData;
        productData = oldData.product!.copyWith(
          data: [...oldData.product!.data, ...section.product!.data],
          currentPage: section.product!.currentPage,
        );
        oldData = oldData.copyWith(products: productData);
      } else {
        oldData = section;
      }

      state = state.copyWith(state: States.loaded, data: oldData);
    });
  }
}

final getSectionFilterTypeProvider =
    StateNotifierProvider.family<GetSectionFilterTypeNotifier, int?, int?>(
        (ref, idSection) {
  return GetSectionFilterTypeNotifier();
});

class GetSectionFilterTypeNotifier extends StateNotifier<int?> {
  GetSectionFilterTypeNotifier() : super(null);

  void setSectionFilterNumber(int numberFilter) {
    state = numberFilter;
  }
}

final getOfferProductsProvider = StateNotifierProvider.autoDispose
    .family<GetOfferProductsController, DataState<OfferProductsModel>, int>(
  (ref, int offerId) {
    return GetOfferProductsController(offerId);
  },
);

class GetOfferProductsController
    extends StateNotifier<DataState<OfferProductsModel>> {
  final int offerId;

  GetOfferProductsController(this.offerId)
      : super(
            DataState<OfferProductsModel>.initial(OfferProductsModel.empty())) {
    getData();
  }

  final _controller = SectionReposaitory();

  Future<void> getData() async {
    state = state.copyWith(state: States.loading);
    final data = await _controller.getOfferProducts(offerId);
    data.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (data) {
      state = state.copyWith(state: States.loaded, data: data);
    });
  }
}
