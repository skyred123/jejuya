import 'dart:async';

import 'package:jejuya/app/layers/data/sources/local/model/destination/destination_detail.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';

/// Controller for the Destination detail page
class DestinationDetailController extends BaseController with UseCaseProvider {
  /// Default constructor for the DestinationDetailController.
  DestinationDetailController({required this.destinationDetail});

  // --- Member Variables ---
  final DestinationDetail? destinationDetail;
  // --- Computed Variables ---
  // --- State Variables ---
  // --- State Computed ---
  // --- Usecases ---
  // --- Methods ---

  @override
  FutureOr<void> onDispose() async {}
}
