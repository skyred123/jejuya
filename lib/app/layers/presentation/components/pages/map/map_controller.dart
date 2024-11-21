import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:jejuya/app/common/ui/image/image_local.dart';
import 'package:jejuya/app/common/utils/extension/num/adaptive_size.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/get_nearby_destination_usecase.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';

class MapController extends BaseController with UseCaseProvider {
  /// Default constructor for the MapController.
  MapController() {
    initialize();
  }

  @override
  Future<void> initialize() async {
    _loadHotelMarkerIcon();
    _loadTouristMarkerIcon();
    _loadSelectedHotelMarkerIcon();
    await fetchNearbyDestinations();
    return super.initialize();
  }

  // --- Member Variables ---
  final Completer<GoogleMapController> _mapController = Completer();
  final TextEditingController searchController = TextEditingController();
  static const LatLng jejuIsland = LatLng(33.363646, 126.545454);

  /// Usecase for fetching nearby destinations
  late final _getNearbyDestinationUsecase =
      usecase<GetNearbyDestinationUsecase>();

  // --- Computed Variables ---
  CameraPosition get initialCameraPosition => const CameraPosition(
        target: jejuIsland,
        zoom: 11,
      );

  // --- State Variables ---
  final hotelMarkerIcon = listenable<BitmapDescriptor>(
    BitmapDescriptor.defaultMarker,
  );
  final touristMarkerIcon = listenable<BitmapDescriptor>(
    BitmapDescriptor.defaultMarker,
  );
  final selectedHotelMarkerIcon = listenable<BitmapDescriptor>(
    BitmapDescriptor.defaultMarker,
  );
  final radiusInMeters = listenable<double>(5000.0);
  final isRadiusSliderVisible = listenable<bool>(false);
  final selectedMarkerPosition =
      listenable<LatLng>(const LatLng(33.5050011, 126.5277575));
  String? selectedHotelMarkerId;

  /// List of markers
  final markers = listenable<List<Marker>>([]);

  /// Current list of destinations
  final destinations = listenable<List<Destination>>([]);

  // --- Methods ---

  void onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  void setRadius(double newRadius) async {
    radiusInMeters.value = newRadius;

    // Main marker
    Marker mainMarker = Marker(
      markerId: const MarkerId('main_marker'),
      position: selectedMarkerPosition.value,
      icon: selectedHotelMarkerId == null
          ? hotelMarkerIcon.value
          : selectedHotelMarkerIcon.value,
    );

    // Clear existing markers
    markers.value = [];

    // Fetch new data using the use case
    final request = GetNearbyDestinationRequest(
      longitude: selectedMarkerPosition.value.longitude,
      latitude: selectedMarkerPosition.value.latitude,
      radius: (newRadius / 1000).toInt(), // Convert meters to kilometers
    );

    final response =
        await usecase<GetNearbyDestinationUsecase>().execute(request);

    // Rebuild markers from the API response
    final updatedMarkers = response.destinations.map((destination) {
      return Marker(
        markerId: MarkerId(destination.id.toString()),
        position: LatLng(double.parse(destination.latitude),
            double.parse(destination.longitude)),
        icon: touristMarkerIcon.value,
        onTap: () {
          log.info('Selected destination: ${destination.businessNameEnglish}');
        },
      );
    }).toList();

    // Update the markers observable
    markers.value = updatedMarkers;

    markers.value = [mainMarker, ...updatedMarkers];
  }

  void toggleRadiusSlider() {
    isRadiusSliderVisible.value = !isRadiusSliderVisible.value;
  }

  Future<void> fetchNearbyDestinations() async {
    try {
      final radiusInKm = (radiusInMeters.value / 1000).toInt();
      final position = selectedMarkerPosition.value;

      final response = await _getNearbyDestinationUsecase.execute(
        GetNearbyDestinationRequest(
          longitude: position.longitude,
          latitude: position.latitude,
          radius: radiusInKm,
        ),
      );

      destinations.value = response.destinations;
      updateMarkers();
    } catch (e, s) {
      log.error('[MapController] Error fetching nearby destinations',
          error: e, stackTrace: s);
    }
  }

  void updateMarkers() {
    // Main marker
    Marker mainMarker = Marker(
      markerId: const MarkerId('main_marker'),
      position: selectedMarkerPosition.value,
      icon: selectedHotelMarkerId == null
          ? hotelMarkerIcon.value
          : selectedHotelMarkerIcon.value,
    );

    // Tourist markers from destinations
    List<Marker> touristMarkers = destinations.value.map((destination) {
      return Marker(
        markerId: MarkerId(destination.id.toString()),
        position: LatLng(
          double.parse(destination.latitude),
          double.parse(destination.longitude),
        ),
        icon: touristMarkerIcon.value,
        onTap: () {
          log.info('Selected Destination: ${destination.businessNameEnglish}');
        },
      );
    }).toList();

    // Update markers list
    markers.value = [mainMarker, ...touristMarkers];
  }

  // Marker Icon Loaders
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
  FutureOr<void> onDispose() async {
    final controller = await _mapController.future;
    controller.dispose();
  }
}
