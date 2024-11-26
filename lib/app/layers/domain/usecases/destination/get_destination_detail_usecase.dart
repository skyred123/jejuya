import 'package:jejuya/app/layers/data/sources/local/model/destination/destination_detail.dart';
import 'package:jejuya/app/layers/domain/repositories/destination/destination_repository.dart';
import 'package:jejuya/core/arch/domain/repository/repository_provider.dart';
import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';

class GetDestinationDetailUsecase extends BaseUseCase<
    GetDestinationDetailRequest,
    GetDestinationDetailResponse> with RepositoryProvider {
  /// Default constructor for the GetDestinationDetailUseCase
  GetDestinationDetailUsecase();

  @override
  Future<GetDestinationDetailResponse> execute(
      GetDestinationDetailRequest request) {
    return repository<DestinationRepository>()
        .fetchDestinationDetail(destinationId: request.id)
        .then((destinationDetail) =>
            GetDestinationDetailResponse(destinationDetail: destinationDetail));
  }
}

class GetDestinationDetailRequest {
  GetDestinationDetailRequest({required this.id});

  /// Id of the destination
  final String id;
}

class GetDestinationDetailResponse {
  /// Default constructor for the DestinationDetailResponse
  GetDestinationDetailResponse({required this.destinationDetail});

  /// Destination Detail Model
  final DestinationDetail destinationDetail;
}
