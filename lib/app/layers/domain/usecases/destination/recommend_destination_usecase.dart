import 'package:jejuya/app/layers/domain/repositories/destination/destination_repository.dart';
import 'package:jejuya/core/arch/domain/repository/repository_provider.dart';
import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';

import '../../../data/sources/local/model/destination/destination.dart';

/// Recommend destinations usecase
class RecommendDestinationsUseCase extends BaseUseCase<
    RecommendDestinationsRequest,
    RecommendDestinationsResponse> with RepositoryProvider {
  /// Default constructor for the RecommendDestinationsUseCase.
  RecommendDestinationsUseCase();

  @override
  Future<RecommendDestinationsResponse> execute(
      RecommendDestinationsRequest request) async {
    return repository<DestinationRepository>()
        .recommendDestinations(
          longitude: request.longitude,
          latitude: request.latitude,
          radius: request.radius,
          fromDate: request.fromDate,
          toDate: request.toDate,
        )
        .then(
          (destinations) =>
              RecommendDestinationsResponse(destinations: destinations),
        );
  }
}

/// Request for the Recommend destinations usecase
class RecommendDestinationsRequest {
  /// Default constructor for the RecommendDestinationsRequest.
  RecommendDestinationsRequest({
    required this.longitude,
    required this.latitude,
    required this.radius,
    required this.fromDate,
    required this.toDate,
  });

  /// Longitude of the location.
  final double longitude;

  /// Latitude of the location.
  final double latitude;

  /// Radius for the search.
  final int radius;

  /// Start date for recommendations.
  final String fromDate;

  /// End date for recommendations.
  final String toDate;
}

/// Response for the Recommend destinations usecase
class RecommendDestinationsResponse {
  /// Default constructor for the RecommendDestinationsResponse.
  RecommendDestinationsResponse({required this.destinations});

  /// The list of recommended destinations.
  final List<Destination> destinations;
}
