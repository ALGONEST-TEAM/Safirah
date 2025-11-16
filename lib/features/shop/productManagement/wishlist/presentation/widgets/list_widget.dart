import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../riverpod/wishlist_riverpod.dart';
import 'design_create_a_new_list_widget.dart';
import 'empty_list_widget.dart';
import 'list_card_widget.dart';
import 'shimmer_wishlist_widget.dart';

class ListWidget extends ConsumerWidget {
  const ListWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(getAllListProvider);
    return RefreshIndicator(
      color: AppColors.primaryColor,
      backgroundColor: Colors.white,
      onRefresh: () async {
        ref.invalidate(getAllListProvider);
      },
      child: SingleChildScrollView(
        child: CheckStateInGetApiDataWidget(
          state: state,
          widgetOfLoading: const ShimmerWishlistWidget(),
          widgetOfData: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              state.data.isEmpty
                  ? Container(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(vertical: 4.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                      child: EmptyListWidget(
                        navigator: false,
                        iconHeight: 160.h,
                        buttonWidth: 160.w,
                        navigateToProductSelectionPage: true,
                      ),
                    )
                  : Column(
                      children: [
                        DesignCreateANewListWidget(
                          navigateToProductSelectionPage:
                              ref.read(getAllWishesProductsProvider).data.isNotEmpty
                                  ? true
                                  : false,
                          navigator: false,
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.data.length,
                          itemBuilder: (context, index) {
                            return ListCardWidget(
                              data: state.data[index],
                            );
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
