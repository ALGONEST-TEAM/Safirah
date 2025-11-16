import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/state/check_state_in_get_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/bottomNavbar/button_bottom_navigation_bar_design_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/logo_shimmer_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/address_model.dart';
import '../riverpod/address_riverpod.dart';
import '../widgets/address_card_widget.dart';
import 'add_or_update_address_page.dart';

class ViewAllAddressPage extends ConsumerWidget {
  const ViewAllAddressPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var controller = ref.watch(getAllAddressesProvider);
    return Scaffold(
      appBar: SecondaryAppBarWidget(
        title: S.of(context).addressBook,
        fontSize: 15.sp,
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        backgroundColor: Colors.white,
        onRefresh: () async {
          ref.invalidate(getAllAddressesProvider);
        },
        child: CheckStateInGetApiDataWidget(
          state: controller,
          refresh: () {
            ref.invalidate(getAllAddressesProvider);
          },
          widgetOfLoading: const LogoShimmerWidget(),

          widgetOfData: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(12.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.data.isEmpty)
                  SizedBox(
                    width: double.infinity,
                    height: 300.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 6.h,
                      children: [
                        Icon(
                          Icons.location_off_outlined,
                          size: 54.sp,
                          color: AppColors.primaryColor,
                        ),
                        AutoSizeTextWidget(
                          text: S.of(context).addressesEmpty,
                          fontSize: 16.sp,
                        ),
                        AutoSizeTextWidget(
                          text: S.of(context).pleaseAddAddress,
                          fontSize: 13.sp,
                          colorText: AppColors.fontColor,
                        ),
                      ],
                    ),
                  )
                else
                  AutoSizeTextWidget(
                    text: S.of(context).myAddresses,
                    colorText: AppColors.mainColorFont,
                    fontWeight: FontWeight.w600,
                    fontSize: 13.8.sp,
                  ),
                12.h.verticalSpace,
                Column(
                  children: controller.data.map((e) {
                    return AddressCardWidget(address: e);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: controller.stateData == States.loaded
          ? ButtonBottomNavigationBarDesignWidget(
              child: DefaultButtonWidget(
                text: S.of(context).addANewAddress,
                withIcon: true,
                icon: AppIcons.plus,
                onPressed: () {
                  navigateTo(
                    context,
                    AddOrUpdateAddressPage(
                      address: AddressModel.empty(),
                      onSuccess: () {
                        ref.invalidate(getAllAddressesProvider);
                        Navigator.of(context).pop();
                      },
                      locationIsEmpty: true,
                    ),
                  );
                },
              ),
            )
          : null,
    );
  }
}
