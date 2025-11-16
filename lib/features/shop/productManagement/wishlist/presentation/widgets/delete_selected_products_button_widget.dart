import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';
import '../../../detailsProducts/presentation/state_mangment/riverpod_details.dart';
import '../riverpod/wishlist_riverpod.dart';
import 'design_of_the_delete_wishlist_dialog_widget.dart';

class DeleteSelectedProductsButtonWidget extends ConsumerWidget {
  final bool selectProductsByList;
  final int? listId;

  const DeleteSelectedProductsButtonWidget({
    super.key,
    this.selectProductsByList = false,
    this.listId,
  });

  @override
  Widget build(BuildContext context, ref) {
    var wishlistStateNotifier = ref.watch(wishlistProvider.notifier);
    return DefaultButtonWidget(
      text: S.of(context).delete,
      width: 74.w,
      height: 28.h,
      textSize: 10.5.sp,
      minFontSize: 6,
      background: Colors.white,

      textColor: wishlistStateNotifier.selectedWishlist.isEmpty
          ? AppColors.dangerSwatch.shade200
          : AppColors.dangerSwatch.shade400,
      onPressed: wishlistStateNotifier.selectedWishlist.isEmpty
          ? null
          : () {
              showDialog(
                useSafeArea: true,
                context: context,
                builder: (context) {
                  return Dialog(
                    alignment: Alignment.center,
                    backgroundColor: Colors.transparent,
                    child: DesignOfTheDeleteWishlistDialogWidget(
                      title: selectProductsByList
                          ? S.of(context).areYouSureYouWantToDeleteTheseProducts
                          : "${S.of(context).areYouSureYouWantToDeleteTheseProducts}\n${S.of(context).theyWillAlsoBeRemovedFromTheLists}",
                      hasMessageSuccess: true,
                      messageSuccess: S.of(context).deletedSuccessfully,
                      onPressed: () {
                        if (selectProductsByList) {
                          wishlistStateNotifier.deleteListProducts(
                            listId: listId!,
                            productsIds: wishlistStateNotifier.selectedWishlist,
                          );
                        } else {
                          wishlistStateNotifier.deleteWishlist(
                            productsIds: wishlistStateNotifier.selectedWishlist,
                          );
                        }
                      },
                      functionSuccess: () {
                        if (selectProductsByList) {
                          ref.invalidate(
                            getProductsByListProvider(listId!),
                          );
                        } else {
                          ref.invalidate(getAllWishesProductsProvider);
                          for (int i = 0;
                              i < wishlistStateNotifier.selectedWishlist.length;
                              i++) {
                            ref.invalidate(detailsProvider(
                                wishlistStateNotifier.selectedWishlist[i]));
                          }
                        }
                        ref.invalidate(getAllListProvider);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              );
            },
    );
  }
}
