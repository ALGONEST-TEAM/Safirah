import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../riverpod/wishlist_riverpod.dart';
import 'wishes_product_card_widget.dart';

class MasonryGridViewForProductsByListWidget extends ConsumerWidget {
  final int listId;
  final bool viewSelectionOfWishlist;

  const MasonryGridViewForProductsByListWidget({
    super.key,
    required this.listId,
    this.viewSelectionOfWishlist = false,
  });

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(getProductsByListProvider(listId));

    return MasonryGridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(14.sp),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return WishesProductCardWidget(
          viewSelectionOfWishlist: viewSelectionOfWishlist,
          productId: state.data[index].id!,
          image: state.data[index].mainImage![0],
          name: state.data[index].name.toString(),
          price: state.data[index].price,
          deleteProductFromTheList: true,
          listId: listId,
        );
      },
      itemCount: state.data.length,
    );
  }
}
