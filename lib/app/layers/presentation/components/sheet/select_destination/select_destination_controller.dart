import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jejuya/app/common/ui/image/image_local.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/layers/presentation/components/pages/map/mockup/hotel_location_mockup_api.dart';
import 'package:jejuya/app/layers/presentation/components/pages/map/mockup/tourist_location_mockup_api.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';

/// Controller for the Select destination sheet
class SelectDestinationController extends BaseController with UseCaseProvider {
  /// Default constructor for the SelectDestinationController.
  SelectDestinationController() {
    initialize();
  }

  @override
  Future<void> initialize() async {
    _loadHotelMarkerIcon();
    _loadTouristMarkerIcon();
    _loadSelectedHotelMarkerIcon();

    return super.initialize();
  }

  // --- Member Variables ---

  /// Search Controller
  final TextEditingController searchController = TextEditingController();

  /// Completer<GoogleMapController>
  final Completer<GoogleMapController> _mapController = Completer();

  /// Jeju Island's coordinates
  static const LatLng jejuIsland = LatLng(33.363646, 126.545454);
  // --- Computed Variables ---

  /// Jeju Island's camera position
  CameraPosition get initialCameraPosition => const CameraPosition(
        target: jejuIsland,
        zoom: 11.0,
      );
  // --- State Variables ---

  /// Marker Icons
  final hotelMarkerIcon = listenable<BitmapDescriptor>(
    BitmapDescriptor.defaultMarker,
  );

  final touristMarkerIcon = listenable<BitmapDescriptor>(
    BitmapDescriptor.defaultMarker,
  );

  final selectedHotelMarkerIcon = listenable<BitmapDescriptor>(
    BitmapDescriptor.defaultMarker,
  );

  /// Radius around the marker in meters (default 5000 meters = 5 km)
  final radiusInMeters = listenable<double>(5000.0);

  /// Visibility of the radius slider
  final isRadiusSliderVisible = listenable<bool>(false);

  /// Selected marker
  final selectedMarkerPosition =
      listenable<LatLng>(const LatLng(33.5050011, 126.5277575));

  String? selectedHotelMarkerId;

  /// List of markers
  List<Marker> get markers {
    // Main marker
    Marker mainMarker = Marker(
      markerId: const MarkerId('main_marker'),
      position: selectedMarkerPosition.value,
      icon: selectedHotelMarkerId == null
          ? hotelMarkerIcon.value
          : selectedHotelMarkerIcon.value,
    );

    // Tourist Location markers
    List<Marker> locationMarkers = touristLocationMockup.map((location) {
      return Marker(
          markerId: MarkerId(location['id'].toString()),
          position: LatLng(location['Latitude'], location['Longitude']),
          icon: touristMarkerIcon.value,
          onTap: () {});
    }).toList();

    // Hotel Location markers
    List<Marker> hotelMarkers = hotelLocationMockup.map((location) {
      final isSelectedMarker = selectedHotelMarkerId == location['id'];

      return Marker(
        markerId: MarkerId(location['id'].toString()),
        position: LatLng(
          double.parse(location['Latitude']),
          double.parse(
            location['Longitude'],
          ),
        ),
        icon: isSelectedMarker
            ? selectedHotelMarkerIcon.value
            : hotelMarkerIcon.value,
        onTap: () {
          setSelectedMarker(location);
        },
      );
    }).toList();

    // Return a list containing both the main marker and the location markers
    return [mainMarker, ...locationMarkers, ...hotelMarkers];
  }
  // --- State Computed ---
  // --- Usecases ---
  // --- Methods ---

  void onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  void setRadius(double newRadius) {
    radiusInMeters.value = newRadius;
  }

  void toggleRadiusSlider() {
    isRadiusSliderVisible.value = !isRadiusSliderVisible.value;
  }

  void setSelectedMarker(Map<String, dynamic> hotel) {
    selectedHotelMarkerId = hotel['id'];
    selectedMarkerPosition.value = LatLng(
      double.parse(hotel['Latitude']),
      double.parse(hotel['Longitude']),
    );
  }

  void _loadHotelMarkerIcon() {
    BitmapDescriptor.asset(
      ImageConfiguration(
        size: Size(40.wMin, 40.hMin),
      ),
      LocalImageRes.hotelMarkerIcon,
    ).then(
      (icon) {
        hotelMarkerIcon.value = icon;
      },
    );
  }

  void _loadTouristMarkerIcon() {
    BitmapDescriptor.asset(
      ImageConfiguration(
        size: Size(40.wMin, 40.hMin),
      ),
      LocalImageRes.touristMarkerIcon,
    ).then(
      (icon) {
        touristMarkerIcon.value = icon;
      },
    );
  }

  void _loadSelectedHotelMarkerIcon() {
    BitmapDescriptor.asset(
      ImageConfiguration(
        size: Size(50.wMin, 45.hMin),
      ),
      LocalImageRes.hotelSelectedMarkerIcon,
    ).then(
      (icon) {
        selectedHotelMarkerIcon.value = icon;
      },
    );
  }

  @override
  FutureOr<void> onDispose() async {}
}
