import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/logo_shimmer_widget.dart';
import '../riverpod/wishlist_riverpod.dart';
import '../widgets/add_goods_widget.dart';
import '../widgets/app_bar_for_wishlist_widget.dart';
import '../widgets/masonry_grid_view_for_products_by_list_widget.dart';
import '../widgets/products_by_list_is_empty_widget.dart';
import 'select_products_page.dart';

class ProductsByListPage extends ConsumerWidget {
  final int listId;
  final String listName;

  ProductsByListPage({
    super.key,
    required this.listId,
    required this.listName,
  });

  final ValueNotifier<bool> _showIcon = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _hideIcon = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(getProductsByListProvider(listId));
    var wishlistStateNotifier = ref.watch(wishlistProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarForWishlistWidget(
        title: listName,
        centerTitle: false,
        showMultipleChoiceIcon: state.stateData == States.loading ||
                state.stateData == States.error ||
                state.data.isEmpty
            ? _hideIcon
            : _showIcon,
        selectProductsByList: true,
        listId: listId,
        // listName: listName,
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          ref.refresh(getProductsByListProvider(listId));
        },
        child: CheckStateInGetApiDataWidget(
          state: state,
          widgetOfLoading: const LogoShimmerWidget(),
          widgetOfData: Column(
            children: [
              Divider(
                color: AppColors.greySwatch.shade200,
                height: 0.6.h,
              ),
              8.h.verticalSpace,
              state.data.isEmpty
                  ? ProductsByListIsEmptyWidget(listId: listId)
                  : Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              wishlistStateNotifier.selectedWishlist.clear();
                              wishlistStateNotifier.selectedWishlist.addAll(
                                state.data.map((product) => product.id!),
                              );
                              navigateTo(
                                context,
                                SelectProductsPage(
                                  listId: listId,
                                  addGoods: true,
                                ),
                              );
                            },
                            child: AddGoodsWidget(
                                numberOfGoods: state.data.length),
                          ),
                          4.h.verticalSpace,
                          Expanded(
                            child: MasonryGridViewForProductsByListWidget(
                              listId: listId,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
