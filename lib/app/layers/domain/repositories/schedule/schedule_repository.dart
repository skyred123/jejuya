import 'package:jejuya/app/layers/data/sources/local/model/schedule/schedule.dart';
import 'package:jejuya/core/arch/domain/repository/base_repository.dart';

/// Repository for the schedule
abstract class ScheduleRepository extends BaseRepository {
  Future createSchedule({
    required String? name,
    required String? accommodation,
    required String? startDate,
    required String? endDate,
    required List<Schedule>? listDestination,
  });
}
