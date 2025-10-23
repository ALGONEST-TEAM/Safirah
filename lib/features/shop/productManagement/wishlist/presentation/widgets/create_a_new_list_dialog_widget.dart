import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/helpers/navigateTo.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../core/widgets/text_form_field.dart';
import '../../../../../../generated/l10n.dart';
import '../pages/select_products_page.dart';
import '../riverpod/wishlist_riverpod.dart';
import 'dialog_list_title_widget.dart';

class CreateANewListDialogWidget extends ConsumerWidget {
  final int? listId;
  final String? initialListName;
  final bool navigateToProductSelectionPage;

  CreateANewListDialogWidget({
    super.key,
    this.listId,
    this.initialListName,
    this.navigateToProductSelectionPage = false,
  });

  final TextEditingController listNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    var wishlistState = ref.watch(wishlistProvider);
    var wishlistStateNotifier = ref.watch(wishlistProvider.notifier);
    if (initialListName != null) {
      listNameController.text = initialListName!;
    }
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(14.sp),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DialogListTitleWidget(
              title: listId == null
                  ? S.of(context).createANewList
                  : S.of(context).rename,
            ),
            8.h.verticalSpace,
            AutoSizeTextWidget(
              text: S.of(context).listName,
              fontSize: 10.6.sp,
              fontWeight: FontWeight.w600,
            ),
            4.h.verticalSpace,
            TextFormFieldWidget(
              controller: listNameController,
              hintText: "Board",
              hintTextColor: Colors.black87,
              autofocus: true,
              hintFontSize: 12.sp,
              fieldValidator: (value) {
                if (value == null || value.toString().isEmpty) {
                  return S.of(context).pleaseEnterAListName;
                }
                return null;
              },
            ),
            Divider(
              color: AppColors.greySwatch.shade100,
              height: 3.h,
            ),
            20.h.verticalSpace,
            CheckStateInPostApiDataWidget(
              state: wishlistState,
              messageSuccess: listId == null
                  ? S.of(context).aNewListHasBeenCreatedSuccessfully
                  : S.of(context).theModificationHasBeenCompletedSuccessfully,
              functionSuccess: () {
                ref.refresh(getAllListProvider);
                Navigator.of(context).pop();
              },
              bottonWidget: DefaultButtonWidget(
                text: listId == null
                    ? S.of(context).createAList
                    : S.of(context).confirm,
                height: 34.h,
                textSize: 11.sp,
                isLoading: wishlistState.stateData == States.loading,
                onPressed: () {
                  final isValid = formKey.currentState!.validate();
                  if (isValid) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (listId == null) {
                      if (navigateToProductSelectionPage == false) {
                        wishlistStateNotifier.createAnewListAndAddProducts(
                          listId: 0,
                          listName: listNameController.text,
                          productsIds: wishlistStateNotifier.selectedWishlist,
                        );
                      } else {
                        Navigator.of(context).pop();
                        navigateTo(
                          context,
                          SelectProductsPage(
                            listName: listNameController.text,
                          ),
                        );
                      }
                    } else {
                      wishlistStateNotifier.renameTheList(
                        listId: listId!,
                        listName: listNameController.text,
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
