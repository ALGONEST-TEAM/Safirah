import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import 'color_data.dart';
import 'copon_data.dart';
import 'details_product_data.dart';
import 'discount_model.dart';
import 'price_model.dart';
import 'size_data.dart';

part 'product_data.g.dart';

@HiveType(typeId: 5)
class ProductData {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final dynamic price;
  @HiveField(3)
  final int? categoryId;
  @HiveField(4)
  final String? discount;
  @HiveField(5)
  final String? description;
  @HiveField(6)
  final String? currency;
  final int? sizeType;
  final List<DetailsProductData>? detailsProduct;
  final List<ColorOfProductData>? colorsProduct;
  bool? favorite;
  @HiveField(9)
  final List<String>? mainImage;
  final List<SizeData>? sizeProduct;
  final List<String>? allImage;
  final List<dynamic>? priceOptionType;
  final List<PriceData>? prices;
  final bool? colorHasImage;
  final List<String>? measuringType;

  final List<CoponData>? coponData;
  @HiveField(11)
  final DiscountModel? discountModel;
  @HiveField(12)
  final dynamic priceAfterDiscount;
  @HiveField(13)
  final dynamic coponPrice;

  ProductData({
    this.id,
    this.name,
    this.price,
    this.categoryId,
    this.discount,
    this.description,
    this.currency,
    this.sizeType,
    this.detailsProduct,
    this.colorsProduct,
    this.sizeProduct,
    this.allImage,
    this.priceOptionType,
    this.prices,
    this.mainImage,
    this.colorHasImage,
    this.measuringType,
    this.favorite,
    this.coponData,
    this.discountModel,
    this.priceAfterDiscount,
    this.coponPrice,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      price: json['base_price'] ?? 0.0,
      categoryId: json['category_id'] ?? 0,
      discount: json['discount_price'] ?? "0",
      description: json['description'] ?? "",
      currency: json['currency'] ?? "",
      sizeType: json['size_type_id'] ?? 0,
      favorite: json['favorite'],
      detailsProduct: DetailsProductData.fromJsonDetailsProductList(
          json['product_details'] ?? []),
      colorsProduct:
          ColorOfProductData.fromJsonColorList(json['product_colors'] ?? []),
      sizeProduct: SizeData.fromJsonSizeList(json['size_type_details'] ?? []),
      mainImage: List<String>.from(
          json['main_imags']?.map((item) => item['image']) ?? []),
      allImage: List<String>.from(
          json['all_images']?.map((item) => item['image']) ?? []),
      priceOptionType: List<String>.from(json['price_options_type'] ?? []),
      prices: PriceData.fromJsonPriceList(json['optionPrices'] ?? []),
      colorHasImage: json['color_has_imgs'],
      measuringType: List<String>.from(json['measuring_type'] ?? []),
      discountModel: json['discount'] != null
          ? DiscountModel.fromJson(json['discount'])
          : null,
      coponData: CoponData.fromJsonCoponData(json['coupons'] ?? []),
      priceAfterDiscount: json['base_price_after_discount'],
      coponPrice: json['coupon'] ?? 0,
    );
  }

  static List<ProductData> fromJsonProductList(List<dynamic> json) {
    return json.map((e) => ProductData.fromJson(e)).toList();
  }

  factory ProductData.empty() => ProductData(
        name: "",
        price: 0,
        id: 0,
        categoryId: 0,
        coponData: [],
      );

  static final fakeProductData = List.filled(
    6,
    ProductData(
      name: "فستان مشجر",
      id: 0,
      price: 1000,
      mainImage: [
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
      ],
      allImage: [
        ' https://dash-jeeey.dev-station.com/storage/300/product-images-(4).jpg',
      ],
      measuringType: [''],
      colorHasImage: false,
      discount: '',
      detailsProduct: [DetailsProductData(detailName: '', detailValue: '')],
      sizeType: 0,
      priceOptionType: [],
      favorite: true,
      categoryId: 1,
      sizeProduct: [SizeData(id: 1, price: 100, sizeTypeName: 'l')],
      prices: [],
      colorsProduct: [
        ColorOfProductData(
            idColor: 1,
            isMain: 0,
            price: '',
            colorName: '',
            image: [
              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg'
            ],
            colorHex: '#ff9dfd'),
        ColorOfProductData(
          idColor: 1,
          isMain: 0,
          price: '',
          colorName: '',
          image: [
            'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg'
          ],
          colorHex: '#ff9dfd',
        )
      ],
      description: 'hh',
      coponData: [],
    ),
  );
}
