import 'dart:async';
import 'dart:convert';

import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
// import 'package:jejuya/app/layers/data/sources/local/model/destinationDetail/destinationDetail.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/destination_detail_usecase.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule_detail/mockup/schedule.dart';
import 'package:jejuya/app/layers/presentation/components/sheet/destination_info/enum/destination_detail_state.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination_detail.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';
import 'package:http/http.dart' as http;

/// Controller for the Destination info sheet
class DestinationInfoController extends BaseController with UseCaseProvider {
  /// Default constructor for the DestinationInfoController.
  DestinationInfoController({
    this.location,
    required this.destination,
    // this.destinationDetail,
  }) {
    fetchDestinationDetail();
  }

  // --- Member Variables ---
  final Destination? destination;
  final Location? location;
  final String apiKey = 'AlzaSyoor0pqspqqN3aQ3YU4sopqb_SYm8XjAlp';
  // DestinationDetail? destinationDetail;
  // --- Computed Variables ---
  // --- State Variables ---

  final destinationDetail = listenableStatus<DestinationDetail?>(null);
  final imageUrl = listenable<String?>(
      'https://dummyimage.com/500x300/cccccc/ffffff&text=No+Image+Available');

  // --- State Computed ---
  // --- Usecases ---
  // --- Methods ---

  final fetchDetailState =
      listenable<DestinationDetailState>(DestinationDetailState.none);

  late final _fetchDestinationDetail = usecase<DestinationDetailUseCase>();

  Future<void> fetchDestinationDetail() async {
    try {
      fetchDetailState.value = DestinationDetailState.loading;

      if (destination?.id == null) return;
      await _fetchDestinationDetail
          .execute(
            DestinationDetailRequest(destinationId: destination?.id),
          )
          .then((response) => response.destinationDetail)
          .assignTo(destinationDetail);
      fetchDetailState.value = DestinationDetailState.done;

      // print(destinationDetail.value!.latitude);
      // print(destinationDetail.value!.longitude);
      final id = await fetchPlaceId(destinationDetail.value!.latitude,
          destinationDetail.value!.longitude, apiKey);

      print(id);
      final re = await fetchPhotoReference(id!, apiKey);
      // print(re);
      // print(getPhotoUrl(re!, apiKey));
      imageUrl.value = getPhotoUrl(re!, apiKey);
    } catch (e, s) {
      log.error(
        '[DestinationDetailController] Failed to fetch detail:',
        error: e,
        stackTrace: s,
      );
      nav.showSnackBar(error: e);
    }
  }

  Future<String?> fetchPlaceId(String lat, String lng, String apiKey) async {
    final url =
        "https://maps.gomaps.pro/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['results'] != null && data['results'].isNotEmpty) {
        //print(data['results'][0]['place_id']);
        return data['results'][0]['place_id'];
      }
    }
    return null;
  }

  Future<String?> fetchPhotoReference(String placeId, String apiKey) async {
    final url =
        "https://maps.gomaps.pro/maps/api/place/details/json?place_id=$placeId&fields=photo&key=$apiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['result'] != null &&
          data['result']['photos'] != null &&
          data['result']['photos'].isNotEmpty) {
        return data['result']['photos'][0]['photo_reference'];
      }
    }
    return null;
  }

  String getPhotoUrl(String photoReference, String apiKey,
      {int maxWidth = 500}) {
    return "https://maps.gomaps.pro/maps/api/place/photo?maxwidth=$maxWidth&photoreference=$photoReference&sensor=false&key=$apiKey";
  }

  Future<void> fetchPhoto() async {
    try {
      final placeId = await fetchPlaceId(
          destination!.latitude, destination!.longitude, apiKey);
      //print(placeId);
      if (placeId != null) {
        final photoReference = await fetchPhotoReference(placeId, apiKey);
        if (photoReference != null) {
          imageUrl.value = getPhotoUrl(photoReference, apiKey);
        }
      }
    } catch (e) {
      log.error('Error fetching photo: $e');
    }
  }

  @override
  FutureOr<void> onDispose() async {}
}
