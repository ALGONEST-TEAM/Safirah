import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/base_input.dart';
import '../../../../../core/widgets/show_modal_bottom_sheet_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/address_model.dart';
import '../riverpod/address_riverpod.dart';
import 'district_input_widget.dart';
import 'list_to_view_all_cities_widget.dart';

class AddANewAddressWidget extends ConsumerStatefulWidget {
  final AddressModel address;

  const AddANewAddressWidget({
    super.key,
    required this.address,
  });

  @override
  ConsumerState<AddANewAddressWidget> createState() =>
      _AddANewAddressWidgetState();
}

class _AddANewAddressWidgetState extends ConsumerState<AddANewAddressWidget> {
  @override
  Widget build(BuildContext context) {
    ref.watch(addressProvider(widget.address).notifier);
    ref.watch(citiesProvider);
    ref.watch(districtsProvider);
    return ReactiveFormBuilder(
      form: () => ref.read(addressProvider(widget.address).notifier).form.group,
      builder: (context, form, child) {
        return Column(
          children: [
            BaseInputWidget(
              formControlName: 'address',
              validationMessages: {
                ValidationMessage.required: (e) =>
                    S.of(context).addressIsRequired,
              },
              hintText: S.of(context).address,
              fontSize: 13.sp,
            ),
            BaseInputWidget(
              formControlName: 'phone_number',
              hintText: S.of(context).phoneNumber,
              fontSize: 13.sp,
              inputFormatters: [
                LengthLimitingTextInputFormatter(9),
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.phone,
              validationMessages: {
                ValidationMessage.required: (e) =>
                    S.of(context).pleaseEnterPhoneNumber,
                ValidationMessage.pattern: (e) =>
                    S.of(context).invalidPhoneNumber,
              },
            ),
            BaseInputWidget(
              formControlName: 'city_name',
              keyboardType: TextInputType.none,
              validationMessages: {
                ValidationMessage.required: (e) =>
                    S.of(context).pleaseChoseACity,
              },
              cursorHeight: 0,
              hintText: S.of(context).city,
              fontSize: 13.sp,
              onTap: (i) {
                showModalBottomSheetWidget(
                  context: context,
                  page: ListToViewAllCitiesWidget(
                    address: widget.address,
                  ),
                );
              },
              suffix: Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: SvgPicture.asset(
                  AppIcons.arrowBottom,
                  color: AppColors.secondaryColor,
                  height: 16.h,
                ),
              ),
            ),
            DistrictInputWidget(
              form: form,
              addressModel: widget.address,
            ),
            BaseInputWidget(
              formControlName: 'nearest_landmark',
              validationMessages: {
                ValidationMessage.required: (e) =>
                    S.of(context).nearestLandmarkIsRequired
              },
              hintText: S.of(context).nearestLandmark,
            ),
          ],
        );
      },
    );
  }
}
