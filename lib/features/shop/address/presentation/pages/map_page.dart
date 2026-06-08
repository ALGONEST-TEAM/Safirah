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
import '../../helpers/yemen_delivery_bounds.dart';
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
  String _city = '';
  String _district = '';
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  void getCurrentLocation({
    required LatLng latLng,
    required WidgetRef ref,
  }) {
    _controller.future.then((value) {
      value.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng,
            zoom: 16,
          ),
        ),
      );
    });
    _handleLocationSelection(latLng);
  }

  @override
  Widget build(BuildContext context) {
    var controller = ref.watch(mapProvider);

    return Scaffold(
      appBar: SecondaryAppBarWidget(
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
          Visibility(
            visible: _city.isNotEmpty,
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                margin: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8.w,
                  children: [
                    SvgPicture.asset(AppIcons.address),
                    AutoSizeTextWidget(
                      text:
                      "$_city ${_district.isNotEmpty ? '-' : ''} $_district",
                      fontSize: 10.6.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
          ButtonBottomNavigationBarDesignWidget(
            child: ref
                .read(mapProvider.notifier)
                .checkForLocationChanges ==
                false
                ? DefaultButtonWidget(
              text: S
                  .of(context)
                  .confirmAddress,
              height: 43.h,
              textSize: 13.5.sp,
              background: AppColors.secondaryColor.withValues(alpha: .6),
            )
                : DefaultButtonWidget(
              text: S
                  .of(context)
                  .confirmAddress,
              height: 43.h,
              textSize: 13.5.sp,
              onPressed: () async {
                ref.read(mapProvider.notifier).confirmLocation();
                ref
                    .read(mapProvider.notifier)
                    .locationIsEmpty = false;
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
    final bidi = RegExp(r'[\u200E\u200F\u202A-\u202E]');
    final punctuation = RegExp(
        r'[^\p{L}\p{N}\s]', unicode: true); // يشيل , . - … إلخ
    String normalized = text
        .replaceAll(bidi, '')
        .replaceAll(punctuation, ' ') // نحول الرموز لمسافة
        .toLowerCase()
        .trim();
    normalized = normalized.replaceAll(RegExp(r'\s+'), ' '); // توحيد المسافات
    return normalized;
  }

  void _handleLocationSelection(LatLng latLng) {
    final mapNotifier = ref.read(mapProvider.notifier);
    final isWithinDeliveryBounds = YemenDeliveryBounds.containsLatLng(latLng);

    setState(() {
      showError = !isWithinDeliveryBounds;
    });

    if (!isWithinDeliveryBounds) {
      mapNotifier.checkForLocationChanges = false;
      return;
    }

    mapNotifier.changeLocation(latLng);
    mapNotifier.checkForLocationChanges = true;
    unawaited(_resolveAddressFromCoordinates(latLng));
  }

  Future<void> _resolveAddressFromCoordinates(LatLng latLng) async {
    try {
      final lang = Localizations.localeOf(context).languageCode;
      setLocaleIdentifier(lang);

      final placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks.isEmpty || !mounted) return;

      final placemark = placemarks.first;
      final city = placemark.locality;
      final district = placemark.subLocality;

      setState(() {
        _city = city != null ? normalizeText(city) : '';
        _district = normalizeText(district ?? '');
      });

      if (city != null) {
        _tryAutoFillCityFromName(city);
      }
    } catch (e) {
      debugPrint('Geocoding failed: $e');
    }
  }

  void _tryAutoFillCityFromName(String cityName) {
    final normalizedCityName = normalizeText(cityName);
    final cities = ref.read(citiesProvider).data;

    final matchedCityIndex = cities.indexWhere(
      (city) => normalizeText(city.name) == normalizedCityName,
    );
    if (matchedCityIndex == -1) return;

    final matchedCity = cities[matchedCityIndex];
    widget.form.patchValue({
      'city_id': matchedCity.id,
      'city_name': cityName,
      'district_id': null,
      'district_name': null,
    });
  }
}
