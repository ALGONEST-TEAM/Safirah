import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../generated/l10n.dart';
import '../riverpod/wishlist_riverpod.dart';
import 'design_create_a_new_list_widget.dart';
import 'design_list_items_for_modal_bottom_sheet_widget.dart';
import 'dialog_list_title_widget.dart';
import 'empty_list_widget.dart';

class AddOrCopyToTheListDialogWidget extends ConsumerStatefulWidget {
  final int? listId;

  const AddOrCopyToTheListDialogWidget({
    super.key,
    this.listId,
  });

  @override
  ConsumerState<AddOrCopyToTheListDialogWidget> createState() =>
      _AddOrCopyToTheListDialogWidgetState();
}

class _AddOrCopyToTheListDialogWidgetState
    extends ConsumerState<AddOrCopyToTheListDialogWidget> {
  int tempListId = 0;

  @override
  Widget build(BuildContext context) {
    var wishlistState = ref.watch(wishlistProvider);
    var wishlistStateNotifier = ref.read(wishlistProvider.notifier);
    var state = ref.read(getAllListProvider);
    var filteredData =
        state.data.where((item) => item.id != widget.listId).toList();

    return Container(
      margin: EdgeInsets.only(top: 180.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.sp),
          topRight: Radius.circular(14.sp),
        ),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(14.sp),
        child: filteredData.isEmpty
            ? Column(
                children: [
                  DialogListTitleWidget(title: S.of(context).addToList),
                  const EmptyListWidget(
                    navigateToProductSelectionPage: false,
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DialogListTitleWidget(
                    title: widget.listId == null
                        ? S.of(context).addToList
                        : S.of(context).copyToList,
                  ),
                  DesignCreateANewListWidget(
                    backgroundColor: AppColors.fontColor.withOpacity(.1),
                    horizontal: 0,
                    vertical: 2.h,
                    fontSize: 10.4.sp,
                    // navigateToProductSelectionPage: false,
                  ),
                  2.h.verticalSpace,
                  Divider(
                    color: AppColors.greySwatch.shade50,
                  ),
                  CheckStateInPostApiDataWidget(
                    state: wishlistState,
                    hasMessageSuccess: true,
                    messageSuccess:
                        S.of(context).productsHaveBeenAddedToTheList,
                    functionSuccess: () {
                      ref.refresh(getAllListProvider);
                      Navigator.pop(context);
                    },
                    bottonWidget: Column(
                      children: filteredData.map((items) {
                        return GestureDetector(
                          onTap: () {
                            setState(() => tempListId = items.id);
                            wishlistStateNotifier.createAnewListAndAddProducts(
                              listId: items.id,
                              listName: "",
                              productsIds:
                                  wishlistStateNotifier.selectedWishlist,
                            );
                          },
                          child: DesignListItemsForModalBottomSheetWidget(
                            listId: items.id,
                            name: items.name,
                            image1: items.image.isEmpty ? "" : items.image[0],
                            image2: items.image.isEmpty
                                ? ""
                                : items.image.length < 2
                                    ? ""
                                    : items.image[1],
                            image3: items.image.isEmpty
                                ? ""
                                : items.image.length <= 2
                                    ? ""
                                    : items.image[2],
                            isLoading:
                                wishlistState.stateData == States.loading &&
                                    tempListId == items.id,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
