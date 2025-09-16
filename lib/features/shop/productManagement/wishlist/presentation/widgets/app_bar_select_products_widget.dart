import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../riverpod/wishlist_riverpod.dart';

class AppBarSelectProductsWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? listName;
  final bool addGoods;

  const AppBarSelectProductsWidget({
    super.key,
    this.listName,
    this.addGoods = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(46.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: AutoSizeTextWidget(
        text: S.of(context).selectionOfProducts,
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
      ),
      leading: addGoods ? const IconButtonWidget() : null,
      actions: addGoods
          ? []
          : [
              Consumer(
                builder: (context, ref, child) {
                  var wishlistStateNotifier =
                      ref.watch(wishlistProvider.notifier);
                  return InkWell(
                    onTap: () {
                      wishlistStateNotifier.createAnewListAndAddProducts(
                        listId: 0,
                        listName: listName.toString(),
                        productsIds: [],
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: AutoSizeTextWidget(
                        text: S.of(context).skip,
                        fontSize: 9.5.sp,
                        colorText: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            ],
    );
  }
}
