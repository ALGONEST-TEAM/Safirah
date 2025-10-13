import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/icon_button_widget.dart';
import '../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../services/auth/auth.dart';
import '../../../shop/address/presentation/pages/view_all_address_page.dart';
import '../../../shop/productManagement/wishlist/presentation/pages/wishlist_page.dart';
import '../../../shop/productManagement/wishlist/presentation/riverpod/wishlist_riverpod.dart';
import 'settings_page.dart';
import '../widgets/app_intro_card_widget.dart';
import '../widgets/list_tile_profile_widget.dart';
import '../widgets/profile_header_card_widget.dart';
import 'edit_profile_page.dart';
import 'support_channels_bottom_sheet.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: AutoSizeTextWidget(
          text: S.of(context).profile,
          fontSize: 14.8.sp,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          IconButtonWidget(
            icon: AppIcons.notification,
            height: 20.h,
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            ProfileHeaderCardWidget(onLogoutSuccess: _refresh),
            Visibility(
              visible: Auth().loggedIn,
              child: Column(
                spacing: 12.h,
                children: [
                  ListTileProfileWidget(
                    title: S.of(context).personalInfo,
                    icon: AppIcons.personalInfo,
                    onTap: () {
                      navigateTo(context, EditProfilePage(onSuccess: _refresh));
                    },
                  ),
                  ListTileProfileWidget(
                    title: S.of(context).addressBook,
                    icon: AppIcons.address,
                    onTap: () {
                      navigateTo(context, const ViewAllAddressPage());
                    },
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return ListTileProfileWidget(
                        title: S.of(context).favorites,
                        icon: AppIcons.wishlist,
                        onTap: () {
                          ref.refresh(getAllWishesProductsProvider);
                          ref.refresh(getAllListProvider);
                          navigateTo(context, const WishlistPage());
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            // ListTileProfileWidget(
            //   title: S.of(context).myLeagues,
            //   icon: AppIcons.myLeagues,
            //   onTap: () {
            //     navigateTo(context, const ChangeCurrencyPage());
            //   },
            // ),
            ListTileProfileWidget(
              title: S.of(context).settings,
              icon: AppIcons.settings,
              onTap: () {
                navigateTo(context, SettingsPage(onSuccess: _refresh));
              },
            ),
            ListTileProfileWidget(
              title: S.of(context).faq,
              icon: AppIcons.faq,
              onTap: () {},
            ),
            ListTileProfileWidget(
              title: S.of(context).support,
              icon: AppIcons.support,
              onTap: () {
                scrollShowModalBottomSheetWidget(
                  title: S.of(context).support,
                  fontSize: 13.4.sp,
                  context: context,
                  page: const SupportChannelsBottomSheet(),
                );
              },
            ),
            2.h.verticalSpace,
            const AppIntroCardWidget(),
            20.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}
