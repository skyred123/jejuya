import 'package:jejuya/app/layers/data/sources/local/model/schedule/schedule.dart';
import 'package:jejuya/app/layers/data/sources/local/model/schedule/schedule_item.dart';
import 'package:jejuya/app/layers/data/sources/network/app_api_service.dart';
import 'package:jejuya/app/layers/domain/repositories/schedule/schedule_repository.dart';
import 'package:jejuya/core/arch/data/network/api_service_provider.dart';
import 'package:jejuya/core/local_storage/local_storage_provider.dart';

/// Implementation of the [ScheduleRepository] interface.
class ScheduleRepositoryImpl extends ScheduleRepository
    with LocalStorageProvider, ApiServiceProvider {
  @override
  Future<void> createSchedule({
    required String? name,
    required String? accommodation,
    required String? startDate,
    required String? endDate,
    required List<ScheduleItem>? listDestination,
  }) async =>
      apiService<AppApiService>().createSchedule(
        name: name,
        accommodation: accommodation,
        startDate: startDate,
        endDate: endDate,
        listDestination: listDestination,
      );
}
