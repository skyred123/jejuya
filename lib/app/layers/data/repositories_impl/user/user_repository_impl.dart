import 'package:jejuya/app/layers/data/sources/local/ls_key_predefined.dart';
import 'package:jejuya/app/layers/data/sources/local/model/user/user.dart';
import 'package:jejuya/app/layers/data/sources/network/app_api_service.dart';
import 'package:jejuya/app/layers/domain/repositories/user/user_repository.dart';
import 'package:jejuya/core/arch/data/network/api_service_provider.dart';
import 'package:jejuya/core/local_storage/local_storage_provider.dart';

/// Implementation of the [UserRepository] interface.
class UserRepositoryImpl extends UserRepository
    with LocalStorageProvider, ApiServiceProvider {
  @override
  Future<User> login() => apiService<AppApiService>().login();

  @override
  Future<void> logout() async {
    await localStorage.delete(LSKeyPredefinedExt.user);
  }
}
