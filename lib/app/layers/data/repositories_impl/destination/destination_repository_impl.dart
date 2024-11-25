import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destinationDetail/destinationDetail.dart';
import 'package:jejuya/app/layers/data/sources/network/app_api_service.dart';
import 'package:jejuya/app/layers/domain/repositories/destination/destination_repository.dart';
import 'package:jejuya/core/arch/data/network/api_service_provider.dart';
import 'package:jejuya/core/local_storage/local_storage_provider.dart';

/// Implementation of the [DestinationRepository] interface.
class DestinationRepositoryImpl extends DestinationRepository
    with LocalStorageProvider, ApiServiceProvider {
  /// Fetch recommended destinations based on filters.
  @override
  Future<List<Destination>> recommendDestinations({
    required double longitude,
    required double latitude,
    required int radius,
    required String fromDate,
    required String toDate,
  }) async =>
      apiService<AppApiService>().recommendDestinations(
        longitude: longitude,
        latitude: latitude,
        radius: radius,
        fromDate: fromDate,
        toDate: toDate,
      );

  @override
  Future<List<Destination>> fetchNearbyDestinations(
          {required double longitude,
          required double latitude,
          required int radius}) async =>
      apiService<AppApiService>().fetchNearbyDestinations(
          longitude: longitude, latitude: latitude, radius: radius);

  @override
  Future<List<Destination>> searchDestination({String? search}) async =>
      apiService<AppApiService>().searchDestination(search: search);

  @override
  Future<List<Destination>> fetchDestinationsByCategory(
          {String? category}) async =>
      apiService<AppApiService>()
          .fetchDestinationsByCategory(category: category);

  Future<DestinationDetail> fetchDestinationDetail(
    String? destinationId,
  ) async =>
      apiService<AppApiService>()
          .fetchDestinationDetail(destinationDetailId: destinationId);
}
