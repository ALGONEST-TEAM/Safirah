import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/online_images_widget.dart';
import '../riverpod/cart_riverpod.dart';
import 'cancel_printing_widget.dart';
import 'check_box_for_cart_products_widget.dart';
import 'color_and_size_design_for_cart_card_widget.dart';
import 'product_price_and_discount_in_the_cart_widget.dart';
import 'quantity_widget.dart';

class CartCardWidget extends ConsumerWidget {
  final int productId;
  final int? loadingId;
  final Function onDelete;
  final Function(int) onUpdateQuantity;
  final VoidCallback onCancelPrinting;

  const CartCardWidget({
    super.key,
    required this.productId,
    required this.loadingId,
    required this.onDelete,
    required this.onUpdateQuantity,
    required this.onCancelPrinting,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cartProductState = ref.watch(cartProductProvider(productId));
    var cartStateNotifier = ref.watch(cartProvider.notifier);

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .02),
            blurRadius: 1.r,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          1.6.w.horizontalSpace,
          CheckBoxForCartProductsWidget(
            value: cartStateNotifier.selectedProducts
                .any((product) => product.id == cartProductState.id),
            onChanged: (isChecked) {
              cartStateNotifier.toggleProductSelection(
                isChecked ?? false,
                cartProductState,
              );
            },
          ),
          OnlineImagesWidget(
            imageUrl: cartProductState.images.toString(),
            size: Size(90.w, 82.h),
            fit: BoxFit.cover,
            borderRadius: 8.r,
          ),
          8.w.horizontalSpace,
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: AutoSizeTextWidget(
                        text: cartProductState.productName.toString(),
                        maxLines: 2,
                        fontSize: 11.6.sp,
                        minFontSize: 10,
                        colorText: AppColors.mainColorFont,
                      ),
                    ),
                    2.w.horizontalSpace,
                    Visibility(
                      visible: cartProductState.isPrintable == 1,
                      child: CancelPrintingWidget(onConfirm: onCancelPrinting),
                    ),
                  ],
                ),
                8.h.verticalSpace,
                ColorAndSizeDesignForCartCardWidget(
                  id: cartProductState.id,
                  productId: cartProductState.productId!,
                  sizeId: cartProductState.sizeId,
                  colorId: cartProductState.colorId,
                  colorHex: cartProductState.colorHex!,
                  colorName: cartProductState.colorName.toString(),
                  sizeName: cartProductState.sizeName.toString(),
                  numberId: cartProductState.numberId,
                  numberName: cartProductState.numberName,
                  quantity: cartProductState.quantity!,
                  isPrintable: cartProductState.isPrintable ?? 0,
                  onSuccess: () {
                    ref
                        .read(cartProductProvider(productId).notifier)
                        .updateProduct(
                          cartProductState
                              .updateCartProduct(ref.read(cartProvider).data),
                        );
                    if (cartStateNotifier.selectedProducts
                        .any((product) => product.id == cartProductState.id)) {
                      cartStateNotifier.updateSelectedProduct(cartProductState
                          .updateCartProduct(ref.read(cartProvider).data));
                    }

                    Navigator.of(context).pop();
                  },
                ),
                8.h.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProductPriceAndDiscountInTheCartWidget(
                      price: (double.parse(cartProductState.price.toString()) *
                              cartProductState.quantity!)
                          .toString(),
                      productPriceAfterDiscount: (double.parse(cartProductState
                                  .productPriceAfterDiscount
                                  .toString()) *
                              cartProductState.quantity!)
                          .toString(),
                      discount: cartProductState.discount,
                    ),
                    4.w.horizontalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          child: SvgPicture.asset(
                            AppIcons.cartMinus,
                            height: 21.h,
                          ),
                          onTap: () {
                            if (cartProductState.quantity! > 1) {
                              onUpdateQuantity(cartProductState.quantity! - 1);
                            }
                          },
                        ),
                        QuantityWidget(
                          quantity: cartProductState.quantity.toString(),
                          isLoading: ref.watch(cartProvider).stateData ==
                                  States.loading &&
                              loadingId == cartProductState.id,
                        ),
                        InkWell(
                          child: SvgPicture.asset(
                            AppIcons.cartPlus,
                            height: 21.h,
                          ),
                          onTap: () {
                            onUpdateQuantity(cartProductState.quantity! + 1);
                          },
                        ),
                      ],
                    ),
                    4.w.horizontalSpace,
                    InkWell(
                      child: SvgPicture.asset(
                        AppIcons.cartDelete,
                        height: 21.h,
                      ),
                      onTap: () {
                        onDelete();
                      },
                    ),
                    2.w.horizontalSpace,
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
