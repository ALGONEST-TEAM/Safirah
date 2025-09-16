import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';
import '../pages/select_products_page.dart';
import '../riverpod/wishlist_riverpod.dart';

class ProductsByListIsEmptyWidget extends ConsumerWidget {
  final int listId;

  const ProductsByListIsEmptyWidget({super.key, required this.listId});

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(getAllWishesProductsProvider);
    return Column(
      children: [
        SvgPicture.asset(
          AppIcons.emptyList,
          height: 100.h,
        ),
        AutoSizeTextWidget(
          text: S.of(context).productsListIsEmpty,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        8.h.verticalSpace,
        AutoSizeTextWidget(
          text: S.of(context).addYourFavoriteProducts,
          fontSize: 10.8.sp,
          colorText: AppColors.fontColor,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        22.h.verticalSpace,
        state.data.isNotEmpty
            ? DefaultButtonWidget(
                text: S.of(context).addProducts,
                height: 32.h,
                width: 140.w,
                textSize: 10.5.sp,
                onPressed: () {
                  navigateTo(
                    context,
                    SelectProductsPage(
                      listId: listId,
                      addGoods: true,
                    ),
                  );
                },
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
