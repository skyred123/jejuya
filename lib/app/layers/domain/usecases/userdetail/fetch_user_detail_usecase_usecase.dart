import 'package:jejuya/app/layers/data/sources/local/model/userDetail/userDetail.dart';
import 'package:jejuya/app/layers/domain/repositories/user_detail/user_detail_repository.dart';
import 'package:jejuya/core/arch/domain/repository/repository_provider.dart';
import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';

/// Fetch user detail usecase usecase
class FetchUserDetailUsecaseUseCase extends BaseUseCase<
    FetchUserDetailUsecaseRequest,
    FetchUserDetailUsecaseResponse> with RepositoryProvider {
  /// Default constructor for the FetchUserDetailUsecaseUseCase.
  FetchUserDetailUsecaseUseCase();

  @override
  Future<FetchUserDetailUsecaseResponse> execute(
      FetchUserDetailUsecaseRequest request) async {
    return repository<UserDetailRepository>()
        .fetchUserDetail("")
        .then((userDetail) => FetchUserDetailUsecaseResponse(userDetail));
  }
}

/// Request for the Fetch user detail usecase usecase
class FetchUserDetailUsecaseRequest {
  /// Default constructor for the FetchUserDetailUsecaseRequest.
  FetchUserDetailUsecaseRequest();
}

/// Response for the Fetch user detail usecase usecase
class FetchUserDetailUsecaseResponse {
  /// Default constructor for the FetchUserDetailUsecaseResponse.
  FetchUserDetailUsecaseResponse(this.userDetail);

  final UserDetail userDetail;
}
