import 'dart:async';

import 'package:get/get_connect/http/src/request/request.dart';
import 'package:jejuya/app/layers/data/sources/local/model/language/language_supported.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule_detail/mockup/schedule.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule_detail/mockup/schedule_mockup_api.dart';
import 'package:jejuya/app/layers/presentation/global_controllers/setting/setting_controller.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';

/// Controller for the Schedule detail page
class ScheduleDetailController extends BaseController
    with UseCaseProvider, GlobalControllerProvider {
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
    final settingCtrl = globalController<SettingController>();

    var parts = dateString.split('/');

    if (parts.length != 3) {
      throw const FormatException("Invalid date format");
    }

    String formattedDate = '${parts[2]}-${parts[1]}-${parts[0]}';
    DateTime dateTime = DateTime.parse(formattedDate);

    String dayOfWeek = _getWeekDayName(dateTime.weekday);
    String day = dateTime.day.toString();
    String monthAb = '';
    List<String> englishMonthAbbreviations = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    if (settingCtrl.language.value == LanguageSupported.korean) {
      monthAb = "${dateTime.month}월";
    }
    if (settingCtrl.language.value == LanguageSupported.vietnamese) {
      monthAb = "Th${dateTime.month}";
    }
    if (settingCtrl.language.value == LanguageSupported.english) {
      monthAb = englishMonthAbbreviations[dateTime.month - 1];
    }
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
    final settingCtrl = globalController<SettingController>();
    switch (weekday) {
      case 1:
        String day = '';
        if (settingCtrl.language.value == LanguageSupported.korean) {
          day = "월";
        }
        if (settingCtrl.language.value == LanguageSupported.vietnamese) {
          day = "T2";
        }
        if (settingCtrl.language.value == LanguageSupported.english) {
          day = "Mon";
        }
        return day;
      case 2:
        String day = '';
        if (settingCtrl.language.value == LanguageSupported.korean) {
          day = "화";
        }
        if (settingCtrl.language.value == LanguageSupported.vietnamese) {
          day = "T3";
        }
        if (settingCtrl.language.value == LanguageSupported.english) {
          day = "Tue";
        }
        return day;
      case 3:
        String day = '';
        if (settingCtrl.language.value == LanguageSupported.korean) {
          day = "수";
        }
        if (settingCtrl.language.value == LanguageSupported.vietnamese) {
          day = "T4";
        }
        if (settingCtrl.language.value == LanguageSupported.english) {
          day = "Wed";
        }
        return day;
      case 4:
        String day = '';
        if (settingCtrl.language.value == LanguageSupported.korean) {
          day = "목";
        }
        if (settingCtrl.language.value == LanguageSupported.vietnamese) {
          day = "T5";
        }
        if (settingCtrl.language.value == LanguageSupported.english) {
          day = "Thu";
        }
        return day;
      case 5:
        String day = '';
        if (settingCtrl.language.value == LanguageSupported.korean) {
          day = "금";
        }
        if (settingCtrl.language.value == LanguageSupported.vietnamese) {
          day = "T6";
        }
        if (settingCtrl.language.value == LanguageSupported.english) {
          day = "Fri";
        }
        return day;
      case 6:
        String day = '';
        if (settingCtrl.language.value == LanguageSupported.korean) {
          day = "토";
        }
        if (settingCtrl.language.value == LanguageSupported.vietnamese) {
          day = "T7";
        }
        if (settingCtrl.language.value == LanguageSupported.english) {
          day = "Sat";
        }
        return day;
      case 7:
        String day = '';
        if (settingCtrl.language.value == LanguageSupported.korean) {
          day = "일";
        }
        if (settingCtrl.language.value == LanguageSupported.vietnamese) {
          day = "CN";
        }
        if (settingCtrl.language.value == LanguageSupported.english) {
          day = "Sun";
        }
        return day;
      default:
        return '';
    }
  }

  @override
  FutureOr<void> onDispose() async {}
}
