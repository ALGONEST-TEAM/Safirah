import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/features/shop/home/presentation/widgets/tap_bar_widget.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/auth/auth.dart';
import '../../../../notifications/presentation/pages/notifications_page.dart';
import '../../../../notifications/presentation/state_mangment/notifications_riverpod.dart';
import '../../../../user/presentation/pages/log_in_page.dart';
import '../../../productManagement/search_product/presntation/page/search_page.dart';
import '../../../productManagement/wishlist/presentation/pages/wishlist_page.dart';
import '../../../productManagement/wishlist/presentation/riverpod/wishlist_riverpod.dart';
import '../../data/model/offers_model.dart';
import 'offers_widget.dart';

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
          text: S.of(context).welcome,
          colorText: AppColors.fontColor,
          fontSize: 12.6.sp,
        ),
        4.w.horizontalSpace,
        Flexible(
          child: AutoSizeTextWidget(
            text: Auth().name,
            colorText: AppColors.secondaryColor,
            fontSize: 12.6.sp,
            maxLines: 2,
          ),
        ),
        12.w.horizontalSpace,
      ],
    ),
    leading: Consumer(
      builder: (context, ref, child) {
        return IconButtonWidget(
          icon: AppIcons.wishlist,
          height: 18.h,
          onPressed: () {
            if (!Auth().loggedIn) {
              navigateTo(context, const LogInPage());
            } else {
              ref.invalidate(getAllWishesProductsProvider);
              ref.invalidate(getAllListProvider);
              navigateTo(context, const WishlistPage());
            }
          },
        );
      },
    ),
    actions: [
      InkWellButtonWidget(
        icon: AppIcons.search,
        height: 18.5.h,
        onPressed: () {
          navigateTo(context, SearchPage(hintTextSearch: ""));
        },
      ),
      Consumer(builder: (context, ref, _) {
        final unread = ref.watch(unreadCountProvider);

        return Stack(
          clipBehavior: Clip.none,
          children: [
            IconButtonWidget(
              icon: AppIcons.notification,
              height: 20.h,
              onPressed: () async {
                if (!Auth().loggedIn) {
                  navigateTo(context, const LogInPage());
                } else {
                  navigateTo(context, const NotificationsPage());
                  ref.read(unreadCountProvider.notifier).refresh();
                }
              },
            ),
            if (unread > 0)
              Positioned(
                top: 1,
                left: unread >= 10 ? 4.w : 6.w,
                child: Container(
                  padding: EdgeInsets.all(unread >= 10 ? 1.6.sp : 2.sp),
                  decoration: BoxDecoration(
                    color: AppColors.dangerColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  child: AutoSizeTextWidget(
                    text: unread > 99 ? '99+' : ' $unread ',
                    colorText: Colors.white,
                    fontSize: 7.2.sp,
                    minFontSize: 6,
                  ),
                ),
              ),
          ],
        );
      }),
    ],
  );
}

