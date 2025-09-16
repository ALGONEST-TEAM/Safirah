import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/auth/auth.dart';
import '../../../shoppingBag/cart/presentation/pages/cart_page.dart';

class AppBarMyOrdersWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarMyOrdersWidget({
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(40.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: AutoSizeTextWidget(
        text: S.of(context).myOrders,
        fontSize: 14.8.sp,
        fontWeight: FontWeight.w600,
      ),
      actions: [
        12.w.horizontalSpace,
        InkWellButtonWidget(
          icon: AppIcons.cartActive,
          height: 20.6.h,
          onPressed: () {
            navigateTo(context, const CartPage());
          },
        ),
        // if (!Auth().loggedIn) 12.w.horizontalSpace,
        // if (Auth().loggedIn)
          IconButtonWidget(
            icon: AppIcons.notification,
            height: 20.h,
            onPressed: () {},
          ),
      ],
    );
  }
}
