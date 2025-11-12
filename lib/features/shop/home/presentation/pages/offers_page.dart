import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/cart_badge_icon_widget.dart';
import '../../../../../core/widgets/logo_shimmer_widget.dart';
import '../../../../../core/widgets/product/product_list_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../riverpod/home_riverpod.dart';

class OffersPage extends ConsumerStatefulWidget {
  final int offerId;

  const OffersPage({super.key, required this.offerId});

  @override
  ConsumerState<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends ConsumerState<OffersPage> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(getOfferProductsProvider(widget.offerId));
    return Scaffold(
      appBar: SecondaryAppBarWidget(
        isLogo: true,
        fromHeight: 54.h,
        actions: const [
          CartBadgeIconWidget(),
        ],
      ),
      body: SafeArea(
        top: false,
        child: CheckStateInGetApiDataWidget(
          state: state,
          refresh: () {
            ref.refresh(getOfferProductsProvider(widget.offerId));
          },
          widgetOfLoading: const LogoShimmerWidget(),
          widgetOfData: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  child: AutoSizeTextWidget(
                    text: state.data.offer.title.toString(),
                    fontSize: 14.8.sp,
                  ),
                ),
                ProductListWidget(
                  isLoadingMore: false,
                  product: state.data.products,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
