import 'dart:async';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule_detail/mockup/schedule.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule_detail/mockup/schedule_mockup_api.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';

/// Controller for the Schedule detail page
class ScheduleDetailController extends BaseController with UseCaseProvider {
  /// Default constructor for the ScheduleDetailController.
  ScheduleDetailController({required this.scheduleId}) {
    schedules = Schedule.fromJsonList(scheduleMockup);
  }

  // --- Member Variables ---
  late List<Schedule> schedules;
  final String? scheduleId;
  // --- State Variables ---
  final selectedDayIndex = listenable<int>(0);

  final selectedDestinationIndex = listenable<int>(0);

  // --- State Computed ---
  // --- Usecases ---
  // --- Computed Variables ---

  // --- Methods ---

  void updateSelectedDay(int index) {
    selectedDayIndex.value = index;
  }

  Map<String, String> formatDate(String dateString) {
    var parts = dateString.split('/');

    if (parts.length != 3) {
      throw const FormatException("Invalid date format");
    }

    String formattedDate = '${parts[2]}-${parts[1]}-${parts[0]}';
    DateTime dateTime = DateTime.parse(formattedDate);

    String dayOfWeek = _getWeekDayName(dateTime.weekday);
    String day = dateTime.day.toString();
    String monthAb = 'Th${dateTime.month}';
    String month = dateTime.month.toString();
    String year = dateTime.year.toString();

    return {
      'dayOfWeek': dayOfWeek,
      'day': day,
      'monthAb': monthAb,
      'month': month,
      'year': year,
    };
  }

  String _getWeekDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'T2';
      case 2:
        return 'T3';
      case 3:
        return 'T4';
      case 4:
        return 'T5';
      case 5:
        return 'T6';
      case 6:
        return 'T7';
      case 7:
        return 'CN';
      default:
        return '';
    }
  }

  @override
  FutureOr<void> onDispose() async {}
}
