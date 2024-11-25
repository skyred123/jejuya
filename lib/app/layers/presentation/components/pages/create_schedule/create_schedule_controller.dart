import 'dart:async';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jejuya/app/common/utils/extension/build_context/app_color.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
import 'package:jejuya/app/layers/data/sources/local/model/schedule/schedule_item.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/recommend_destination_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/schedule/create_schedule_usecase.dart';
import 'package:jejuya/app/layers/presentation/components/pages/create_schedule/enum/create_schedule_state.dart';
import 'package:jejuya/app/layers/presentation/components/pages/create_schedule/enum/recommend_destination_state.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';

/// Controller for the Create schedule page
class CreateScheduleController extends BaseController with UseCaseProvider {
  /// Default constructor for the CreateScheduleController.
  CreateScheduleController() {
    // schedules = Schedule.fromJsonList(scheduleMockup);
    // fetchRecommendedDestinations();
  }

  // --- Member Variables ---
  // late List<Schedule> schedules;

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

  static const LatLng jejuIsland = LatLng(33.363646, 126.545454);

  String startDate = '';
  String endDate = '';
  // --- Computed Variables ---
  // --- State Variables ---

  final selectedDayIndex = listenable<int>(0);
  final selectedHour = listenable<int>(0);
  final selectedMinute = listenable<int>(0);

  final destinations = listenable<List<Destination>>([]);

  final fetchState =
      listenable<RecommendDestinationState>(RecommendDestinationState.none);
  final createState = listenable<CreateScheduleState>(CreateScheduleState.none);

  // --- Usecases ---
  late final _recommendDestinationsUseCase =
      usecase<RecommendDestinationsUseCase>();
  late final _createScheduleUseCase = usecase<CreateScheduleUseCase>();

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
    destinations.value.removeAt(index);
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
    this.startDate = startDate.toString();
    this.endDate = endDate.toString();
  }

  Future<void> fetchRecommendedDestinations() async {
    try {
      fetchState.value = RecommendDestinationState.loading;
      await _recommendDestinationsUseCase
          .execute(
        RecommendDestinationsRequest(
          longitude: jejuIsland.longitude,
          latitude: jejuIsland.latitude,
          radius: 20,
          fromDate: startDate,
          toDate: endDate,
        ),
      )
          .then((response) {
        destinations.value = response.destinations;
      });
      fetchState.value = RecommendDestinationState.done;
    } catch (e, s) {
      log.error(
        '[RecommendDestinationsController] Failed to fetch recommended destinations:',
        error: e,
        stackTrace: s,
      );
      fetchState.value = RecommendDestinationState.error;
      nav.showSnackBar(error: e);
    }
  }

  Future<void> createSchedule() async {
    try {
      createState.value = CreateScheduleState.loading;
      final adjustedStartDate =
          destinations.value[1].startTime?.subtract(Duration(hours: 4));
      final adjustedEndDate =
          destinations.value.last.endTime?.add(Duration(hours: 4));
      await _createScheduleUseCase
          .execute(
            CreateScheduleRequest(
              name: nameController.value.text,
              accommodation: '1',
              startDate: adjustedStartDate.toString(),
              endDate: adjustedEndDate.toString(),
              listDestination: convertScheduleItem(),
            ),
          )
          .then((response) {});
      createState.value = CreateScheduleState.done;
      nav.toHome();
    } catch (e, s) {
      log.error(
        '[RecommendDestinationsController] Failed to create schedule:',
        error: e,
        stackTrace: s,
      );
      createState.value = CreateScheduleState.error;
      nav.showSnackBar(error: e);
    }
  }

  List<ScheduleItem> convertScheduleItem() {
    List<ScheduleItem> list = [];
    for (Destination i in destinations.value) {
      ScheduleItem scheduleItem =
          ScheduleItem(id: i.id, startTime: i.startTime, endTime: i.endTime);
      list.add(scheduleItem);
    }
    return list;
  }

  List<Map<String, dynamic>> groupDestinationsByDate(
      List<Destination> destinations) {
    final Map<String, List<Destination>> groupedByDate = {};

    for (var destination in destinations) {
      final DateTime? date = destination.startTime?.toLocal();

      if (date != null) {
        final String formattedDate = DateFormat('dd/MM/yyyy').format(date);

        if (groupedByDate.containsKey(formattedDate)) {
          groupedByDate[formattedDate]!.add(destination);
        } else {
          groupedByDate[formattedDate] = [destination];
        }
      }
    }

    final List<Map<String, dynamic>> result =
        groupedByDate.entries.map((entry) {
      return {
        'date': entry.key,
        'destinations': entry.value,
      };
    }).toList();

    return result;
  }

  List<String> extractDates(List<Map<String, dynamic>> groupedData) {
    return groupedData.map((entry) => entry['date'] as String).toList();
  }

  List<Destination> extractDestinations(int index) {
    final groupedData = groupDestinationsByDate(destinations.value);
    if (index < 0 || index >= groupedData.length) {
      return [];
    }
    return groupDestinationsByDate(destinations.value)[index]['destinations'];
  }

  @override
  FutureOr<void> onDispose() async {}
}
