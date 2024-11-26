import 'package:jejuya/app/layers/data/sources/local/model/hotel/hotel.dart';
import 'package:jejuya/app/layers/domain/repositories/destination/destination_repository.dart';
import 'package:jejuya/core/arch/domain/repository/repository_provider.dart';
import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';

class GetHotelUsecase extends BaseUseCase<GetHotelRequest, GetHotelResponse>
    with RepositoryProvider {
  /// Default constructor for the GetHotelUsecase.
  GetHotelUsecase();

  @override
  Future<GetHotelResponse> execute(GetHotelRequest request) async {
    return repository<DestinationRepository>().fetchHotels().then(
          (hotels) => GetHotelResponse(hotels: hotels),
        );
  }
}

class GetHotelRequest {
  GetHotelRequest();
}

class GetHotelResponse {
  GetHotelResponse({required this.hotels});
  final List<Hotel> hotels;
}
