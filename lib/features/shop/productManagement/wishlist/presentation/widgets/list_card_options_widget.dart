import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../../generated/l10n.dart';
import '../riverpod/wishlist_riverpod.dart';
import 'create_a_new_list_dialog_widget.dart';
import 'design_of_the_delete_wishlist_dialog_widget.dart';

class ListCardOptionsWidget extends ConsumerWidget {
  final int listId;
  final String listName;

  const ListCardOptionsWidget({
    super.key,
    required this.listId,
    required this.listName,
  });

  @override
  Widget build(BuildContext context, ref) {
    var wishlistState = ref.watch(wishlistProvider);
    var wishlistStateNotifier = ref.watch(wishlistProvider.notifier);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CheckStateInPostApiDataWidget(
          state: wishlistState,
          hasMessageSuccess: false,
          functionSuccess: () {
            Navigator.of(context).pop();
            ref.refresh(getAllListProvider);
          },
          bottonWidget: DefaultButtonWidget(
            text: S.of(context).rename,
            height: 44.h,
            textSize: 10.2.sp,
            background: Colors.white,
            textColor: Colors.black87.withValues(alpha: .8),
            onPressed: () {
              showModalBottomSheetWidget(
                context: context,
                page: CreateANewListDialogWidget(
                  listId: listId,
                  initialListName: listName,
                ),
              );
            },
          ),
        ),
        Divider(
          color: AppColors.greySwatch.shade100,
          height: 0,
        ),
        DefaultButtonWidget(
          text: S.of(context).deleteList,
          height: 44.h,
          textSize: 10.2.sp,
          background: Colors.white,
          textColor: AppColors.dangerSwatch.shade400,
          onPressed: () {
            showDialog(
              useSafeArea: true,
              context: context,
              builder: (context) {
                return Dialog(
                  alignment: Alignment.center,
                  backgroundColor: Colors.transparent,
                  child: DesignOfTheDeleteWishlistDialogWidget(
                    title: S.of(context).areYouSureYouWantToDeleteTheList,
                    messageSuccess:
                        S.of(context).theListHasBeenDeletedSuccessfully,
                    onPressed: () {
                      wishlistStateNotifier.deleteList(listId: listId);
                    },
                    functionSuccess: () {
                      ref.refresh(getAllListProvider);
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 50), () {
                        if (context.mounted) {
                          showFlashBarSuccess(
                            message:
                                S.of(context).theListHasBeenDeletedSuccessfully,
                            context: context,
                          );
                        }
                      });
                    },
                  ),
                );
              },
            );
          },
        ),
        6.h.verticalSpace,
        DefaultButtonWidget(
          text: S.of(context).cancel,
          height: 44.h,
          textSize: 10.2.sp,
          background: Colors.white,
          textColor: Colors.black87.withValues(alpha: .8),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
