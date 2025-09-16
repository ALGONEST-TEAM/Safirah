import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/bottomNavbar/button_bottom_navigation_bar_design_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../riverpod/wishlist_riverpod.dart';
import '../widgets/add_or_copy_to_the_list_dialog_widget.dart';
import '../widgets/app_bar_for_wishlist_widget.dart';
import '../widgets/check_box_for_wishlist_widget.dart';
import '../widgets/delete_selected_products_button_widget.dart';
import '../widgets/masonry_grid_view_for_products_by_list_widget.dart';
import '../widgets/list_of_wishes_products_widget.dart';

class SelectItemsFromTheWishlistPage extends ConsumerWidget {
  final bool selectProductsByList;
  final int? listId;
  final String? listName;
  final int? productId;

  const SelectItemsFromTheWishlistPage({
    super.key,
    this.selectProductsByList = false,
    this.listId,
    this.listName,
    this.productId,
  });

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(wishlistProvider);
    var wishlistStateNotifier = ref.watch(wishlistProvider.notifier);

    return Scaffold(
      appBar: AppBarForWishlistWidget(
        showCancelButton: true,
        centerTitle: selectProductsByList ? false : true,
        title: listName,
      ),
      body: selectProductsByList
          ? MasonryGridViewForProductsByListWidget(
              listId: listId!,
              viewSelectionOfWishlist: true,
            )
          : const ListOfWishesProductsWidget(viewSelectionOfWishlist: true),
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
                // 4.w.horizontalSpace,
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DeleteSelectedProductsButtonWidget(
                    listId: listId ?? 0,
                    selectProductsByList: selectProductsByList,
                  ),
                  2.w.horizontalSpace,
                  DefaultButtonWidget(
                    text: selectProductsByList
                        ? S.of(context).copyToList
                        : S.of(context).addToList,
                    width: 120.w,
                    height: 30.h,
                    textSize: 9.4.sp,
                    minFontSize: 6,
                    borderRadius: 4.r,
                    background: wishlistStateNotifier.selectedWishlist.isEmpty
                        ? AppColors.greySwatch.shade400
                        : AppColors.secondaryColor,
                    onPressed: wishlistStateNotifier.selectedWishlist.isEmpty
                        ? null
                        : () {
                            showModalBottomSheetWidget(
                              backgroundColor: Colors.transparent,
                              context: context,
                              page: AddOrCopyToTheListDialogWidget(listId: listId),
                            );
                          },
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
