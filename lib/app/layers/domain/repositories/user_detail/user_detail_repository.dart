import 'package:jejuya/app/layers/data/sources/local/model/userDetail/userDetail.dart';
import 'package:jejuya/core/arch/domain/repository/base_repository.dart';

abstract class UserDetailRepository extends BaseRepository {
  Future<UserDetail> fetchUserDetail(
    String? cursor,
  );
}
