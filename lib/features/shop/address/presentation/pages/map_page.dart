import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/request_location_permission.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/auto_size_text_widget.dart';
import '../../../../../core/widgets/bottomNavbar/button_bottom_navigation_bar_design_widget.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/secondary_app_bar_widget.dart';
import '../../../../../generated/l10n.dart';
import '../riverpod/address_riverpod.dart';

class MapPage extends ConsumerStatefulWidget {
  final FormGroup form;

  const MapPage({
    super.key,
    required this.form,
  });

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  bool showError = false;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  getCurrentLocation({
    required LatLng latLng,
    required WidgetRef ref,
  }) {
    _controller.future.then((value) {
      value.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng,
            zoom: 15,
          ),
        ),
      );
    });
    _getCityName(latLng);
  }

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(mapProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:  SecondaryAppBarWidget(
        isLogo: true,
        backgroundColor: AppColors.scaffoldColor,
        fromHeight: 60.h,

      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: controller.location,
              zoom: 10,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              Marker(
                markerId: const MarkerId('1'),
                position: controller.location,
                visible: false,
              ),
            },
            onTap: (latLng) {
              getCurrentLocation(latLng: latLng, ref: ref);
            },
          ),
          Visibility(
            visible: showError,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(8.sp),
                margin: EdgeInsets.only(bottom: 120.h, left: 40.w, right: 40.w),
                child: AutoSizeTextWidget(
                  text: S
                      .of(context)
                      .theAddressYouEnteredIsNotWithinTheDeliveryRange,
                  fontSize: 10.sp,
                  maxLines: 12,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppIcons.mapLocation,
                color: AppColors.primaryColor,
                height: 48.h,
              ),
            ),
          ),
          ButtonBottomNavigationBarDesignWidget(
            child: ref.read(mapProvider.notifier).checkForLocationChanges ==
                    false
                ? DefaultButtonWidget(
                    text: S.of(context).confirmAddress,
                    height: 43.h,
                    textSize: 13.5.sp,
                    background: AppColors.secondaryColor.withOpacity(.6),
                  )
                : DefaultButtonWidget(
                    text: S.of(context).confirmAddress,
                    height: 43.h,
                    textSize: 13.5.sp,
                    onPressed: () async {
                      ref.read(mapProvider.notifier).confirmLocation();
                      ref.read(mapProvider.notifier).locationIsEmpty = false;
                      Navigator.pop(context);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 84.h),
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          child: const Icon(
            Icons.my_location,
            color: Colors.white,
            size: 26,
          ),
          onPressed: () async {
            Position position =
                await requestLocationPermissionAndGetCurrentLocation();
            getCurrentLocation(
              latLng: LatLng(position.latitude, position.longitude),
              ref: ref,
            );
          },
        ),
      ),
    );
  }

  String normalizeText(String text) {
    String normalized =
        text.replaceAll(RegExp(r'[\u200E\u200F\u202A-\u202E]'), '');
    normalized = normalized.trim();
    normalized = normalized.toLowerCase();
    return normalized;
  }

  void _compareCity(String cityName, LatLng latLng) {
    String normalizedCityName = normalizeText(cityName);
    int? tempId;
    var citiesState = ref.watch(citiesProvider);

    List<String> normalizedYemenCities =
        citiesState.data.map((city) => normalizeText(city.name)).toList();
    if (normalizedYemenCities.contains(normalizedCityName)) {
      tempId = citiesState.data
          .firstWhere((city) => normalizeText(city.name) == normalizedCityName)
          .id;
      setState(() {
        widget.form.patchValue({
          'city_id': tempId,
          'city_name': cityName,
        });
        widget.form.patchValue({'district_id': null});
        widget.form.patchValue({'district_name': null});
        showError = false;
        ref.read(mapProvider.notifier).changeLocation(latLng);
        ref.read(mapProvider.notifier).checkForLocationChanges = true;
      });
    } else {
      setState(() {
        showError = true;
        ref.read(mapProvider.notifier).checkForLocationChanges = false;
      });
    }
  }

  Future<void> _getCityName(LatLng latLng) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        String? city = placemarks.first.locality;
        if (city != null) {
          _compareCity(city, latLng);
        }
      }
    } catch (e) {
      throw "$e";
    }
  }
}
