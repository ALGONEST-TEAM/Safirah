import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/shop/shoppingBag/cart/presentation/pages/cart_page.dart';
import '../../features/shop/shoppingBag/cart/presentation/riverpod/cart_riverpod.dart';
import '../../generated/l10n.dart';
import '../../services/auth/auth.dart';
import '../constants/app_icons.dart';
import '../helpers/flash_bar_helper.dart';
import '../helpers/navigateTo.dart';
import '../theme/app_colors.dart';
import 'auto_size_text_widget.dart';
import 'buttons/icon_button_widget.dart';

class CartBadgeIconWidget extends ConsumerWidget {
  const CartBadgeIconWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(getCartCountProvider);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButtonWidget(
          icon: AppIcons.cartActive,
          height: 20.h,
          iconColor: AppColors.secondaryColor,
          onPressed: () async {
            if (!Auth().loggedIn) {
              pressAgainToExit(
                context: context,
                text: S.of(context).loginRequired,
              );
              return;
            }
            navigateTo(context, const CartPage());
          },
        ),
        if (cartCount > 0)
          Positioned(
            left: cartCount >= 10 ? 2.w : 4.w,
            top: 1,
            child: Container(
              padding: EdgeInsets.all(cartCount >= 10 ? 1.6.sp : 2.sp),
              decoration: BoxDecoration(
                color: AppColors.dangerColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: AutoSizeTextWidget(
                text: ' $cartCount ',
                colorText: Colors.white,
                fontSize: 7.5.sp,
                minFontSize: 6,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
