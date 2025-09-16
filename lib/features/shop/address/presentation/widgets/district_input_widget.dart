import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/flash_bar_helper.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/base_input.dart';
import '../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/address_model.dart';
import 'list_to_view_all_district_widget.dart';

class DistrictInputWidget extends StatelessWidget {
  final AddressModel addressModel;
  final FormGroup form;

  const DistrictInputWidget(
      {super.key, required this.form, required this.addressModel});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: form.control('city_name').statusChanged,
      builder: (context, snapshot) {
        return BaseInputWidget(
          formControlName: 'district_name',
          keyboardType: TextInputType.none,
          validationMessages: {
            ValidationMessage.required: (e) => S.of(context).provinceIsRequired,
          },
          cursorHeight: 0,
          hintText: S.of(context).province,
          hintTextColor: form.control('city_name').invalid
              ? AppColors.greySwatch.shade500
              : Colors.black,
          onTap: form.control('city_name').invalid
              ? (_) {
                  showFlashBarError(
                    title: S.of(context).pleaseChoseACity,
                    text: S.of(context).toSpecifyTheArea,
                    context: context,
                  );
                }
              : (_) {
                  showModalBottomSheetWidget(
                    context: context,
                    page: ListToViewAllDistrictWidget(
                      address: addressModel,
                      cityId: form.control('city_id').value,
                    ),
                  );
                },
          suffix: Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: SvgPicture.asset(
              AppIcons.arrowBottom,
              color: form.control('city_name').invalid
                  ? AppColors.greySwatch.shade500
                  : AppColors.secondaryColor,
              height: 16.h,
            ),
          ),
        );
      },
    );
  }
}
