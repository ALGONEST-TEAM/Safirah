import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../../../core/state/data_state.dart';
import '../../../../../../core/state/state.dart';
import '../../data/model/color_data.dart';
import '../../data/model/product_data.dart';
import '../../data/model/size_data.dart';
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
class ChangeIndexOfColorImageNotifier extends StateNotifier<int?> {
  ChangeIndexOfColorImageNotifier() : super(0);

  void setIndexColorImage(int index) {
    state = index;
  }
}

final changeIndexOfColorImageProvider =
    StateNotifierProvider.autoDispose<ChangeIndexOfColorImageNotifier, int?>(
        (ref) {
  return ChangeIndexOfColorImageNotifier();
});

//////////////////////////////////////////////////////////////////////////////////////
class NameOfColorForChangePriceNotifier extends StateNotifier<String?> {
  NameOfColorForChangePriceNotifier() : super("");

  void setNameColor(String nameColor) {
    state = nameColor;
  }
}

final nameOfColorForChangePriceProvider = StateNotifierProvider.autoDispose<
    NameOfColorForChangePriceNotifier, String?>((ref) {
  return NameOfColorForChangePriceNotifier();
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

class ChangePriceNotifier extends StateNotifier<dynamic> {
  final ProductData productData;

  int? selectedColor;
  String? selectedSize;
  String? colorName;

  int? selectedIdSize;

  ChangePriceNotifier({
    required this.productData,
  }) : super(productData.price!);

  void setIdColor(int idColor) {
    selectedColor = idColor;
    updatePrice();
  }

  int getIdColor() {
    return selectedColor ?? 0;
  }

  // تحديث اسم اللون
  void setNameColor(String nameColor) {
    colorName = nameColor;
  }

  String getNameColor() {
    return colorName ?? '';
  }

  // تحديث اسم القياس
  void setNameSize(String nameSize) {
    selectedSize = nameSize;
    updatePrice();
  }

  dynamic getNameSize() {
    return selectedSize ?? '';
  }

  void setIdSize(int idSize) {
    selectedIdSize = idSize;
  }

  int getIdSize() {
    return selectedIdSize ?? 0;
  }

  bool noElement = false;

  void updatePrice() {
    try {
      if (productData.priceOptionType![0] == 'by_color') {
        final colorVariant = productData.colorsProduct?.firstWhere(
          (variant) => variant.idColor == selectedColor,
        );
        state = (colorVariant!.price == null || colorVariant.price == 0
            ? productData.price
            : colorVariant.price)!;
      } else if (productData.priceOptionType![0] == 'by_measuring') {
        final sizeVariant = productData.sizeProduct?.firstWhere(
          (variant) => variant.sizeTypeName == selectedSize,
        );
        state = sizeVariant?.price == null || sizeVariant?.price == 0
            ? productData.price
            : sizeVariant?.price;
      } else {
        final combinedVariant = productData.prices?.firstWhere(
          (variant) =>
              variant.colorId == selectedColor &&
              variant.sizeTypeName == selectedSize,
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
