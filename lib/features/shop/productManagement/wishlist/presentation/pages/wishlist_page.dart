import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../riverpod/wishlist_riverpod.dart';
import '../widgets/app_bar_for_wishlist_widget.dart';
import '../widgets/list_widget.dart';
import '../widgets/list_of_wishes_products_widget.dart';

class WishlistPage extends ConsumerStatefulWidget {
  const WishlistPage({super.key});

  @override
  ConsumerState<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends ConsumerState<WishlistPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ValueNotifier<bool> _showIcon = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _hideIcon = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.animation!.addListener(() {
      double position = _tabController.animation!.value;
      if (position > 0.7) {
        _showIcon.value = false;
      } else if (position < 0.3) {
        _showIcon.value = true;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _showIcon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var wishesProductsState = ref.watch(getAllWishesProductsProvider);
    var wishlistState = ref.watch(getAllListProvider);

    return Scaffold(
      appBar: AppBarForWishlistWidget(
        showMultipleChoiceIcon: wishesProductsState.data.isEmpty ||
                wishesProductsState.stateData == States.loading ||
                wishesProductsState.stateData == States.error
            ? _hideIcon
            : _showIcon,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              physics: const ClampingScrollPhysics(),
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(horizontal: 64.w),
              dividerColor: Colors.black54,
              labelColor: AppColors.secondaryColor,
              unselectedLabelColor: AppColors.fontColor.withOpacity(.5),
              tabAlignment: TabAlignment.center,
              labelStyle: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "ReadexPro",
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "ReadexPro",
              ),
              indicator: UnderlineTabIndicator(
                borderSide:
                    BorderSide(width: 3.w, color: AppColors.primaryColor),
                insets: EdgeInsets.symmetric(vertical: 4.h),
              ),
              dividerHeight: 0.12,
              tabs: [
                Tab(
                  text: wishesProductsState.data.isNotEmpty
                      ? "${S.of(context).products} (${wishesProductsState.data.length})"
                      : S.of(context).products,
                ),
                Tab(
                  text: wishlistState.data.isNotEmpty
                      ? "${S.of(context).list} (${wishlistState.data.length})"
                      : S.of(context).list,
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: const BouncingScrollPhysics(),
              children: const [
                ListOfWishesProductsWidget(),
                ListWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
