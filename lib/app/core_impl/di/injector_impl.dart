import 'package:jejuya/app/core_impl/di/injector_config.dart';
import 'package:jejuya/app/core_impl/local_storage/hive_local_storage_impl.dart';
import 'package:jejuya/app/core_impl/logger/logger_impl.dart';
import 'package:jejuya/app/core_impl/navigation/getx_navigator_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/language/language_supported.dart';
import 'package:jejuya/app/layers/data/sources/local/model/theme/theme_supported.dart';
import 'package:jejuya/app/layers/data/sources/local/model/user/user.dart';
import 'package:jejuya/core/analytic/analytic_service.dart';
import 'package:jejuya/core/arch/data/network/base_api_service.dart';
import 'package:jejuya/core/arch/domain/repository/base_repository.dart';
import 'package:jejuya/core/arch/domain/usecase/base_usecase.dart';
import 'package:jejuya/core/arch/presentation/controller/base_controller.dart';
import 'package:jejuya/core/di/injector.dart';
import 'package:jejuya/core/local_storage/local_storage.dart';
import 'package:jejuya/core/logger/app_logger.dart';
import 'package:jejuya/core/navigation/navigator.dart';
import 'package:jejuya/core/reactive/obs_setting.dart';
import 'package:easy_localization/easy_localization.dart';
// ignore: depend_on_referenced_packages
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Shortcut for dependency injection manager.
final inj = InjectorImpl();

/// Shortcut for logger manager.
AppLogger get log => Logger();

/// Shortcut for navigator manager.
Navigator get nav => inj.navigator;

/// Shortcut for analytics manager.
AnalyticService get ana => inj.analytics;

/// Implementation of the [Injector].
class InjectorImpl extends Injector {
  @override
  Future<void> initialize() async {
    /// App env & util initialization
    await _injectLocalizations();
    await _injectEnv();

    /// Inject data layer
    await _injectLocalStorage();
    await _injectApiServices();

    /// Inject domain layer
    await _injectRepositories();
    await _injectUseCases();

    /// Inject presentation layer
    await _injectGlobalStates();

    /// Navigation initialization
    await _injectNavigator();
  }

  @override
  Future<void> reset() async {
    await _injectGlobalStates();
  }

  /// Inject localizations
  Future<void> _injectLocalizations() async {
    EasyLocalization.logger.printer = (
      Object object, {
      String? name,
      LevelMessages? level,
      StackTrace? stackTrace,
    }) =>
        log.info('$name: $object');
    await EasyLocalization.ensureInitialized();
  }

  /// Injects environment variables
  Future<void> _injectEnv() async {
    await dotenv.load();
  }

  /// Injects local storage
  Future<void> _injectLocalStorage() async {
    // Initialize hive storage, an implementation of LocalStogare
    await Hive.initFlutter();

    // Open boxes
    await Hive.openBox<dynamic>(StorageBox.defaultX.name);
    await Hive.openBox<dynamic>(StorageBox.setting.name);

    // Register setting converters
    registerSettingConverter(
      const LanguageSupportedConverter(),
    );
    registerSettingConverter(
      const ThemeSupportedConverter(),
    );
    registerSettingConverter(
      const UserSupportedConverter(),
    );

    // Inject an implementation of LocalStogare
    await registerSingleton<LocalStorage>(HiveLocalStorage());
    await get<LocalStorage>().migrate();
  }

  /// Inject API Service
  Future<void> _injectApiServices() async {
    for (final item in InjectorConfig.apiServiceFactories.entries) {
      await registerLazySingleton<BaseApiService>(
        item.value,
        instanceName: item.key.toString(),
      );
    }
  }

  /// Inject repositories
  Future<void> _injectRepositories() async {
    for (final item in InjectorConfig.repositoryFactories.entries) {
      await registerFactory<BaseRepository>(
        item.value,
        instanceName: item.key.toString(),
      );
    }
  }

  /// Inject use cases
  Future<void> _injectUseCases() async {
    for (final item in InjectorConfig.useCaseFactories.entries) {
      await registerFactory<BaseUseCase<dynamic, dynamic>>(
        item.value,
        instanceName: item.key.toString(),
      );
    }
  }

  /// Inject global states
  Future<void> _injectGlobalStates() async {
    for (final item in InjectorConfig.globalControllerFactories.entries) {
      await registerLazySingleton<BaseController>(
        item.value.factory,
        instanceName: item.key.toString(),
        resetable: item.value.resetable,
      );
    }
  }

  /// Injects navigator
  Future<void> _injectNavigator() async {
    // Inject an implementation of Navigator
    await registerSingleton<Navigator>(GetxNavigator());
  }
}
