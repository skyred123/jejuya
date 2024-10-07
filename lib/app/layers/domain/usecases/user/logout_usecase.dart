import 'package:jejuya/app/layers/domain/repositories/user/user_repository.dart';
import 'package:jejuya/core/arch/domain/repository/repository_provider.dart';
import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';

/// Logout usecase
class LogoutUseCase extends BaseUseCase<LogoutRequest, LogoutResponse>
    with RepositoryProvider {
  /// Default constructor for the LogoutUseCase.
  LogoutUseCase();

  @override
  Future<LogoutResponse> execute(LogoutRequest request) async {
    return repository<UserRepository>().logout().then((_) => LogoutResponse());
  }
}

/// Request for the Logout usecase
class LogoutRequest {
  /// Default constructor for the LogoutRequest.
  LogoutRequest();
}

/// Response for the Logout usecase
class LogoutResponse {
  /// Default constructor for the LogoutResponse.
  LogoutResponse();
}
