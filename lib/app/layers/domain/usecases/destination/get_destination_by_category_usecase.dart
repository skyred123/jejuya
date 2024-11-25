import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';

import '../../../../../core/arch/domain/repository/repository_provider.dart';
import '../../../data/sources/local/model/destination/destination.dart';
import '../../repositories/destination/destination_repository.dart';

class GetDestinationByCategoryUsecase extends BaseUseCase<
    GetDestinationByCategoryRequest,
    GetDestinationByCategoryResponse> with RepositoryProvider {
  /// Default constructor for the SearchDestinationUsecase.
  GetDestinationByCategoryUsecase();

  @override
  Future<GetDestinationByCategoryResponse> execute(
      GetDestinationByCategoryRequest request) async {
    return repository<DestinationRepository>()
        .fetchDestinationsByCategory(category: request.category)
        .then(
          (destinations) =>
              GetDestinationByCategoryResponse(destinations: destinations),
        );
  }
}

/// Request for the get destination usecase
class GetDestinationByCategoryRequest {
  /// Default constructor for the GetDestinationByCategoryRequest.
  GetDestinationByCategoryRequest({
    required this.category,
  });

  /// category keyword
  final String category;
}

/// Response for the search destination usecase
class GetDestinationByCategoryResponse {
  /// Default constructor for the SearchDestinationResponse.
  GetDestinationByCategoryResponse({required this.destinations});

  /// The list of search destinations.
  final List<Destination> destinations;
}
