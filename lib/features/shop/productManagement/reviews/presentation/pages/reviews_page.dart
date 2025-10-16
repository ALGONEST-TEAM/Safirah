import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/bottomNavbar/button_bottom_navigation_bar_design_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../core/widgets/loading_widget.dart';
import '../../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../myOrders/data/model/product_order_details_model.dart';
import '../riverpod/reviews_riverpod.dart';
import '../widgets/card_for_comments_widget.dart';
import '../widgets/reviews_are_empty_widget.dart';
import '../widgets/reviews_widget.dart';
import '../widgets/shimmer_for_reviews_widget.dart';
import 'add_reviews_dialog.dart';

class ReviewsPage extends ConsumerStatefulWidget {
  final ProductOrderDetailsModel products;
  final int? productId;
  final int orderId;
  final int status;

  const ReviewsPage({
    super.key,
    this.productId,
    required this.products,
    required this.orderId,
    required this.status,
  });

  @override
  ConsumerState<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends ConsumerState<ReviewsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref
          .read(getAllReviewsProvider(widget.productId != null
                  ? widget.productId!
                  : widget.products.id)
              .notifier)
          .getData(
            moreData: true,
          );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(getAllReviewsProvider(
        widget.productId != null ? widget.productId! : widget.products.id));
    return Scaffold(
      appBar: SecondaryAppBarWidget(
        title: S.of(context).evaluations,
        fontSize: 15.2.sp,
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        backgroundColor: Colors.white,
        onRefresh: () async {
          ref.refresh(getAllReviewsProvider(widget.productId != null
              ? widget.productId!
              : widget.products.id));
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: CheckStateInGetApiDataWidget(
            state: state,
            refresh: () {
              ref.refresh(getAllReviewsProvider(widget.productId != null
                  ? widget.productId!
                  : widget.products.id));
            },
            widgetOfLoading: const ShimmerForReviewsWidget(),
            widgetOfData: state.data.review.data.isNotEmpty
                ? Column(
                    children: [
                      ReviewsWidget(
                        rates: state.data.rates,
                        total: state.data.total.toDouble(),
                        counter: state.data.counter,
                      ),
                      4.h.verticalSpace,
                      Column(
                        children: state.data.review.data.map((items) {
                          return CardForCommentsWidget(
                            reviews: items,
                            productId: widget.productId != null
                                ? widget.productId!
                                : widget.products.id,
                          );
                        }).toList(),
                      ),
                      12.h.verticalSpace,
                      if (state.stateData == States.loadingMore)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: const CircularProgressIndicatorWidget(),
                        ),
                    ],
                  )
                : const ReviewsAreEmptyWidget(),
          ),
        ),
      ),

      bottomNavigationBar:
          state.stateData == States.loading || state.stateData == States.error
              ? null
              : widget.status == 6
                  ? ButtonBottomNavigationBarDesignWidget(
                      child: DefaultButtonWidget(
                        text: S.of(context).addRating,
                        textSize: 13.sp,
                        onPressed: () {
                          scrollShowModalBottomSheetWidget(
                            context: context,
                            title: S.of(context).canYouLeaveYourReview,
                            page: AddReviewsDialog(
                              orderId: widget.orderId,
                              productId: widget.products.id,
                              colorId: widget.products.colorId,
                              colorHex: widget.products.colorHex.toString(),
                              colorName: widget.products.colorName.toString(),
                              sizeId: widget.products.sizeId!,
                              sizeValue: widget.products.sizeValue.toString(),
                              numberName: widget.products.numberName.toString(),
                              numberId: widget.products.numberId,
                            ),
                          );
                        },
                      ),
                    )
                  : null,
    );
  }
}
