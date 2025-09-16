import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../services/auth/auth.dart';
import '../../../../productManagement/detailsProducts/presentation/state_mangment/riverpod_details.dart';
import '../../../../productManagement/wishlist/presentation/riverpod/wishlist_riverpod.dart';
import '../riverpod/cart_riverpod.dart';
import '../widgets/loading_design_to_display_product_details_to_add_to_cart_widget.dart';
import '../widgets/name_description_and_price_of_the_product_widget.dart';
import '../widgets/photo_list_widget.dart';
import '../widgets/product_colors_widget.dart';
import '../widgets/products_sizes_widget.dart';

class AddToCartPage extends ConsumerStatefulWidget {
  final int productId;
  final bool showWishlistIcon;
  final bool pop;

  const AddToCartPage({
    super.key,
    required this.productId,
    this.showWishlistIcon = true,
    this.pop = true,
  });

  @override
  ConsumerState<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends ConsumerState<AddToCartPage> {
  int mainIndex = 0;
  bool isMainInitialized = false;
  bool isSizeIdValid = false;
  int quantity = 1;
  dynamic _colorId;
  String _colorName = '';
  int _sizeId = 0;
  dynamic _sizeTypeName = '';

  /// تحديد اللون الأساسي عند تحميل الصفحة لأول مرة
  void _initializeMainColor(data) {
    if (!isMainInitialized && data.colorsProduct!.isNotEmpty) {
      // mainIndex = data.colorsProduct!.indexWhere((color) => color.isMain == 1);
      _colorId = data.colorsProduct![0].idColor;
      _colorName = data.colorsProduct![0].colorName!;
      isMainInitialized = true;
    }
  }

  /// Checks if there is only one available size in the product,
  /// and if so, selects it automatically by assigning its ID and type.
  void _autoSelectSingleSize(data) {
    if (data.sizeProduct!.isNotEmpty && data.sizeProduct!.length == 1) {
      _sizeId = data.sizeProduct![0].id!;
      _sizeTypeName = data.sizeProduct![0].sizeTypeName;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(detailsProvider(widget.productId));
    var cartState = ref.watch(cartProvider);
    var wishlistState = ref.watch(wishlistProvider.notifier);

    return Container(
      margin: EdgeInsets.only(top: 140.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.sp),
          topRight: Radius.circular(8.sp),
        ),
      ),
      child: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfLoading:
            const LoadingDesignToDisplayProductDetailsToAddToCartWidget(),
        widgetOfData: Consumer(
          builder: (context, ref, child) {
            _initializeMainColor(state.data);
            _autoSelectSingleSize(state.data);

            var price = ref.watch(changePriceProvider(state.data));

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      if (state.data.colorsProduct!.isNotEmpty ||
                          state.data.allImage!.isNotEmpty)
                        PhotoListWidget(
                          image: state.data.colorHasImage == false
                              ? state.data.allImage!
                              : state.data.colorsProduct![mainIndex].image!,
                        ),
                      NameDescriptionAndPriceOfTheProductWidget(
                        idProduct: state.data.id!,
                        image: state.data.allImage,
                        name: state.data.name.toString(),
                        description: state.data.description.toString(),
                        price: price ?? state.data.price!,
                      ),
                      if (state.data.colorsProduct!.isNotEmpty)
                        ProductColorsWidget(
                          productsColors: state.data.colorsProduct!,
                          colorId: _colorId,
                          colorName: _colorName,
                          onSelect: (int colorId, int index, String colorName) {
                            setState(() {
                              _colorId = colorId;
                              mainIndex = index;
                              _colorName = colorName;
                            });
                            ref
                                .read(changePriceProvider(state.data).notifier)
                                .setIdColor(colorId);
                          },
                        ),
                      if (isSizeIdValid)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 4.h),
                          child: AutoSizeTextWidget(
                            text: state.data.measuringType!.isNotEmpty &&
                                    state.data.measuringType![0] == "unit"
                                ? S.of(context).pleaseSelectAUnit
                                : S.of(context).pleaseSelectASize,
                            fontSize: 11.4.sp,
                            fontWeight: FontWeight.w600,
                            colorText: AppColors.secondarySwatch.shade500,
                          ),
                        ),
                      ProductsSizesWidget(
                        data: state.data,
                        sizeId: _sizeId,
                        sizeTypeName: _sizeTypeName,
                        onSelect: (int sizeId, String sizeTypeName) {
                          setState(() {
                            _sizeId = sizeId;
                            _sizeTypeName = sizeTypeName;
                            isSizeIdValid = false;
                          });
                          ref
                              .read(changePriceProvider(state.data).notifier)
                              .setNameSize(sizeTypeName);
                        },
                        onCounterChanged: (int value) {
                          setState(() {
                            quantity = value;
                          });
                        },
                      ),
                      10.h.verticalSpace,
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    children: [
                      widget.showWishlistIcon
                          ? IconButtonWidget(
                              icon: state.data.favorite == true
                                  ? AppIcons.wishlistActive
                                  : AppIcons.wishlist,
                              height: state.data.favorite == true ? 24.h : 21.h,
                              onPressed: () {
                                if (!Auth().loggedIn) {
                                  pressAgainToExit(
                                    context: context,
                                    text: S.of(context).loginRequired,
                                  );
                                } else {
                                  setState(() => state.data.favorite =
                                      !state.data.favorite!);
                                  if (state.data.favorite == true) {
                                    wishlistState.addWishlist(
                                      productId: widget.productId,
                                    );
                                  } else {
                                    wishlistState.deleteWishlist(
                                      productsIds: [widget.productId],
                                    );
                                  }
                                }
                              },
                            )
                          : const SizedBox.shrink(),
                      widget.showWishlistIcon
                          ? 4.w.horizontalSpace
                          : 0.horizontalSpace,
                      Expanded(
                        child: CheckStateInPostApiDataWidget(
                          state: cartState,
                          messageSuccess: 'تمت اضافة المنتج الى السلة بنجاح',
                          functionSuccess: () {
                            if (widget.pop) {
                              Navigator.of(context).pop();
                            }
                          },
                          bottonWidget: DefaultButtonWidget(
                            text: S.of(context).addToCart,
                            background: AppColors.secondaryColor,
                            height: 38.h,
                            textSize: 12.sp,
                            isLoading: cartState.stateData == States.loading,
                            onPressed: () {
                              if (_sizeId == 0) {
                                setState(() => isSizeIdValid = true);
                              } else {
                                ref.read(cartProvider.notifier).addToCart(
                                      prodectId: widget.productId,
                                      colorId: _colorId,
                                      sizeId: _sizeId,
                                      price: price ?? state.data.price!,
                                      quantity: 1,
                                    );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
