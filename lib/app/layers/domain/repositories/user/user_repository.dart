import 'package:jejuya/app/layers/data/sources/local/model/user/user.dart';
import 'package:jejuya/core/arch/domain/repository/base_repository.dart';

/// Repository for the user
abstract class UserRepository extends BaseRepository {
  /// Login & get the user info
  Future<User> login();

  /// Logout the user
  Future<void> logout();
}
