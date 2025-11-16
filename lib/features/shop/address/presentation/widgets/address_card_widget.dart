import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../data/model/address_model.dart';
import '../pages/add_or_update_address_page.dart';
import '../riverpod/address_riverpod.dart';
import 'delete_address_dialog_widget.dart';

class AddressCardWidget extends ConsumerWidget {
  final AddressModel address;

  const AddressCardWidget({super.key, required this.address});

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      padding: EdgeInsets.all(10.sp),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black26.withValues(alpha: 0.02),
            blurRadius: 1.r,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 10.w,
        children: [
          Flexible(
            child: AutoSizeTextWidget(
              text:
                  "${address.address.toString()} , ${address.cityName.toString()} , ${address.districtName.toString()}",
              fontSize: 12.sp,
              maxLines: 2,
              fontWeight: FontWeight.w500,
              colorText: AppColors.fontColor,
            ),
          ),
          Row(
            spacing: 10.w,
            children: [
              InkWell(
                onTap: () {
                  ref.watch(mapProvider);
                  ref.read(mapProvider.notifier).locationIsEmpty = false;
                  navigateTo(
                    context,
                    AddOrUpdateAddressPage(
                      address: address,
                      onSuccess: () {
                        ref.invalidate(getAllAddressesProvider);
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
                child: SvgPicture.asset(
                  AppIcons.edit,
                ),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheetWidget(
                    context: context,
                    page: DeleteAddressDialogWidget(
                      address: address,
                    ),
                  );
                },
                child: SvgPicture.asset(
                  AppIcons.deleteAddress,
                  height: 25.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
