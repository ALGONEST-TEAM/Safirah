import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:safirah/core/theme/app_colors.dart';
import '../../../../../../core/constants/app_icons.dart';
import '../../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../../generated/l10n.dart';
import 'bottom_sheet_design_for_order_confirmation_addresses_widget.dart';
import '../../../../../../core/widgets/general_design_for_order_details_widget.dart';
import 'required_inputs_widget.dart';

class AddressToConfirmTheOrderWidget extends StatelessWidget {
  final FormGroup form;

  const AddressToConfirmTheOrderWidget({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: GeneralDesignForOrderDetailsWidget(
            title: S.of(context).deliveryAddress,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  AppIcons.deliveryAddress,
                  height: 44.h,
                ),
                8.w.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AutoSizeTextWidget(
                        text: form.control('address').invalid
                            ? S.of(context).address
                            : form.control('address').value,
                        fontSize: 12.4.sp,
                        colorText: AppColors.mainColorFont,
                        fontWeight: FontWeight.w500,
                      ),
                      4.h.verticalSpace,
                      AutoSizeTextWidget(
                        text: form.control('district').value ?? "",
                        fontSize: 10.4.sp,
                        colorText: AppColors.fontColor2,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
                SvgPicture.asset(
                  AppIcons.arrowLeft,
                  height: 16.h,
                ),
                4.w.horizontalSpace,
              ],
            ),
          ),
          onTap: () {
            scrollShowModalBottomSheetWidget(
              context: context,
              title: S.of(context).yourAddress,
              page: BottomSheetDesignForOrderConfirmationAddressesWidget(
                form: form,
              ),
            );
          },
        ),
        RequiredInputsWidget(
          form: form,
          value: 'address',
          requiredText: S.of(context).addressIsRequired,
        ),
      ],
    );
  }
}
