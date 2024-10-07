import 'package:jejuya/app/layers/data/sources/local/model/user/user.dart';
import 'package:jejuya/app/layers/domain/repositories/user/user_repository.dart';
import 'package:jejuya/core/arch/domain/repository/repository_provider.dart';
import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';

/// Login usecase
class LoginUseCase extends BaseUseCase<LoginRequest, LoginResponse>
    with RepositoryProvider {
  /// Default constructor for the LoginUseCase.
  LoginUseCase();

  @override
  Future<LoginResponse> execute(LoginRequest request) async =>
      repository<UserRepository>().login().then(
            LoginResponse.new,
          );
}

/// Request for the Login usecase
class LoginRequest {
  /// Default constructor for the LoginRequest.
  LoginRequest();
}

/// Response for the Login usecase
class LoginResponse {
  /// Default constructor for the LoginResponse.
  LoginResponse(
    this.user,
  );

  /// The authenticated user
  User user;
}
