import 'package:jejuya/app/layers/data/repositories_impl/destination/destination_repository_impl.dart';
import 'package:jejuya/app/layers/data/repositories_impl/notification/notification_repository_impl.dart';
import 'package:jejuya/app/layers/data/repositories_impl/notification_detail/notification_detail_repository_impl.dart';
import 'package:jejuya/app/layers/data/repositories_impl/schedule/schedule_repository_impl.dart';
import 'package:jejuya/app/layers/data/repositories_impl/user/user_repository_impl.dart';
import 'package:jejuya/app/layers/data/repositories_impl/user_detail/user_detail_repository_impl.dart';
import 'package:jejuya/app/layers/data/sources/network/app_api_service.dart';
import 'package:jejuya/app/layers/domain/repositories/destination/destination_repository.dart';
import 'package:jejuya/app/layers/domain/repositories/notification/notification_repository.dart';
import 'package:jejuya/app/layers/domain/repositories/notification_detail/notification_detail_repository.dart';
import 'package:jejuya/app/layers/domain/repositories/schedule/schedule_repository.dart';
import 'package:jejuya/app/layers/domain/repositories/user/user_repository.dart';
import 'package:jejuya/app/layers/domain/repositories/user_detail/user_detail_repository.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/destination_detail_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/get_destination_by_category_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/get_destination_detail_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/get_hotel_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/recommend_destination_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/destination/search_destination_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/notification/fetch_notifications_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/notification/remove_notification_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/notification_detail/notification_detail_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/schedule/create_schedule_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/user/login_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/user/logout_usecase.dart';
import 'package:jejuya/app/layers/domain/usecases/userdetail/fetch_user_detail_usecase_usecase.dart';
import 'package:jejuya/app/layers/presentation/components/pages/home/home_controller.dart';
import 'package:jejuya/app/layers/presentation/global_controllers/app/app_controller.dart';
import 'package:jejuya/app/layers/presentation/global_controllers/loading_overlay/loading_overlay_controller.dart';
import 'package:jejuya/app/layers/presentation/global_controllers/setting/setting_controller.dart';
import 'package:jejuya/core/arch/data/network/base_api_service.dart';
import 'package:jejuya/core/arch/domain/repository/base_repository.dart';
import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import '../../layers/domain/usecases/destination/get_nearby_destination_usecase.dart';

/// Configuration for the dependency injection.
class InjectorConfig {
  /// Decalre all the api services here for the dependency injection.
  static const Map<Type, BaseApiService Function()> apiServiceFactories = {
    AppApiService: AppApiServiceImpl.new,
  };

  /// Decalre all the repositories here for the dependency injection.
  static const Map<Type, BaseRepository Function()> repositoryFactories = {
    UserRepository: UserRepositoryImpl.new,
    NotificationRepository: NotificationRepositoryImpl.new,
    NotificationDetailRepository: NotificationDetailRepositoryImpl.new,
    DestinationRepository: DestinationRepositoryImpl.new,
    ScheduleRepository: ScheduleRepositoryImpl.new,
    UserDetailRepository: UserDetailRepositoryImpl.new
  };

  /// Declare all the global controllers here for the dependency injection.
  /// { factory: resetable }
  /// resetable: true - the controller will be reinitialized when logout
  static const Map<Type, ({BaseController Function() factory, bool resetable})>
      globalControllerFactories = {
    AppController: (
      factory: AppController.new,
      resetable: true,
    ),
    LoadingOverlayController: (
      factory: LoadingOverlayController.new,
      resetable: true,
    ),
    SettingController: (
      factory: SettingController.new,
      resetable: true,
    ),
    HomeController: (
      factory: HomeController.new,
      resetable: true,
    ),
  };

  /// Decalre all the use cases here for the dependency injection.
  static const Map<Type, BaseUseCase<dynamic, dynamic> Function()>
      useCaseFactories = {
    LoginUseCase: LoginUseCase.new,
    LogoutUseCase: LogoutUseCase.new,
    FetchNotificationsUseCase: FetchNotificationsUseCase.new,
    RemoveNotificationUseCase: RemoveNotificationUseCase.new,
    NotificationDetailUseCase: NotificationDetailUseCase.new,
    RecommendDestinationsUseCase: RecommendDestinationsUseCase.new,
    DestinationDetailUseCase: DestinationDetailUseCase.new,
    CreateScheduleUseCase: CreateScheduleUseCase.new,
    FetchUserDetailUsecaseUseCase: FetchUserDetailUsecaseUseCase.new,
    GetNearbyDestinationUsecase: GetNearbyDestinationUsecase.new,
    GetDestinationDetailUsecase: GetDestinationDetailUsecase.new,
    SearchDestinationUsecase: SearchDestinationUsecase.new,
    GetDestinationByCategoryUsecase: GetDestinationByCategoryUsecase.new,
    GetHotelUsecase: GetHotelUsecase.new,
  };
}
