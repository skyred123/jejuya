import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jejuya/app/common/ui/image/image_local.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination_detail.dart';
import 'package:jejuya/app/layers/data/sources/local/model/hotel/hotel.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/get_destination_detail_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/get_hotel_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/get_nearby_destination_usecase.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';

class MapController extends BaseController with UseCaseProvider {
  /// Default constructor for the MapController.
  MapController() {
    initialize();
  }

  @override
  Future<void> initialize() async {
    await _fetchHotels();
    await _fetchNearbyDestinations();
    await _getCurrentLocation();
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
  final currentMarkerIcon = listenable<BitmapDescriptor>(
    BitmapDescriptor.defaultMarker,
  );
  final radiusInMeters = listenable<double>(5000.0);
  final isRadiusSliderVisible = listenable<bool>(false);
  final selectedMarkerPosition =
      listenable<LatLng>(const LatLng(33.5050011, 126.5277575));
  final currentMarkerPosition =
      listenable<LatLng>(const LatLng(33.5050011, 126.5277575));
  String? selectedHotelMarkerId;

  /// List of markers
  final markers = listenable<List<Marker>>([]);

  /// Current list of destinations
  final destinations = listenable<List<Destination>>([]);

  final hotels = listenable<List<Hotel>>([]);

  double _currentZoomLevel = 11.0;
  double minZoomForMarkers = 11.0;

  // --- Methods ---

  void onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
    _updateMarkerIcons(_currentZoomLevel);
  }

  void setRadius(double newRadius) async {
    radiusInMeters.value = newRadius;
    await _fetchNearbyDestinations();
  }

  void toggleRadiusSlider() {
    isRadiusSliderVisible.value = !isRadiusSliderVisible.value;
  }

  Future<void> _fetchNearbyDestinations() async {
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
      _updateMarkers();
    } catch (e, s) {
      log.error('[MapController] Error fetching nearby destinations',
          error: e, stackTrace: s);
    }
  }

  Future<void> _fetchHotels() async {
    try {
      final response = await GetHotelUsecase().execute(
        GetHotelRequest(),
      );

      hotels.value = response.hotels;
    } catch (e, s) {
      log.error('[MapController] Error fetching hotels',
          error: e, stackTrace: s);
    }
  }

  Future<DestinationDetail> _fetchDestinationDetail(String id) async {
    try {
      final response = await GetDestinationDetailUsecase().execute(
        GetDestinationDetailRequest(id: id),
      );

      return response.destinationDetail;
    } catch (e, s) {
      log.error('Error fetching destination details', error: e, stackTrace: s);
      rethrow;
    }
  }

  void _updateMarkers() {
    markers.value = [];

    // User position marker (main marker)
    Marker userMarker = Marker(
        markerId: const MarkerId('user_marker'),
        position: currentMarkerPosition.value,
        icon: BitmapDescriptor.defaultMarker, // Use different icon for user
        zIndex: 3,
        onTap: () {
          // Update the center position for radius and nearby search
          selectedMarkerPosition.value = currentMarkerPosition.value;
          _centerOnPosition(selectedMarkerPosition.value);
          _fetchNearbyDestinations();
          _updateMarkers();
        });

    // Hotel markers
    List<Marker> hotelMarkers = hotels.value.map((hotel) {
      bool isSelected = selectedHotelMarkerId == hotel.id;
      return Marker(
          markerId: MarkerId('hotel_${hotel.id}'),
          position: LatLng(
            double.parse(hotel.latitude),
            double.parse(hotel.longitude),
          ),
          icon: isSelected
              ? selectedHotelMarkerIcon.value
              : hotelMarkerIcon.value,
          zIndex: isSelected ? 3 : 1,
          onTap: () {
            selectedHotelMarkerId = hotel.id;
            // Update the center position for radius and nearby search
            selectedMarkerPosition.value = LatLng(
              double.parse(hotel.latitude),
              double.parse(hotel.longitude),
            );
            _centerOnPosition(selectedMarkerPosition.value);
            _fetchNearbyDestinations();
            _updateMarkers();
          });
    }).toList();

    // Tourist markers remain the same
    List<Marker> touristMarkers = destinations.value.map((destination) {
      return Marker(
        markerId: MarkerId(destination.id.toString()),
        position: LatLng(
          double.parse(destination.latitude),
          double.parse(destination.longitude),
        ),
        icon: touristMarkerIcon.value,
        zIndex: 2,
        onTap: () async {
          nav.showDetinationInfoSheet(destination: destination);
        },
      );
    }).toList();

    markers.value = [userMarker, ...touristMarkers, ...hotelMarkers];
  }

  void _centerOnPosition(LatLng position) async {
    final controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLng(position));
  }

  // Load and resize marker icons dynamically
  Future<BitmapDescriptor> _resizeMarkerIcon(
      String assetPath, double size) async {
    ByteData data = await rootBundle.load(assetPath);
    Uint8List bytes = data.buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(bytes,
        targetWidth: size.toInt(), targetHeight: size.toInt());
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    final resizedBytes =
        (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();
    return BitmapDescriptor.fromBytes(resizedBytes);
  }

  void _updateMarkerIcons(double zoomLevel) async {
    double markerSize = (zoomLevel * 2).clamp(25, 40);

    hotelMarkerIcon.value =
        await _resizeMarkerIcon(LocalImageRes.hotelMarkerIcon, markerSize);
    touristMarkerIcon.value =
        await _resizeMarkerIcon(LocalImageRes.touristMarkerIcon, markerSize);
    selectedHotelMarkerIcon.value =
        await _resizeMarkerIcon(LocalImageRes.hotelSelectedMarkerIcon, 30);
  }

  void onCameraMove(CameraPosition position) {
    double newZoomLevel = position.zoom;
    if ((newZoomLevel - _currentZoomLevel).abs() >= 0.5) {
      _currentZoomLevel = newZoomLevel;
      _updateMarkerIcons(newZoomLevel);
    }
  }

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentMarkerPosition.value = LatLng(position.latitude, position.longitude);
    selectedMarkerPosition.value =
        LatLng(position.latitude, position.longitude);
    // // Update camera position to current location
    // final controller = await _mapController.future;
    // controller
    //     .animateCamera(CameraUpdate.newLatLng(selectedMarkerPosition.value));

    // Fetch nearby destinations for new position
    await _fetchNearbyDestinations();
  }

  @override
  FutureOr<void> onDispose() async {
    final controller = await _mapController.future;
    controller.dispose();
  }
}
