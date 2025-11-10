import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/features/shop/shoppingBag/cart/presentation/pages/cart_page.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../services/auth/auth.dart';
import '../../../../user/presentation/pages/log_in_page.dart';
import '../../../productManagement/search_product/presntation/page/search_page.dart';

SliverAppBar subcategoryFilterAppBarWidget(
    {required int viewType,
    required Widget flexibleSpace,
    required PreferredSize bottom,
    required BuildContext context,
    required String hintTextSearch,
    required int idCategory}) {
  return SliverAppBar(
    backgroundColor: AppColors.scaffoldColor,
    expandedHeight: viewType != 0
        ? viewType == 1
            ? 112.h
            : 130.h
        : 0,
    elevation: 0,
    pinned: true,
    titleSpacing: 0,
    automaticallyImplyLeading: false,
    surfaceTintColor: AppColors.scaffoldColor,
    leading: const IconButtonWidget(),
    title: GestureDetector(
      onTap: () {
        navigateTo(
            context,
            SearchPage(
              hintTextSearch: hintTextSearch,
            ));
      },
      child: Container(
        height: 30.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.secondaryColor, width: 0.8),
        ),
        child: Row(
          children: [
            8.w.horizontalSpace,
            Expanded(
              child: AutoSizeTextWidget(
                text: hintTextSearch,
                fontSize: 11.8.sp,
                colorText: AppColors.secondaryColor,
              ),
            ),
            SvgPicture.asset(
              AppIcons.search,
              color: AppColors.secondaryColor,
              height: 16.h,
            ),
            8.w.horizontalSpace,
          ],
        ),
      ),
    ),
    actions: [
      4.w.horizontalSpace,
      IconButtonWidget(
        icon: AppIcons.cartActive,
        height: 21.h,
        onPressed: () {
          if (!Auth().loggedIn) {
            navigateTo(context, const LogInPage());
          } else {
            navigateTo(context, const CartPage());
          }
        },
      ),
    ],
    bottom: bottom,
    flexibleSpace: FlexibleSpaceBar(
      background: Padding(
        padding: EdgeInsets.only(top: 69.h),
        child: flexibleSpace,
      ),
    ),
  );
}

class SubcategoryStatusAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const SubcategoryStatusAppBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(46.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: const IconButtonWidget(),
      actions: [
        4.w.horizontalSpace,
        IconButtonWidget(
          icon: AppIcons.cartActive,
          height: 21.h,
          onPressed: () {
            if (!Auth().loggedIn) {
              navigateTo(context, const LogInPage());
            } else {
              navigateTo(context, const CartPage());
            }
          },
        ),
      ],
    );
  }
}
