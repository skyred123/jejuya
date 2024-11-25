import 'package:jejuya/app/layers/data/sources/local/model/schedule/schedule_item.dart';
import 'package:jejuya/app/layers/domain/repositories/schedule/schedule_repository.dart';
import 'package:jejuya/core/arch/domain/repository/repository_provider.dart';
import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';

/// Create schedule usecase
class CreateScheduleUseCase
    extends BaseUseCase<CreateScheduleRequest, CreateScheduleResponse>
    with RepositoryProvider {
  /// Default constructor for the CreateScheduleUseCase.
  CreateScheduleUseCase();

  @override
  Future<CreateScheduleResponse> execute(CreateScheduleRequest request) async {
    return repository<ScheduleRepository>()
        .createSchedule(
          name: request.name,
          accommodation: request.accommodation,
          startDate: request.startDate,
          endDate: request.endDate,
          listDestination: request.listDestination,
        )
        .then(
          (destinations) => CreateScheduleResponse(),
        );
  }
}

/// Request for the Create schedule usecase
class CreateScheduleRequest {
  /// Default constructor for the CreateScheduleRequest.
  CreateScheduleRequest({
    required this.name,
    required this.accommodation,
    required this.startDate,
    required this.endDate,
    required this.listDestination,
  });

  final String? name;
  final String? accommodation;
  final String? startDate;
  final String? endDate;
  final List<ScheduleItem>? listDestination;
}

/// Response for the Create schedule usecase
class CreateScheduleResponse {
  /// Default constructor for the CreateScheduleResponse.
  CreateScheduleResponse();
}
