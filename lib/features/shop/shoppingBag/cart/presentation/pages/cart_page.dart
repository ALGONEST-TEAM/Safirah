import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../riverpod/cart_riverpod.dart';
import '../widgets/cart_bottom_bar_widget.dart';
import '../widgets/list_for_cart_widget.dart';
import '../widgets/shimmer_card_widget.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(getAllCartProvider);
    ref.watch(cartProvider);

    return RefreshIndicator(
      color: AppColors.primaryColor,
      backgroundColor: Colors.white,
      onRefresh: () async {
        ref.refresh(getAllCartProvider);
      },
      child: Scaffold(
        appBar: SecondaryAppBarWidget(
          title: S.of(context).cart,
        ),
        body: CheckStateInGetApiDataWidget(
          state: state,
          refresh: () {
            ref.refresh(getAllCartProvider);
          },
          widgetOfLoading: const ShimmerCardWidget(),
          widgetOfData: Column(
            children: [
              if (state.data.isNotEmpty)
                const Expanded(child: ListForCartWidget())
              else
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 20.h),
                  child: const AutoSizeTextWidget(
                    text: "السلة فارغة",
                    colorText: Colors.black87,
                    fontSize: 15.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
        bottomNavigationBar: state.stateData == States.loaded && state.data.isNotEmpty
            ? CartBottomBarWidget(items: state.data)
            : null,
      ),
    );
  }
}
