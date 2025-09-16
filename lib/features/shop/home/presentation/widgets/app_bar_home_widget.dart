import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import '../../../../../services/auth/auth.dart';
import '../../../../user/presentation/pages/log_in_page.dart';
import '../../../productManagement/search_product/presntation/page/search_page.dart';
import '../../../productManagement/wishlist/presentation/pages/wishlist_page.dart';
import '../../../productManagement/wishlist/presentation/riverpod/wishlist_riverpod.dart';

AppBar appBarHomeWidget({required BuildContext context}) {
  return AppBar(
    elevation: 0,
    titleSpacing: 0,
    leadingWidth: 52.w,
    backgroundColor: AppColors.scaffoldColor,
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.w.horizontalSpace,
        AutoSizeTextWidget(
          text: "مرحبا بك",
          colorText: AppColors.fontColor,
          fontSize: 12.6.sp,
        ),
        4.w.horizontalSpace,
        Flexible(
          child: AutoSizeTextWidget(
            text: "رائد مسعود",
            colorText: AppColors.secondaryColor,
            fontSize: 12.6.sp,
            maxLines: 2,
          ),
        ),
        12.w.horizontalSpace,
      ],
    ),
    leading: Consumer(builder:(context, ref, child) {
      return IconButtonWidget(
        icon: AppIcons.wishlist,
        height: 18.h,
        onPressed: () {
          if (!Auth().loggedIn) {
            navigateTo(context, const LogInPage());
          } else {
            ref.refresh(getAllWishesProductsProvider);
            ref.refresh(getAllListProvider);
            navigateTo(context, const WishlistPage());
          }
        },
      );
    }, ),
    actions: [
      InkWellButtonWidget(
        icon: AppIcons.search,
        height: 18.5.h,
        onPressed: () {
          navigateTo(context, SearchPage(hintTextSearch: ""));

        },
      ),
      IconButtonWidget(
        icon: AppIcons.notification,
        height: 19.h,
        onPressed: () {},
      ),
    ],
  );
}
