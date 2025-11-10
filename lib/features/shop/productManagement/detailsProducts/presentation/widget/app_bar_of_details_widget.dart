import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../services/auth/auth.dart';
import '../../../../shoppingBag/cart/presentation/pages/cart_page.dart';

class AppBarOfDetailsWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String nameForShare;
  final String descriptionForShare;
  final String imageForShare;
  final String price;
  final int idProductForShare;
  final bool hideShareButton;

  const AppBarOfDetailsWidget({
    super.key,
    required this.descriptionForShare,
    required this.idProductForShare,
    required this.imageForShare,
    required this.nameForShare,
    required this.price,
    this.hideShareButton = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(52.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      leading: IconButtonWidget(height: 21.h),
      leadingWidth: 54.w,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: SvgPicture.asset(AppIcons.logo,height: 42.h,),
      actions: [
        Row(
          children: [
            // InkWellButtonWidget(
            //   icon: AppIcons.sharing,
            //   height: 22.h,
            //   onPressed: () {},
            // ),
            // 4.w.horizontalSpace,
            Consumer(
              builder: (context, ref, child) {
                return IconButtonWidget(
                  icon: AppIcons.cart,
                  height: 21.h,
                  onPressed: () {
                    if (!Auth().loggedIn) {
                      pressAgainToExit(
                        context: context,
                        text: S.of(context).loginRequired,
                      );
                      return;
                    }
                    navigateTo(context, const CartPage());
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
