import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/schedule/schedule.dart';
import 'package:jejuya/app/layers/data/sources/local/model/userDetail/userDetail.dart';
import 'package:jejuya/app/layers/domain/usecases/userdetail/fetch_user_detail_usecase_usecase.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule/enum/schedule_state.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Controller for the Schedule page
class ScheduleController extends BaseController with UseCaseProvider {
  /// Default constructor for the ScheduleController.
  ScheduleController() {
    notShow();
    fetchUserDetail();
  }

  // --- Member Variables ---

  /// Search Controller
  final TextEditingController searchController = TextEditingController();

  // --- Computed Variables ---
  // --- State Variables ---
  // --- State Computed ---
  final notShowAgain = listenableStatus<bool>(false);

  final userDetail = listenableStatus<UserDetail?>(null);
  // --- Usecases ---
  // --- Methods ---

  final fetchDetailState = listenable<ScheduleState>(ScheduleState.none);

  late final _fetchUserDetail = usecase<FetchUserDetailUsecaseUseCase>();

  Future<void> fetchUserDetail() async {
    try {
      fetchDetailState.value = ScheduleState.loading;

      await _fetchUserDetail
          .execute(FetchUserDetailUsecaseRequest())
          .then((response) => response.userDetail)
          .assignTo(userDetail);
      fetchDetailState.value = ScheduleState.done;
    } catch (e, s) {
      log.error(
        '[DestinationDetailController] Failed to fetch detail:',
        error: e,
        stackTrace: s,
      );
      nav.showSnackBar(error: e);
    }
  }

  Future<void> notShow() async {
    final prefs = await SharedPreferences.getInstance();
    final savedValue = prefs.getBool('notShowAgain') ?? false;
    notShowAgain.value = savedValue;
  }

  @override
  FutureOr<void> onDispose() async {}
}
