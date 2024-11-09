import 'dart:async';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule_detail/mockup/schedule.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule_detail/mockup/schedule_mockup_api.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';

/// Controller for the Create schedule page
class CreateScheduleController extends BaseController with UseCaseProvider {
  /// Default constructor for the CreateScheduleController.
  CreateScheduleController() {
    schedules = Schedule.fromJsonList(scheduleMockup);
  }

  // --- Member Variables ---
  late List<Schedule> schedules;

  /// Name Controller
  final TextEditingController nameController = TextEditingController();

  /// Location Controller
  final TextEditingController locationController = TextEditingController();

  /// Date Controller
  final TextEditingController dateController = TextEditingController();

  /// Time Start Controller
  final TextEditingController timeStartController = TextEditingController();

  /// Time End Controller
  final TextEditingController timeEndController = TextEditingController();
  // --- Computed Variables ---
  // --- State Variables ---

  final selectedDayIndex = listenable<int>(0);
  final selectedHour = listenable<int>(0);
  final selectedMinute = listenable<int>(0);
  // --- State Computed ---
  // --- Usecases ---
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

  void deleteLocation(int index) {
    schedules[selectedDayIndex.value].locations.removeAt(index);
  }

  void selectDates(BuildContext context) {
    showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.range,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        selectedDayHighlightColor: context.color.primaryColor,
        selectedRangeHighlightColor: context.color.primaryLight,
      ),
      dialogSize: const Size(325, 400),
    ).then((results) {
      if (results != null && results.length == 2) {
        _updateDates(results);
      }
    });
  }

  void selectTime(BuildContext context, bool isStart) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.color.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    ).then((selectedTime) {
      if (selectedTime != null) {
        String formattedTime =
            "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
        if (isStart) {
          timeStartController.text = formattedTime;
        } else {
          timeEndController.text = formattedTime;
        }
      }
    });
  }

  void _updateDates(List<DateTime?> results) {
    final startDate = results[0];
    final endDate = results[1];
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    final formattedRange =
        '${startDate != null ? dateFormat.format(startDate) : ''} - ${endDate != null ? dateFormat.format(endDate) : ''}';
    dateController.text = formattedRange;
  }

  @override
  FutureOr<void> onDispose() async {}
}
