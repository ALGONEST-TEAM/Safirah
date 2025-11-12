import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../../core/widgets/buttons/ink_well_button_widget.dart';
import '../../../../../../core/widgets/cart_badge_icon_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../shoppingBag/cart/presentation/pages/cart_page.dart';
import '../pages/select_items_from_the_wishlist_page.dart';
import '../riverpod/wishlist_riverpod.dart';

class AppBarForWishlistWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final ValueNotifier<bool>? showMultipleChoiceIcon;
  final bool showCancelButton;
  final bool centerTitle;
  final bool selectProductsByList;
  final int? listId;

  const AppBarForWishlistWidget({
    super.key,
    this.title,
    this.showMultipleChoiceIcon,
    this.showCancelButton = false,
    this.centerTitle = true,
    this.selectProductsByList = false,
    this.listId,
  });

  @override
  Size get preferredSize => Size.fromHeight(48.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      centerTitle: centerTitle,
      titleSpacing: 0,
      title: AutoSizeTextWidget(
        text: title ?? S.of(context).wishlist,
        fontSize: 12.8.sp,
        fontWeight: FontWeight.w600,
      ),
      leading: const IconButtonWidget(),
      actions: showCancelButton == true
          ? [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: AutoSizeTextWidget(
                    text: S.of(context).cancel,
                    fontSize: 10.4.sp,
                    colorText: AppColors.dangerSwatch.shade400,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ]
          : [
              ValueListenableBuilder<bool>(
                valueListenable: showMultipleChoiceIcon!,
                builder: (context, show, child) {
                  return Visibility(
                    visible: show,
                    child: Consumer(
                      builder: (context, ref, child) {
                        var wishlistStateNotifier =
                            ref.watch(wishlistProvider.notifier);
                        return InkWellButtonWidget(
                          icon: AppIcons.multipleChoice,
                          height: 21.5.h,
                          onPressed: () {
                            wishlistStateNotifier.selectedWishlist.clear();
                            navigateTo(
                              context,
                              SelectItemsFromTheWishlistPage(
                                listId: listId,
                                listName: title,
                                selectProductsByList: selectProductsByList,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              const CartBadgeIconWidget(),
            ],
    );
  }
}
