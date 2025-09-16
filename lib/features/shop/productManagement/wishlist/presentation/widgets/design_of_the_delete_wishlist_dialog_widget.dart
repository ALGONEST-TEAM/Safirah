import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../../core/state/state.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../../generated/l10n.dart';
import '../riverpod/wishlist_riverpod.dart';

class DesignOfTheDeleteWishlistDialogWidget extends ConsumerWidget {
  final String title;
  final Function functionSuccess;
  final VoidCallback onPressed;
  final String? messageSuccess;
  final bool hasMessageSuccess;

  const DesignOfTheDeleteWishlistDialogWidget({
    super.key,
    required this.title,
    required this.functionSuccess,
    required this.onPressed,
    this.messageSuccess,
    this.hasMessageSuccess = false,
  });

  @override
  Widget build(BuildContext context, ref) {
    var wishlistState = ref.watch(wishlistProvider);
    ref.watch(wishlistProvider.notifier);
    return Container(
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeTextWidget(
            text: title,
            fontSize: 11.8.sp,
            fontWeight: FontWeight.w500,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          18.h.verticalSpace,
          Row(
            children: [
              Expanded(
                child: DefaultButtonWidget(
                  text: S.of(context).cancel,
                  height: 32.h,
                  textSize: 11.2.sp,
                  borderRadius: 8.r,
                  background: Colors.white,
                  textColor: Colors.black,
                  border: Border.all(
                    color: AppColors.secondaryColor,
                    width: 0.2.w,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              12.w.horizontalSpace,
              Expanded(
                child: CheckStateInPostApiDataWidget(
                  state: wishlistState,
                  hasMessageSuccess: hasMessageSuccess,
                  messageSuccess: messageSuccess,
                  functionSuccess: functionSuccess,
                  bottonWidget: DefaultButtonWidget(
                    text: S.of(context).delete,
                    height: 32.h,
                    textSize: 11.2.sp,
                    borderRadius: 8.r,
                    isLoading: wishlistState.stateData == States.loading,
                    onPressed: onPressed,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
