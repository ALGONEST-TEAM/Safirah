import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import '../../../../../../core/widgets/online_images_widget.dart';
import '../../../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../shoppingBag/cart/presentation/pages/add_to_cart_page.dart';
import '../../../detailsProducts/presentation/page/details_page.dart';
import '../../../detailsProducts/presentation/state_mangment/riverpod_details.dart';
import '../riverpod/wishlist_riverpod.dart';
import 'check_box_for_wishlist_widget.dart';

class WishesProductCardWidget extends ConsumerStatefulWidget {
  final bool viewSelectionOfWishlist;
  final int productId;
  final String image;
  final String name;
  final dynamic price;
  final bool deleteProductFromTheList;
  final int? listId;

  const WishesProductCardWidget({
    super.key,
    this.viewSelectionOfWishlist = false,
    required this.productId,
    required this.image,
    required this.name,
    required this.price,
    this.deleteProductFromTheList = false,
    this.listId,
  });

  @override
  ConsumerState<WishesProductCardWidget> createState() => _WishesProductCardWidgetState();
}

class _WishesProductCardWidgetState extends ConsumerState<WishesProductCardWidget> {
  bool _delete = false;

  @override
  Widget build(BuildContext context) {
    var wishlistState = ref.watch(wishlistProvider);
    var wishlistStateNotifier = ref.watch(wishlistProvider.notifier);
    bool isChecked =
        wishlistStateNotifier.selectedWishlist.contains(widget.productId);

    void toggleSelection() {
      wishlistStateNotifier.toggleWishlistProductsSelection(
        !isChecked,
        widget.productId,
      );
      setState(() {
        isChecked = !isChecked;
      });
    }

    return GestureDetector(
      onTap: () {
        if (widget.viewSelectionOfWishlist) {
          toggleSelection();
        } else {
          setState(() => _delete = false);
          navigateTo(
            context,
            DetailsPage(
              idProduct: widget.productId,
              price: widget.price,
              name: widget.name,
              image: [widget.image],
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .01),
              blurRadius: 1.r,
            ),
          ],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4.r),
                  topRight: Radius.circular(4.r)),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.r),
                      topLeft: Radius.circular(8.r),
                    ),
                    child: OnlineImagesWidget(
                      imageUrl: widget.image,
                      size: Size(double.infinity, 150.h),
                      borderRadius: 0,
                    ),
                  ),
                  Visibility(
                    visible: widget.viewSelectionOfWishlist,
                    child: PositionedDirectional(
                      top: -4.h,
                      start: 4.w,
                      child: CheckBoxForWishlistWidget(
                        value: isChecked,
                        onChanged: (checked) {
                          toggleSelection();
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _delete,
                    child: Container(
                      color: Colors.black54,
                      height: 150.h,
                      width: double.infinity,
                      child: Center(
                        child: CheckStateInPostApiDataWidget(
                          state: wishlistState,
                          hasMessageSuccess: true,
                          messageSuccess: S.of(context).deletedSuccessfully,
                          functionSuccess: () {
                            if (widget.deleteProductFromTheList) {
                              ref.refresh(
                                  getProductsByListProvider(widget.listId!));
                              ref.refresh(getAllListProvider);
                            } else {
                              ref.refresh(getAllWishesProductsProvider);
                              ref.refresh(getAllListProvider);
                              ref.refresh(detailsProvider(widget.productId));
                            }
                          },
                          bottonWidget: DefaultButtonWidget(
                            text: S.of(context).delete,
                            textSize: 9.5.sp,
                            height: 28.h,
                            width: 140.w,
                            borderRadius: 3.r,
                            isLoading:
                                wishlistState.stateData == States.loading,
                            onPressed: () {
                              if (widget.deleteProductFromTheList) {
                                wishlistStateNotifier.deleteListProducts(
                                  listId: widget.listId!,
                                  productsIds: [widget.productId],
                                );
                              } else {
                                wishlistStateNotifier.deleteWishlist(
                                  productsIds: [widget.productId],
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.sp),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AutoSizeTextWidget(
                          text: widget.name.toString(),
                          maxLines: 2,
                          fontSize: 11.4.sp,
                          colorText: AppColors.mainColorFont,
                          minFontSize: 8,
                        ),
                      ),
                      InkWellButtonWidget(
                        icon: AppIcons.cartActive,
                        iconColor: AppColors.secondaryColor,
                        onPressed: () {
                          showModalBottomSheetWidget(
                            backgroundColor: Colors.transparent,
                            context: context,
                            page: AddToCartPage(
                              productId: widget.productId,
                              showWishlistIcon: false,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  3.h.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child:   PriceAndCurrencyWidget(
                          price: widget.price.toString(),
                          fontSize1: 12.2.sp,
                          fontSize2: 10.6.sp,
                          maxLines: 2,
                        ),
                      ),
                      widget.viewSelectionOfWishlist
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  _delete = !_delete;
                                });
                              },
                              child: Icon(
                                Icons.more_horiz,
                                size: 18.r,
                                color: AppColors.secondaryColor.withValues(alpha: .6),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
