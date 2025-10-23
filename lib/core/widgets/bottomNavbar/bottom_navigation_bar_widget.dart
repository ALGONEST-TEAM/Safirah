import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../../features/shop/home/presentation/pages/home_page.dart';
import '../../../features/shop/myOrders/presentation/pages/my_orders_page.dart';
import '../../../generated/l10n.dart';
import '../../constants/app_icons.dart';
import '../../helpers/exit_from_the_app.dart';
import '../../theme/app_colors.dart';
import 'design_for_bottom_navigation_bar_widget.dart';

final activeIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavigationBarWidget extends ConsumerStatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  ConsumerState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState
    extends ConsumerState<BottomNavigationBarWidget> {
  final List<Widget> _pages = [
    const ExitFromAppWidget(child: HomePage()),
    const ExitFromAppWidget(child: Scaffold()),
    const ExitFromAppWidget(child: MyOrdersPage()),
    const ExitFromAppWidget(child: ProfilePage()),
  ];

  @override
  Widget build(BuildContext context) {
    final activeIndex = ref.watch(activeIndexProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            activeIndex == 0 ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: true,
      ),
      child: Scaffold(
        body: _pages[activeIndex],
        floatingActionButton: SizedBox(
          height: 60.h,
          child: FloatingActionButton.large(
            onPressed: () {},
            backgroundColor: AppColors.whiteColor,
            splashColor: AppColors.primaryColor,
            elevation: 0,
            shape: const CircleBorder(),
            child: Container(
              padding: EdgeInsets.all(11.sp),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(AppIcons.league),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: SafeArea(
          top: false,
          child: Container(
            padding: EdgeInsets.only(bottom: 4.h, top: 6.h),
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.r),
                  topLeft: Radius.circular(8.r),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  AppIcons.home,
                  AppIcons.homeActive,
                  S.of(context).home,
                  0,
                  activeIndex,
                ),
                _buildNavItem(
                  AppIcons.expectations,
                  AppIcons.expectationsActive,
                  S.of(context).expectations,
                  1,
                  activeIndex,
                ),
                SizedBox(
                  height: 20.h,
                  width: 40.w,
                ),
                _buildNavItem(
                  AppIcons.myOrders,
                  AppIcons.myOrdersActive,
                  S.of(context).myOrders,
                  2,
                  activeIndex,
                ),
                _buildNavItem(
                  AppIcons.profile,
                  AppIcons.profileActive,
                  S.of(context).profile,
                  3,
                  activeIndex,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, String activeIcon, String label, int index,
      int activeIndex) {
    return DesignForBottomNavigationBarWidget(
      icon: icon,
      activeIcon: activeIcon,
      label: label,
      active: activeIndex == index,
      onTap: () => ref.read(activeIndexProvider.notifier).state = index,
    );
  }
}
