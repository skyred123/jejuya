import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';

import '../../../../../core/arch/domain/repository/repository_provider.dart';
import '../../../data/sources/local/model/destination/destination.dart';
import '../../repositories/destination/destination_repository.dart';

class GetNearbyDestinationUsecase extends BaseUseCase<
    GetNearbyDestinationRequest,
    GetNearbyDestinationResponse> with RepositoryProvider {
  /// Default constructor for the GetNearbyDestinationUsecase.
  GetNearbyDestinationUsecase();

  @override
  Future<GetNearbyDestinationResponse> execute(
      GetNearbyDestinationRequest request) async {
    return repository<DestinationRepository>()
        .fetchNearbyDestinations(
          longitude: request.longitude,
          latitude: request.latitude,
          radius: request.radius,
        )
        .then(
          (destinations) =>
              GetNearbyDestinationResponse(destinations: destinations),
        );
  }
}

/// Request for the nearby destinations usecase
class GetNearbyDestinationRequest {
  /// Default constructor for the GetNearbyDestinationRequest.
  GetNearbyDestinationRequest({
    required this.longitude,
    required this.latitude,
    required this.radius,
  });

  /// Longitude of the location.
  final double longitude;

  /// Latitude of the location.
  final double latitude;

  /// Radius for the search.
  final int radius;
}

/// Response for the nearby destinations usecase
class GetNearbyDestinationResponse {
  /// Default constructor for the RecommendDestinationsResponse.
  GetNearbyDestinationResponse({required this.destinations});

  /// The list of nearby destinations.
  final List<Destination> destinations;
}
