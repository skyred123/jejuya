import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination_detail.dart';
// import 'package:jejuya/app/layers/data/sources/local/model/destinationDetail/destinationDetail.dart';
import 'package:jejuya/app/layers/domain/repositories/destination/destination_repository.dart';
import 'package:jejuya/core/arch/domain/repository/repository_provider.dart';
import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';

/// Destination detail usecase
class DestinationDetailUseCase
    extends BaseUseCase<DestinationDetailRequest, DestinationDetailResponse>
    with RepositoryProvider {
  /// Default constructor for the DestinationDetailUseCase.
  DestinationDetailUseCase();

  @override
  Future<DestinationDetailResponse> execute(
      DestinationDetailRequest request) async {
    final destination = await repository<DestinationRepository>()
        .fetchDestinationDetail(destinationId: request.destinationId);
    return DestinationDetailResponse(destinationDetail: destination);
  }
}

/// Request for the Destination detail usecase
class DestinationDetailRequest {
  /// Default constructor for the DestinationDetailRequest.
  final String? destinationId;
  DestinationDetailRequest({required this.destinationId});
}

/// Response for the Destination detail usecase
class DestinationDetailResponse {
  /// Default constructor for the DestinationDetailResponse.

  final DestinationDetail destinationDetail;
  DestinationDetailResponse({required this.destinationDetail});
}
