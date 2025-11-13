import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safirah/core/widgets/logo_shimmer_widget.dart';
import '../../../../../core/network/errors/remote_exception.dart';
import '../../../../../core/state/check_state_in_post_api_data_widget.dart';
import '../../../../../core/state/state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/bottomNavbar/button_bottom_navigation_bar_design_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/error_widget.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../data/model/address_model.dart';
import '../riverpod/address_riverpod.dart';
import '../widgets/add_a_new_address_widget.dart';
import '../widgets/confirm_leave_page_dialog_widget.dart';
import '../widgets/view_location_on_map_widget.dart';

class AddOrUpdateAddressPage extends ConsumerWidget {
  final AddressModel address;
  final bool? locationIsEmpty;
  final Function onSuccess;

  const AddOrUpdateAddressPage({
    super.key,
    required this.address,
    required this.onSuccess,
    this.locationIsEmpty = false,
  });

  @override
  Widget build(BuildContext context, ref) {
    var addressState = ref.watch(addressProvider(address));
    var citiesState = ref.watch(citiesProvider);
    var districtsState = ref.watch(districtsProvider);
    var mapState = ref.watch(mapProvider);

    return WillPopScope(
      onWillPop: address.id == 0
          ? () => ConfirmLeavePageDialogWidget.show(context)
          : () async => true,
      child: Scaffold(
        appBar: SecondaryAppBarWidget(
          title: address.id != 0
              ? S.of(context).editAddress
              : S.of(context).addANewAddress,
          onPressed: () async {
            if (address.id != 0) {
              Navigator.of(context).pop();
            } else {
              final shouldPop =
                  await ConfirmLeavePageDialogWidget.show(context);
              if (shouldPop) {
                Navigator.of(context).pop();
              }
            }
          },
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            children: [
              if (citiesState.stateData == States.loading ||
                  districtsState.stateData == States.loading)
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: const LogoShimmerWidget(),
                )
              else if (citiesState.stateData == States.error ||
                  districtsState.stateData == States.error)
                Center(
                  child: ErrorsWidget(
                    title: MessageOfErorrApi.getExeptionMessage(
                            citiesState.exception!)
                        .first,
                    subTitle: MessageOfErorrApi.getExeptionMessage(
                            citiesState.exception!)
                        .last,
                    onPressed: () {
                      ref.refresh(citiesProvider);
                      ref.refresh(districtsProvider);
                    },
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddANewAddressWidget(
                      address: address,
                    ),
                    12.h.verticalSpace,
                    ViewLocationOnMapWidget(address: address),
                    if (locationIsEmpty == true)
                      if (ref.read(mapProvider.notifier).locationIsEmpty ==
                          true)
                        Padding(
                          padding: EdgeInsets.only(
                              top: 7.h, left: 10.sp, right: 10.sp),
                          child: AutoSizeTextWidget(
                            text: S.of(context).pleaseLocateOnTheMap,
                            fontSize: 10.5.sp,
                            colorText: AppColors.dangerSwatch.shade400,
                          ),
                        ),
                  ],
                ),
            ],
          ),
        ),
        bottomNavigationBar: citiesState.stateData == States.loaded &&
                districtsState.stateData == States.loaded
            ? ButtonBottomNavigationBarDesignWidget(
                child: CheckStateInPostApiDataWidget(
                  state: addressState,
                  functionSuccess: onSuccess,
                  bottonWidget: DefaultButtonWidget(
                    text: S.of(context).save,
                    textSize: 15.sp,
                    height: 41.h,
                    isLoading: addressState.stateData == States.loading,
                    background:
                        ref.read(mapProvider.notifier).locationIsEmpty == false
                            ? AppColors.secondaryColor
                            : AppColors.secondaryColor.withValues(alpha: .6),
                    onPressed:
                        ref.read(mapProvider.notifier).locationIsEmpty == false
                            ? () {
                                ref
                                    .read(addressProvider(address).notifier)
                                    .addOrUpdateAddress(
                                      lat: mapState.location.latitude,
                                      lng: mapState.location.longitude,
                                    );
                              }
                            : null,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
