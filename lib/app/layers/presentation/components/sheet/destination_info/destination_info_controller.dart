import 'dart:async';

import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destinationDetail/destinationDetail.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/destination_detail_usecase.dart';
import 'package:jejuya/app/layers/presentation/components/pages/schedule_detail/mockup/schedule.dart';
import 'package:jejuya/app/layers/presentation/components/sheet/destination_info/enum/destination_detail_state.dart';

import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';

/// Controller for the Destination info sheet
class DestinationInfoController extends BaseController with UseCaseProvider {
  /// Default constructor for the DestinationInfoController.

  DestinationInfoController({
    this.location,
    required this.destination,
  }) {
    fetchDestinationDetail();
  }

  // --- Member Variables ---
  final Destination? destination;
  final Location? location;
  // --- Computed Variables ---
  // --- State Variables ---

  final destinationDetail = listenableStatus<DestinationDetail?>(null);

  // --- State Computed ---
  // --- Usecases ---
  // --- Methods ---

  final fetchDetailState =
      listenable<DestinationDetailState>(DestinationDetailState.none);

  late final _fetchDestinationDetail = usecase<DestinationDetailUseCase>();

  Future<void> fetchDestinationDetail() async {
    try {
      fetchDetailState.value = DestinationDetailState.loading;

      if (destination?.id == null) return;
      await _fetchDestinationDetail
          .execute(
            DestinationDetailRequest(destinationId: destination?.id),
          )
          .then((response) => response.destinationDetail)
          .assignTo(destinationDetail);
      fetchDetailState.value = DestinationDetailState.done;
    } catch (e, s) {
      log.error(
        '[DestinationDetailController] Failed to fetch detail:',
        error: e,
        stackTrace: s,
      );
      nav.showSnackBar(error: e);
    }
  }

  @override
  FutureOr<void> onDispose() async {}
}
