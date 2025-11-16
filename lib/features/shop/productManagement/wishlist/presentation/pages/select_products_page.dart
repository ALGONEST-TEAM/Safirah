import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/bottomNavbar/button_bottom_navigation_bar_design_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';
import '../riverpod/wishlist_riverpod.dart';
import '../widgets/app_bar_select_products_widget.dart';
import '../widgets/check_box_for_wishlist_widget.dart';
import '../widgets/product_selection_card_widget.dart';

class SelectProductsPage extends ConsumerStatefulWidget {
  final int? listId;
  final String? listName;
  final bool addGoods;

  const SelectProductsPage({
    super.key,
    this.listId,
    this.listName,
    this.addGoods = false,
  });

  @override
  ConsumerState<SelectProductsPage> createState() => _SelectProductsPageState();
}

class _SelectProductsPageState extends ConsumerState<SelectProductsPage> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(getAllWishesProductsProvider);
    var wishlistState = ref.watch(wishlistProvider);
    var wishlistStateNotifier = ref.watch(wishlistProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarSelectProductsWidget(
        listName: widget.listName,
        addGoods: widget.addGoods,
      ),
      body: Column(
        children: [
          Divider(
            color: AppColors.greySwatch.shade200,
            height: 0.6.h,
          ),
          Expanded(
            child: MasonryGridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(14.sp),
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 14.0,
              gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                return ProductSelectionCardWidget(
                  productId: state.data[index].id!,
                  image: state.data[index].mainImage![0],
                  price: state.data[index].price,
                );
              },
              itemCount: state.data.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: ButtonBottomNavigationBarDesignWidget(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CheckBoxForWishlistWidget(
                  value: wishlistStateNotifier.isAllWishlistProductsSelected(
                    ref
                        .read(getAllWishesProductsProvider)
                        .data
                        .map((product) => product.id)
                        .whereType<int>()
                        .toList(),
                  ),
                  fillColor: Colors.white,
                  borderColor: Colors.black26,
                  onChanged: (isChecked) {
                    wishlistStateNotifier.toggleAllWishlistProductsSelection(
                      isChecked ?? false,
                      ref
                          .read(getAllWishesProductsProvider)
                          .data
                          .map((product) => product.id)
                          .whereType<int>()
                          .toList(),
                    );
                  },
                ),
                4.w.horizontalSpace,
                AutoSizeTextWidget(
                  text: S.of(context).all,
                  colorText: Colors.black87,
                  fontSize: 10.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
            CheckStateInPostApiDataWidget(
              state: wishlistState,
              messageSuccess: widget.addGoods
                  ? S.of(context).productsHaveBeenAddedToTheList
                  : S.of(context).aNewListHasBeenCreatedSuccessfully,
              functionSuccess: () {
                if (widget.addGoods) {
                  ref.invalidate(getProductsByListProvider(widget.listId!));
                }
                ref.invalidate(getAllListProvider);
                Navigator.of(context).pop();
              },
              bottonWidget: DefaultButtonWidget(
                text: S.of(context).addToList,
                width: 120.w,
                height: 30.h,
                textSize: 9.4.sp,
                minFontSize: 6,
                background: wishlistStateNotifier.selectedWishlist.isEmpty
                    ? AppColors.greySwatch.shade400
                    : AppColors.secondaryColor,
                isLoading: wishlistState.stateData == States.loading,
                onPressed: wishlistStateNotifier.selectedWishlist.isEmpty
                    ? null
                    : () {
                        wishlistStateNotifier.createAnewListAndAddProducts(
                          listId: widget.addGoods ? widget.listId! : 0,
                          listName:
                              widget.addGoods ? "" : widget.listName.toString(),
                          productsIds: wishlistStateNotifier.selectedWishlist,
                        );
                      },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
