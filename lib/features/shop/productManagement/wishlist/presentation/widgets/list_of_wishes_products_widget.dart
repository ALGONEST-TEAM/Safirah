import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../riverpod/wishlist_riverpod.dart';
import 'empty_wishes_products_widget.dart';
import 'shimmer_wish_products_widget.dart';
import 'wishes_product_card_widget.dart';

class ListOfWishesProductsWidget extends ConsumerWidget {
  final bool viewSelectionOfWishlist;

  const ListOfWishesProductsWidget({super.key, this.viewSelectionOfWishlist = false});

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(getAllWishesProductsProvider);
    return RefreshIndicator(
      color: AppColors.primaryColor,
      backgroundColor: Colors.white,
      onRefresh: () async {
        ref.invalidate(getAllWishesProductsProvider);
      },
      child: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfLoading: const ShimmerWishProductsWidget(),
        widgetOfData: state.data.isEmpty
            ? const EmptyWishesProductsWidget()
            : MasonryGridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(12.sp),
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 10.0,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  return WishesProductCardWidget(
                    viewSelectionOfWishlist: viewSelectionOfWishlist,
                    productId: state.data[index].id!,
                    image:state.data[index].mainImage?.isNotEmpty == true
                        ?  state.data[index].mainImage![0]:'',
                    name: state.data[index].name.toString(),
                    price: state.data[index].price,
                  );
                },
                itemCount: state.data.length,
              ),
      ),
    );
  }
}
