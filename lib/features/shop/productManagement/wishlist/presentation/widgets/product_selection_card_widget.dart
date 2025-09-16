import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/online_images_widget.dart';
import '../../../../../../core/widgets/price_and_currency_widget.dart';
import '../riverpod/wishlist_riverpod.dart';
import 'check_box_for_wishlist_widget.dart';

class ProductSelectionCardWidget extends ConsumerStatefulWidget {
  final int productId;
  final String image;
  final dynamic price;

  const ProductSelectionCardWidget({
    super.key,
    required this.productId,
    required this.image,
    required this.price,
  });

  @override
  ConsumerState<ProductSelectionCardWidget> createState() =>
      _ProductSelectionCardWidgetState();
}

class _ProductSelectionCardWidgetState
    extends ConsumerState<ProductSelectionCardWidget> {
  @override
  Widget build(BuildContext context) {
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
        toggleSelection();
      },
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                OnlineImagesWidget(
                  imageUrl: widget.image,
                  size: Size(double.infinity, 140.h),
                  borderRadius: 0,
                ),
                PositionedDirectional(
                  top: -4.h,
                  start: 4.w,
                  child: CheckBoxForWishlistWidget(
                    value: isChecked,
                    onChanged: (checked) {
                      toggleSelection();
                    },
                  ),
                ),
              ],
            ),
            6.h.verticalSpace,
            PriceAndCurrencyWidget(
              price: widget.price.toString(),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
