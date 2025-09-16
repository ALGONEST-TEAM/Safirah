import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/helpers/navigateTo.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../data/model/address_model.dart';
import '../pages/map_page.dart';
import '../riverpod/address_riverpod.dart';

class ViewLocationOnMapWidget extends ConsumerStatefulWidget {
  final AddressModel address;

  const ViewLocationOnMapWidget({
    super.key,
    required this.address,
  });

  @override
  ConsumerState<ViewLocationOnMapWidget> createState() =>
      _ViewLocationOnMapWidgetState();
}

class _ViewLocationOnMapWidgetState
    extends ConsumerState<ViewLocationOnMapWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  LatLng location = const LatLng(15.369445, 44.191006);

  StreamSubscription<LatLng>? locationStream;

  @override
  void initState() {
    ref.read(mapProvider.notifier).locationStream.listen((event) {
      setState(() {
        location = event;
        _controller.future.then((value) {
          value.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: event,
                zoom: 15,
              ),
            ),
          );
        });
      });
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        location = LatLng(
          double.parse(widget.address.lat.toString()),
          double.parse(widget.address.lon.toString()),
        );
        ref.read(mapProvider.notifier).changeLocation(location);

        _controller.future.then((value) {
          value.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: location,
                zoom: 15,
              ),
            ),
          );
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    locationStream?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(mapProvider);

    return ReactiveFormBuilder(
      form: () => ref.read(addressProvider(widget.address).notifier).form.group,
      builder: (context, form, child) {
        return InkWell(
          onTap: () {
            navigateTo(
                context,
                MapPage(
                  form: form,
                ));
            ref.read(mapProvider.notifier).confirmLocation();
          },
          child: IgnorePointer(
            ignoring: true,
            child: Container(
              height: 160.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppColors.greySwatch.shade200,
                ),
                color: AppColors.greySwatch.shade200,
              ),
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: location,
                      zoom: 15,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId("1"),
                        position: location,
                        visible: false,
                      ),
                    },
                    zoomControlsEnabled: false,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          AppIcons.mapLocation,
                          color: AppColors.primaryColor,
                          height: 44.h,
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
