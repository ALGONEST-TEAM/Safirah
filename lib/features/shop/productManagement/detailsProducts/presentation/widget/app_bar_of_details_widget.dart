import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../../core/widgets/cart_badge_icon_widget.dart';

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
  Size get preferredSize => Size.fromHeight(50.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      leading: const IconButtonWidget(),
      leadingWidth: 54.w,
      centerTitle: true,
      automaticallyImplyLeading: false,
      toolbarHeight: 50.h,
      title: SvgPicture.asset(
        AppIcons.logo,
        height: 40.h,
      ),
      actions: const [
        CartBadgeIconWidget(),
      ],
    );
  }
}
