import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/address_model.dart';
import '../riverpod/address_riverpod.dart';

class DeleteAddressDialogWidget extends ConsumerWidget {
  final AddressModel address;

  const DeleteAddressDialogWidget({super.key, required this.address});

  @override
  Widget build(BuildContext context, ref) {
    var state = ref.watch(addressProvider(address));

    return Padding(
      padding: EdgeInsets.all(12.sp),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).doYouWantToDeleteThisAddress,
            colorText: AppColors.secondaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          8.h.verticalSpace,
          AutoSizeTextWidget(
            text: S.of(context).theAddressWillBePermanentlyDeleted,
            fontSize: 13.sp,
            colorText: AppColors.fontColor2,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          18.h.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: CheckStateInPostApiDataWidget(
                  state: state,
                  messageSuccess: S.of(context).deletedAddressSuccessfully,
                  functionSuccess: () {
                    Navigator.pop(context);
                    ref.refresh(getAllAddressesProvider);
                  },
                  bottonWidget: DefaultButtonWidget(
                    text: S.of(context).yes,
                    height: 38.h,
                    borderRadius: 12.sp,
                    textSize: 12.sp,
                    background: Colors.transparent,
                    textColor: AppColors.secondaryColor,
                    border: Border.all(color: AppColors.secondaryColor),
                    isLoading: state.stateData == States.loading,
                    onPressed: () {
                      ref
                          .read(addressProvider(address).notifier)
                          .deleteAddress();
                    },
                  ),
                ),
              ),
              16.w.horizontalSpace,
              Expanded(
                child: DefaultButtonWidget(
                  text: S.of(context).no,
                  height: 38.h,
                  borderRadius: 12.sp,
                  textSize: 12.sp,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
