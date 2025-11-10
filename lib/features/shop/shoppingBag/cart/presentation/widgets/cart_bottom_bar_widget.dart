import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/price_and_currency_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../services/auth/auth.dart';
import '../../../confirmOrder/presentation/pages/confirm_order_page.dart';
import '../../../confirmOrder/presentation/riverpod/confirm_order_riverpod.dart';

import '../../data/model/cart_model.dart';
import '../riverpod/cart_riverpod.dart';
import '../widgets/check_box_for_cart_products_widget.dart';

class CartBottomBarWidget extends ConsumerWidget {
  const CartBottomBarWidget({
    super.key,
    required this.items,
  });

  final List<CartModel> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider.notifier);
    ref.watch(cartProvider);

    return SafeArea(
      top: false,

      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
        ).copyWith(top: 4.h,bottom: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.r),
            topLeft: Radius.circular(8.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .06),
              blurRadius: 2.r,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Row(
                      children: [
                        AutoSizeTextWidget(
                          text: "${S.of(context).theTotal}: ",
                          colorText: Colors.black,
                          fontSize: 13.8.sp,
                        ),
                        Flexible(
                          child: PriceAndCurrencyWidget(
                            price: cart.calculateSelectedTotalPrice().toString(),
                            fontSize1: 12.8.sp,
                            fontSize2: 9.6.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AutoSizeTextWidget(
                      text: S.of(context).all,
                      colorText: AppColors.mainColorFont,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    2.w.horizontalSpace,
                    CheckBoxForCartProductsWidget(
                      value: cart.isAllProductsSelected(items),
                      onChanged: (isChecked) {
                        cart.toggleAllProductsSelection(
                          isChecked ?? false,
                          items,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            4.h.verticalSpace,
            Consumer(
              builder: (context, ref, child) {
                final state = ref.watch(fetchOrderConfirmationDataProvider);
                final ctrl =
                    ref.read(fetchOrderConfirmationDataProvider.notifier);

                final isConfirmLoading = state.stateData == States.loading &&
                    ctrl.lastMode == FetchMode.confirm;
                return CheckStateInPostApiDataWidget(
                  state: state,
                  hasMessageSuccess: false,
                  functionSuccess: () {
                    if (ctrl.lastMode != FetchMode.confirm) return;

                    ConfirmOrderController.form.reset();
                    navigateTo(
                      context,
                      ConfirmOrderPage(
                        products: cart.selectedProducts,
                      ),
                    );
                  },
                  bottonWidget: DefaultButtonWidget(
                    text: S.of(context).payment,
                    height: 38.h,
                    textSize: 13.4.sp,
                    background: AppColors.secondaryColor,
                    isLoading: isConfirmLoading,
                    onPressed: () {
                      if (!Auth().loggedIn) {
                        pressAgainToExit(
                          context: context,
                          text: S.of(context).loginRequired,
                        );
                      } else {
                        if (cart.selectedProducts.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(S
                                  .of(context)
                                  .pleaseSelectTheProductsYouWishToPayFor),
                              backgroundColor: AppColors.dangerSwatch.shade500
                                  .withValues(alpha: 0.9),
                            ),
                          );
                        } else {
                          ctrl.getData(
                              products: cart.selectedProducts,
                              mode: FetchMode.confirm);
                        }
                      }
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
