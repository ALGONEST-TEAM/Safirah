import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../riverpod/order_riverpod.dart';
import 'order_card_widget.dart';
import 'shimmer_order_card_widget.dart';

class ListForOrdersWidget extends ConsumerWidget {
  final int status;
  final bool? all;
  final ScrollController scrollController;

  const ListForOrdersWidget({
    super.key,
    required this.scrollController,
    required this.status,
    this.all = false,
  });

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(getAllOrdersProvider);
    var filteredOrders = state.data.orders
        .where((order) => order.status?.id == status || all == true)
        .toList();

    return RefreshIndicator(
      color: AppColors.primaryColor,
      backgroundColor: Colors.white,
      onRefresh: () async {
        ref.invalidate(getAllOrdersProvider);
      },
      child: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfLoading: const ShimmerOrderCardWidget(),
        refresh: () {
          ref.invalidate(getAllOrdersProvider);
        },
        widgetOfData:
            filteredOrders.isEmpty && state.stateData != States.loading
                ? Center(
                    child: Text(
                      "لا توجد طلبات متاحة لهذه الحالة",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.fontColor,
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: scrollController,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 12.w)
                        .copyWith(bottom: 38.h),
                    itemBuilder: (context, index) {
                      if (index < filteredOrders.length) {
                        return OrderCardWidget(
                          data: filteredOrders[index],
                        );
                      }
                      if (state.stateData == States.loadingMore) {
                        return Padding(
                          padding: EdgeInsets.only(top: 18.h),
                          child: const CircularProgressIndicatorWidget(),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                    itemCount: filteredOrders.length +
                        (state.stateData == States.loadingMore ? 1 : 0),
                  ),
      ),
    );
  }
}
