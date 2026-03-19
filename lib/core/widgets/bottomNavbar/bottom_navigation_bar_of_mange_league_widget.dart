import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safirah/core/helpers/navigateTo.dart';
import '../../../features/leagues_mangement/home/presntation/pages/home_page.dart';
import '../../../features/leagues_mangement/home/presntation/pages/home_page.dart' as league_home;
import '../../../features/leagues_mangement/leagues/persntaion/page/show_leagues_page.dart';
import '../../../features/prediction/presentation/pages/prediction_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../../features/shop/home/presentation/pages/home_page.dart' as shop_home;
import '../../../features/shop/myOrders/presentation/pages/my_orders_page.dart';
import '../../../features/shop/shoppingBag/cart/presentation/pages/cart_page.dart';
import '../../../features/shop/shoppingBag/cart/presentation/riverpod/cart_riverpod.dart';
import '../../../features/user/presentation/pages/log_in_page.dart';
import '../../../generated/l10n.dart';
import '../../../services/auth/auth.dart';
import '../../constants/app_icons.dart';
import '../../helpers/exit_from_the_app.dart';
import '../../theme/app_colors.dart';
import '../auto_size_text_widget.dart';
import 'bottom_navigation_bar_widget.dart';
import 'design_for_bottom_navigation_bar_widget.dart';

final activeIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavigationBarOfMangeLeagueWidget extends ConsumerStatefulWidget {
  const BottomNavigationBarOfMangeLeagueWidget({super.key});

  @override
  ConsumerState createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState
    extends ConsumerState<BottomNavigationBarOfMangeLeagueWidget> {
  final List<Widget> _pages = [
    const ExitFromAppWidget(child: HomePages()),
    const ExitFromAppWidget(child: PredictionPage()),
    const ExitFromAppWidget(child: ShowLeaguesPage()),
    const ExitFromAppWidget(child: ProfilePage()),
  ];

  @override
  Widget build(BuildContext context) {
    final activeIndex = ref.watch(activeIndexProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: true,
      ),
      child: Scaffold(
        body: _pages[activeIndex],
        floatingActionButton: SizedBox(
          height: 56.h,
          child: FloatingActionButton.large(
            onPressed: () {
              navigateReplacement(context, const BottomNavigationBarWidget());
            },
            backgroundColor: AppColors.whiteColor,
            splashColor: AppColors.primaryColor,
            elevation: 0,
            shape: const CircleBorder(),
            child: Container(
              padding: EdgeInsets.all(14.sp),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(AppIcons.shop),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: EdgeInsets.only(bottom: 4.h, top: 6.h),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r),
                topLeft: Radius.circular(8.r),
              ),
            ),
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
                  width: 20.w,
                ),
                _buildNavItem(
                  AppIcons.myOrders,
                  AppIcons.myOrdersActive,
                  'الدوريات',
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
enum AppShellMode { leagues, shop }

final shellModeProvider =
StateProvider<AppShellMode>((ref) => AppShellMode.leagues);

final leaguesTabIndexProvider = StateProvider<int>((ref) => 0);
final shopTabIndexProvider = StateProvider<int>((ref) => 0);

class MainShellPage extends ConsumerWidget {
  const MainShellPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(shellModeProvider);
    final leaguesIndex = ref.watch(leaguesTabIndexProvider);
    final shopIndex = ref.watch(shopTabIndexProvider);

    final leaguePages =  [
      ExitFromAppWidget(child: league_home.HomePages()),
      ExitFromAppWidget(child: PredictionPage()),
      ExitFromAppWidget(child: ShowLeaguesPage()),
      ExitFromAppWidget(child: ProfilePage()),
    ];

    final shopPages =  [
      ExitFromAppWidget(child: shop_home.HomePage()),
      ExitFromAppWidget(child: MyOrdersPage()),
      ExitFromAppWidget(child: CartPage()),
      ExitFromAppWidget(child: ProfilePage()),
    ];

    final isLeagues = mode == AppShellMode.leagues;
    final activeBody = isLeagues
        ? leaguePages[leaguesIndex]
        : shopPages[shopIndex];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
        isLeagues ? Brightness.light : Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarContrastEnforced: true,
      ),
      child: Scaffold(
        body: IndexedStack(
          index: 0,
          children: [activeBody],
        ),
        floatingActionButton: SizedBox(
          height: isLeagues ? 56.h : 57.h,
          child: FloatingActionButton.large(
            onPressed: () {
              ref.read(shellModeProvider.notifier).state = isLeagues
                  ? AppShellMode.shop
                  : AppShellMode.leagues;
            },
            backgroundColor: AppColors.whiteColor,
            splashColor: AppColors.primaryColor,
            elevation: 0,
            shape: const CircleBorder(),
            child: Container(
              padding: EdgeInsets.all(isLeagues ? 14.sp : 11.sp),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                isLeagues ? AppIcons.shop : AppIcons.league,
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: SafeArea(
          top: false,
          child: Container(
            padding: EdgeInsets.only(
              bottom: 4.h,
              top: isLeagues ? 6.h : 8.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r),
                topLeft: Radius.circular(8.r),
              ),
            ),
            child: isLeagues
                ? _LeaguesBottomBar(
              activeIndex: leaguesIndex,
              onTap: (index) {
                ref.read(leaguesTabIndexProvider.notifier).state = index;
              },
            )
                : _ShopBottomBar(
              activeIndex: shopIndex,
              onTap: (index) {
                if (index == 2) {
                  if (!Auth().loggedIn) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const LogInPage(),
                      ),
                    );
                  } else {
                    ref.read(shopTabIndexProvider.notifier).state = 2;
                  }
                } else {
                  ref.read(shopTabIndexProvider.notifier).state = index;
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _LeaguesBottomBar extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onTap;

  const _LeaguesBottomBar({
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _item(context, AppIcons.home, AppIcons.homeActive, S.of(context).home, 0),
        _item(
          context,
          AppIcons.expectations,
          AppIcons.expectationsActive,
          S.of(context).expectations,
          1,
        ),
        SizedBox(height: 20.h, width: 20.w),
        _item(context, AppIcons.myOrders, AppIcons.myOrdersActive, 'الدوريات', 2),
        _item(
          context,
          AppIcons.profile,
          AppIcons.profileActive,
          S.of(context).profile,
          3,
        ),
      ],
    );
  }

  Widget _item(
      BuildContext context,
      String icon,
      String activeIcon,
      String label,
      int index,
      ) {
    return DesignForBottomNavigationBarWidget(
      icon: icon,
      activeIcon: activeIcon,
      label: label,
      active: activeIndex == index,
      onTap: () => onTap(index),
    );
  }
}

class _ShopBottomBar extends ConsumerWidget {
  final int activeIndex;
  final ValueChanged<int> onTap;

  const _ShopBottomBar({
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(getCartCountProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: _item(
            context,
            AppIcons.home,
            AppIcons.homeActive,
            S.of(context).home,
            0,
          ),
        ),
        Expanded(
          child: _item(
            context,
            AppIcons.myOrders,
            AppIcons.myOrdersActive,
            S.of(context).myOrders,
            1,
          ),
        ),
        SizedBox(height: 20.h, width: 50.w),
        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              _item(
                context,
                AppIcons.cart,
                AppIcons.cartActive,
                S.of(context).cart,
                2,
              ),
              if (cartCount > 0)
                Positioned(
                  left: -5,
                  top: -8,
                  child: Container(
                    padding: EdgeInsets.all(1.6.sp),
                    decoration: BoxDecoration(
                      color: AppColors.dangerColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                    ),
                    child: AutoSizeTextWidget(
                      text: ' $cartCount ',
                      colorText: Colors.white,
                      fontSize: 7.5.sp,
                      minFontSize: 6,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          child: _item(
            context,
            AppIcons.profile,
            AppIcons.profileActive,
            S.of(context).profile,
            3,
          ),
        ),
      ],
    );
  }

  Widget _item(
      BuildContext context,
      String icon,
      String activeIcon,
      String label,
      int index,
      ) {
    return DesignForBottomNavigationBarWidget(
      icon: icon,
      activeIcon: activeIcon,
      label: label,
      active: activeIndex == index,
      onTap: () => onTap(index),
    );
  }
}