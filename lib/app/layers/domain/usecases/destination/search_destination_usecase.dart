import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';

import '../../../../../core/arch/domain/repository/repository_provider.dart';
import '../../../data/sources/local/model/destination/destination.dart';
import '../../repositories/destination/destination_repository.dart';

class SearchDestinationUsecase
    extends BaseUseCase<SearchDestinationRequest, SearchDestinationResponse>
    with RepositoryProvider {
  /// Default constructor for the SearchDestinationUsecase.
  SearchDestinationUsecase();

  @override
  Future<SearchDestinationResponse> execute(
      SearchDestinationRequest request) async {
    return repository<DestinationRepository>()
        .searchDestination(
          search: request.search,
        )
        .then(
          (destinations) =>
              SearchDestinationResponse(destinations: destinations),
        );
  }
}

/// Request for the search destination usecase
class SearchDestinationRequest {
  /// Default constructor for the SearchDestinationRequest.
  SearchDestinationRequest({
    required this.search,
  });

  /// Search keyword
  final String search;
}

/// Response for the search destination usecase
class SearchDestinationResponse {
  /// Default constructor for the SearchDestinationResponse.
  SearchDestinationResponse({required this.destinations});

  /// The list of search destinations.
  final List<Destination> destinations;
}
