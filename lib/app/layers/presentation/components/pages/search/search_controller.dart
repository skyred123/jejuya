import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination.dart';
import 'package:jejuya/app/layers/data/sources/local/model/destination/destination_detail.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/get_destination_detail_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/search_destination_usecase.dart';
import 'package:jejuya/core/arch/domain/usecase/usecase_provider.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/reactive/dynamic_to_obs_data.dart';

/// Controller for the Search page
class SearchController extends BaseController with UseCaseProvider {
  /// Default constructor for the SearchController.
  SearchController();

  // --- Member Variables ---
  final TextEditingController searchController = TextEditingController();
  late final _searchDestinationUsecase = usecase<SearchDestinationUsecase>();
  // --- Computed Variables ---
  Timer? _debounce;
  // --- State Variables ---
  /// Search results
  final searchResults = listenable<List<Destination>>([]);
  // --- State Computed ---
  // --- Usecases ---
  // --- Methods ---
  void onSearchTextChanged(String query) {
    // Cancel the previous debounce timer
    _debounce?.cancel();

    // Start a new debounce timer
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      if (query.isEmpty) {
        searchResults.value = [];
        return;
      }

      try {
        final response = await _searchDestinationUsecase.execute(
          SearchDestinationRequest(search: query),
        );
        searchResults.value = response.destinations;
      } catch (e, s) {
        log.error('[MapController] Error fetching search results',
            error: e, stackTrace: s);
      }
    });
  }

  Future<DestinationDetail> fetchDestinationDetail(String id) async {
    try {
      final response = await GetDestinationDetailUsecase().execute(
        GetDestinationDetailRequest(id: id),
      );

      return response.destinationDetail;
    } catch (e, s) {
      log.error('Error fetching destination details', error: e, stackTrace: s);
      rethrow;
    }
  }

  @override
  FutureOr<void> onDispose() async {
    _debounce?.cancel();
  }
}
