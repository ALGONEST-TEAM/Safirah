import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/bottomNavbar/button_bottom_navigation_bar_design_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../core/widgets/loading_widget.dart';
import '../../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../myOrders/data/model/product_order_details_model.dart';
import '../riverpod/reviews_riverpod.dart';
import '../widgets/card_for_comments_widget.dart';
import '../widgets/evaluation_value_and_number_of_rating_stars_widget.dart';
import '../widgets/review_product_card_widget.dart';
import '../widgets/shimmer_for_reviews_widget.dart';
import '../widgets/size_linear_progress_indicator_widget.dart';
import 'add_reviews_dialog.dart';

class ReviewsPage extends ConsumerStatefulWidget {
  final ProductOrderDetailsModel products;
  final int orderId;
  final int status;

  const ReviewsPage({
    super.key,
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
      ref.read(getAllReviewsProvider(widget.products.id).notifier).getData(
            moreData: true,
          );
    }
  }

  //dispose
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var state = ref.watch(getAllReviewsProvider(widget.products.id));
    return Scaffold(
      appBar: SecondaryAppBarWidget(title: S.of(context).evaluations),
      body: CheckStateInGetApiDataWidget(
        state: state,
        widgetOfLoading: const ShimmerForReviewsWidget(),
        widgetOfData: RefreshIndicator(
          color: AppColors.primaryColor,
          backgroundColor: Colors.white,
          onRefresh: () async {
            ref.refresh(getAllReviewsProvider(widget.products.id));
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: state.data.review.data.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReviewProductCardWidget(
                        image: widget.products.image.toString(),
                        name: widget.products.name.toString(),
                        price: widget.products.price.toString(),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.h),
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.02),
                              blurRadius: 1.r,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            EvaluationValueAndNumberOfRatingStarsWidget(
                              rates: state.data.rates,
                              total: state.data.total.toDouble(),
                            ),
                            Expanded(
                              child: Column(
                                children: List.generate(
                                  state.data.counter.length,
                                  (index) {
                                    return SizeLinearProgressIndicatorWidget(
                                      value: state.data.counter[index].value! /
                                          state.data.total,
                                      sizeName: state.data.counter[index].name
                                          .toString(),
                                      showTextAtTheBeginningOnly:
                                          index == 0 ? true : false,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      8.h.verticalSpace,
                      Column(
                        children: state.data.review.data.map((items) {
                          return CardForCommentsWidget(
                            reviews: items,
                          );
                        }).toList(),
                      ),
                      10.h.verticalSpace,
                      if (state.stateData == States.loadingMore)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: const CircularProgressIndicatorWidget(),
                        ),
                    ],
                  )
                : Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: 80.h),
                      child: AutoSizeTextWidget(
                        text: "لاتوجد تقييمات لهذا المنتج",
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
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
                          textSize: 12.sp,
                          onPressed: () {
                            showModalBottomSheetWidget(
                              context: context,
                              backgroundColor: Colors.transparent,
                              page: AddReviewsDialog(
                                orderId: widget.orderId,
                                productId: widget.products.id,
                                colorId: widget.products.colorId,
                                colorHex: widget.products.colorHex.toString(),
                                colorName: widget.products.colorName.toString(),
                                sizeId: widget.products.sizeId!,
                                sizeValue: widget.products.sizeValue.toString(),
                              ),
                            );
                          }),
                    )
                  : null,
    );
  }
}
