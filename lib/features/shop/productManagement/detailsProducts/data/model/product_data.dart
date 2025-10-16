import 'package:hive/hive.dart';
import '../../../reviews/data/model/review_data.dart';
import '../../../reviews/data/model/reviews_model.dart';
import 'color_data.dart';
import 'copon_data.dart';
import 'details_product_data.dart';
import 'discount_model.dart';
import 'number_model.dart';
import 'price_model.dart';
import 'size_data.dart';

part 'product_data.g.dart';

@HiveType(typeId: 5)
class ProductData {
  // الأساسيات
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final dynamic price;
  @HiveField(3)
  final int? categoryId;
  @HiveField(5)
  final String? description;
  final bool? isPrintable;

  // الصور
  @HiveField(9)
  final List<String>? mainImage;
  final List<String>? allImage;
  final bool? colorHasImage;

  //  الألوان والمقاسات والأرقام
  @HiveField(14)
  final List<ColorOfProductData>? colorsProduct;
  @HiveField(15)
  final int? productColorsCount;
  final int? sizeType;
  final List<SizeData>? sizeProduct;
  final List<String>? measuringType;
  final List<NumberModel>? numbersOfProduct;

  // تفاصيل المنتج
  final List<DetailsProductData>? detailsProduct;

  // الأسعار والخصومات
  @HiveField(4)
  final String? discount;
  @HiveField(11)
  final DiscountModel? discountModel;
  @HiveField(12)
  final dynamic priceAfterDiscount;
  @HiveField(13)
  final dynamic coponPrice;
  final List<dynamic>? priceOptionType;
  final List<PriceData>? prices;
  final String? productPrintingPrice;

  // الكوبونات
  final List<CoponData>? coponData;

  // مفضلة
  bool? favorite;

  // التقييمات والتعليقات
  final ReviewsModel? reviews;
  final List<ReviewData>? productReviews;
  @HiveField(16)
  final num? averageRate;

  ProductData({
    this.id,
    this.name,
    this.price,
    this.categoryId,
    this.description,
    this.isPrintable,
    this.mainImage,
    this.allImage,
    this.colorHasImage,
    this.colorsProduct,
    this.productColorsCount,
    this.sizeType,
    this.sizeProduct,
    this.measuringType,
    this.numbersOfProduct,
    this.detailsProduct,
    this.discount,
    this.discountModel,
    this.priceAfterDiscount,
    this.coponPrice,
    this.priceOptionType,
    this.prices,
    this.productPrintingPrice,
    this.coponData,
    this.favorite,
    this.reviews,
    this.productReviews,
    this.averageRate,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    return ProductData(
      // الأساسيات
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      price: json['base_price'] ?? 0.0,
      categoryId: json['category_id'] ?? 0,
      description: json['description'] ?? "",
      isPrintable: json['is_printable'] ?? false,

      // الصور
      mainImage: List<String>.from(
          json['main_imags']?.map((item) => item['image']) ?? []),
      allImage: List<String>.from(
          json['all_images']?.map((item) => item['image']) ?? []),
      colorHasImage: json['color_has_imgs'],

      // الألوان والمقاسات والأرقام
      colorsProduct:
          ColorOfProductData.fromJsonColorList(json['product_colors'] ?? []),
      productColorsCount: json['product_colors_count'] ?? 0,
      sizeType: json['size_type_id'] ?? 0,
      sizeProduct: SizeData.fromJsonSizeList(json['size_type_details'] ?? []),
      measuringType: List<String>.from(json['measuring_type'] ?? []),
      numbersOfProduct:
          NumberModel.fromJsonNumbersList(json['number_of_product'] ?? []),

      // تفاصيل المنتج
      detailsProduct: DetailsProductData.fromJsonDetailsProductList(
          json['product_details'] ?? []),

      // الأسعار والخصومات
      discount: json['discount_price'] ?? "0",
      discountModel: json['discount'] != null
          ? DiscountModel.fromJson(json['discount'])
          : null,
      priceAfterDiscount: json['base_price_after_discount'],
      coponPrice: json['coupon'] ?? 0,
      priceOptionType: List<String>.from(json['price_options_type'] ?? []),
      prices: PriceData.fromJsonPriceList(json['optionPrices'] ?? []),
      productPrintingPrice: json['product_printing_price'] ?? '',

      // الكوبونات
      coponData: CoponData.fromJsonCoponData(json['coupons'] ?? []),

      // مفضلة
      favorite: json['favorite'],

      // التقييمات والتعليقات
      reviews: json['proportion_statistics'] == null
          ? ReviewsModel.empty()
          : ReviewsModel.fromJson(
              json['proportion_statistics'] as Map<String, dynamic>,
            ),
      averageRate: json['avrage_rate'] ?? 0.0,
      productReviews: ReviewData.fromJsonList(json['product_reviews'] ?? []),
    );
  }

  static List<ProductData> fromJsonProductList(List<dynamic> json) {
    return json.map((e) => ProductData.fromJson(e)).toList();
  }

  factory ProductData.empty() => ProductData(
        id: 0,
        name: "",
        price: 0,
        categoryId: 0,
        coponData: [],
      );
}
