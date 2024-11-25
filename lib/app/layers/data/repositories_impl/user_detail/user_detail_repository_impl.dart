import 'package:jejuya/app/layers/data/sources/local/model/userDetail/userDetail.dart';
import 'package:jejuya/app/layers/data/sources/network/app_api_service.dart';
import 'package:jejuya/app/layers/domain/repositories/user_detail/user_detail_repository.dart';
import 'package:jejuya/core/arch/data/network/api_service_provider.dart';
import 'package:jejuya/core/local_storage/local_storage_provider.dart';

class UserDetailRepositoryImpl extends UserDetailRepository
    with LocalStorageProvider, ApiServiceProvider {
  @override
  Future<UserDetail> fetchUserDetail(String? cursor) {
    return apiService<AppApiService>().fetchUserDetail();
  }
}
