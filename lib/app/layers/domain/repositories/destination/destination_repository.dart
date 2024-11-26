import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination_detail.dart';
import 'package:jejuya/app/layers/data/sources/local/model/hotel/hotel.dart';
import 'package:jejuya/core/arch/domain/repository/base_repository.dart';

/// Repository for the destination
abstract class DestinationRepository extends BaseRepository {
  /// Fetch recommended destinations based on location and date filters.
  Future<List<Destination>> recommendDestinations({
    required double longitude,
    required double latitude,
    required int radius,
    required String fromDate,
    required String toDate,
  });

  Future<DestinationDetail> fetchDestinationDetail({
    required String? destinationId,
  });
  Future<List<Destination>> fetchNearbyDestinations({
    required double longitude,
    required double latitude,
    required int radius,
  });

  // Future<DestinationDetail> fetchDestinationDetail({
  //   required String id,
  // });

  Future<List<Destination>> searchDestination({String? search});

  Future<List<Destination>> fetchDestinationsByCategory({String? category});

  Future<List<Hotel>> fetchHotels();
}
