import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../services/auth/auth.dart';
import '../../../../productManagement/detailsProducts/presentation/state_mangment/riverpod_details.dart';
import '../../../../productManagement/wishlist/presentation/riverpod/wishlist_riverpod.dart';
import '../../../../shoppingBag/cart/presentation/riverpod/cart_riverpod.dart';

class AddToCartOrFavoritesWidget extends ConsumerWidget {
  const AddToCartOrFavoritesWidget({
    super.key,
    required this.productId,
    required this.onFavoriteLocalToggle,
    required this.isPrintable,
    this.showWishlistIcon = true,
    this.handleInvalidSelection,
    this.markSizeInvalid,
    this.markNumberInvalid,
    this.clearValidation,
  });

  final int productId;
  final bool showWishlistIcon;
  final VoidCallback onFavoriteLocalToggle;
  final bool Function(BuildContext context, WidgetRef ref, dynamic data)?
      handleInvalidSelection;
  final VoidCallback? markSizeInvalid;
  final VoidCallback? markNumberInvalid;
  final VoidCallback? clearValidation;
  final bool isPrintable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(detailsProvider(productId));
    final cartState = ref.watch(cartProvider);
    final wishlistState = ref.watch(wishlistProvider.notifier);

    return SafeArea(
      top: false,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 4.h),
        child: Row(
          children: [
            if (showWishlistIcon)
              IconButtonWidget(
                icon: details.data.favorite == true
                    ? AppIcons.wishlistActive
                    : AppIcons.wishlist,
                height: details.data.favorite == true ? 24.h : 21.h,
                onPressed: () {
                  if (!Auth().loggedIn) {
                    showFlashBarError(
                      context: context,
                      title: S.of(context).loginRequired,
                      text: S.of(context).pleaseLoginToContinue,
                    );
                    return;
                  }
                  onFavoriteLocalToggle();
                  if (details.data.favorite == true) {
                    wishlistState.addWishlist(productId: productId);
                  } else {
                    wishlistState.deleteWishlist(productsIds: [productId]);
                  }
                },
              ),
            if (showWishlistIcon) 4.w.horizontalSpace,
            Expanded(
              child: CheckStateInPostApiDataWidget(
                state: cartState,
                messageSuccess: S.of(context).productAddedToCartSuccessfully,
                functionSuccess: () {
                  if (isPrintable == true) {
                    ref
                        .read(activatePrintingOnTheProductProvider(
                                'details:$productId')
                            .notifier)
                        .state = false;
                  }
                },
                bottonWidget: DefaultButtonWidget(
                  text: S.of(context).addToCart,
                  background: AppColors.secondaryColor,
                  height: 38.h,
                  textSize: 12.4.sp,
                  isLoading: cartState.stateData == States.loading,
                  onPressed: () {
                    if (!Auth().loggedIn) {
                      showFlashBarError(
                        context: context,
                        title: S.of(context).loginRequired,
                        text: S.of(context).pleaseLoginToContinue,
                      );
                      return;
                    }
                    final notifier =
                        ref.read(changePriceProvider(details.data).notifier);
                    final price = ref.watch(changePriceProvider(details.data)) ??
                        details.data.price!;
                    final isPrintable = ref.watch(
                        activatePrintingOnTheProductProvider(
                            'details:$productId'));

                    final idColor = notifier.getIdColor();
                    final idSize = notifier.getIdSize();
                    final numberId = notifier.getIdNumber();
                    final needsSize = idSize == 0;
                    final needsNumber =
                        (details.data.numbersOfProduct?.isNotEmpty ?? false) &&
                            numberId == 0;

                    if (needsSize || needsNumber) {
                      if (handleInvalidSelection != null &&
                          handleInvalidSelection!(context, ref, details.data)) {
                        return;
                      }
                      if (needsSize) markSizeInvalid?.call();
                      if (needsNumber) markNumberInvalid?.call();
                      return;
                    }

                    clearValidation?.call();
                    ref.read(cartProvider.notifier).addToCart(
                          prodectId: productId,
                          colorId: idColor,
                          sizeId: idSize,
                          price: price,
                          quantity: 1,
                          numberId: numberId,
                          isPrintable: isPrintable ? 1 : 0,
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
