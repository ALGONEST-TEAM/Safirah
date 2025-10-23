import 'package:flutter_riverpod/legacy.dart';
import '../../../../../../core/state/data_state.dart';
import '../../../../../../core/state/state.dart';
import '../../data/model/product_data.dart';
import '../../data/reposaitory/reposaitories.dart';

final detailsProvider = StateNotifierProvider.family<
    DetailsProductNotifier,
    DataState<ProductData>,
    int>((ref, idProduct) => DetailsProductNotifier(idProduct));

class DetailsProductNotifier extends StateNotifier<DataState<ProductData>> {
  DetailsProductNotifier(this.idProduct)
      : super(DataState<ProductData>.initial(ProductData.empty())) {
    getDetailsOfProduct();
  }

  final int idProduct;
  final _controller = DetailsProductReposaitories();

  Future<void> getDetailsOfProduct() async {
    state = state.copyWith(state: States.loading);
    final user = await _controller.getDetailsOfProduct(idProduct);
    user.fold((f) {
      state = state.copyWith(state: States.error, exception: f);
    }, (userData) {
      state = state.copyWith(state: States.loaded, data: userData);
    });
  }
}

//////////////////////////////////////////////////////////////////////////////////////
class ChangeIndexOfColorImageAndSizeNotifier extends StateNotifier<int?> {
  ChangeIndexOfColorImageAndSizeNotifier() : super(0);

  void setIndexColor(int index) {
    state = index;
  }
}

final changeIndexOfColorImageAndSizeProvider = StateNotifierProvider
    .autoDispose<ChangeIndexOfColorImageAndSizeNotifier, int?>((ref) {
  return ChangeIndexOfColorImageAndSizeNotifier();
});

//////////////////////////////////////////////////////////////////////////////////////////
class ShowNumberOfScrollImageNotifier extends StateNotifier<int?> {
  ShowNumberOfScrollImageNotifier() : super(null);

  void setIndexColorImage(int num) {
    state = num;
  }
}

final showNumberOfScrollImageProvider =
    StateNotifierProvider.autoDispose<ShowNumberOfScrollImageNotifier, int?>(
        (ref) {
  return ShowNumberOfScrollImageNotifier();
});

//////////////////////////////////////////////////////
final changeIndexOfSizeProvider =
    StateProvider.autoDispose.family<int?, int>((ref, productId) {
  return null;
});

//////////////////////////////////////////////////////////
final activatePrintingOnTheProductProvider =
    StateProvider.family<bool, String>((ref, productId) {
  return false;
});

/////////////////////////////////////////////////////////////
class ChangePriceNotifier extends StateNotifier<dynamic> {
  final ProductData productData;

  int? selectedIdColor;
  String? colorName;
  String? selectedSizeName;
  int? selectedIdSize;
  String? selectedNumber;
  int? selectedIdNumber;

  ChangePriceNotifier({
    required this.productData,
  }) : super(productData.price!);

  void setIdColor(int idColor) {
    selectedIdColor = idColor;
    updatePrice();
  }

  int getIdColor() {
    return selectedIdColor ?? 0;
  }

  void setNameColor(String nameColor) {
    colorName = nameColor;
  }

  String getNameColor() {
    return colorName ?? '';
  }

  void setNameSize(String nameSize) {
    selectedSizeName = nameSize;
    updatePrice();
  }

  dynamic getNameSize() {
    return selectedSizeName ?? '';
  }

  void setIdSize(int idSize) {
    selectedIdSize = idSize;
  }

  int getIdSize() {
    return selectedIdSize ?? 0;
  }

  void setIdNumber(int idSize) {
    selectedIdNumber = idSize;
  }

  int getIdNumber() {
    return selectedIdNumber ?? 0;
  }

  void setNumber(String number) {
    selectedNumber = number;
  }

  dynamic getNumber() {
    return selectedNumber ?? '';
  }

  bool noElement = false;

  void updatePrice() {
    try {
      if (productData.priceOptionType![0] == 'by_color') {
        final colorVariant = productData.colorsProduct?.firstWhere(
          (variant) => variant.idColor == selectedIdColor,
        );
        state = (colorVariant!.price == null || colorVariant.price == 0
            ? productData.price
            : colorVariant.price)!;
      } else if (productData.priceOptionType![0] == 'by_measuring') {
        final sizeVariant = productData.sizeProduct?.firstWhere(
          (variant) => variant.sizeTypeName == selectedSizeName,
        );
        state = sizeVariant?.price == null || sizeVariant?.price == 0
            ? productData.price
            : sizeVariant?.price;
      } else {
        final combinedVariant = productData.prices?.firstWhere(
          (variant) =>
              variant.colorId == selectedIdColor &&
              variant.sizeTypeName == selectedSizeName,
        );

        state = combinedVariant?.price == null || combinedVariant?.price == 0
            ? productData.price
            : combinedVariant?.price;
      }
    } catch (e) {
      state = productData.price!;
    }
  }
}

final changePriceProvider = StateNotifierProvider.autoDispose
    .family<ChangePriceNotifier, dynamic, ProductData>(
  (ref, productData) {
    return ChangePriceNotifier(productData: productData);
  },
);
