import 'package:jejuya/app/core_impl/di/injector_impl.dart';
import 'package:jejuya/app/layers/data/sources/local/model/language/language_supported.dart';
import 'package:jejuya/app/layers/presentation/components/widgets/loading/loading_overlay.dart';
import 'package:jejuya/app/layers/presentation/global_controllers/app/app_controller.dart';
import 'package:jejuya/app/layers/presentation/global_controllers/loading_overlay/loading_overlay_controller.dart';
import 'package:jejuya/app/layers/presentation/global_controllers/setting/setting_controller.dart';
import 'package:jejuya/app/layers/presentation/nav_predefined.dart';
import 'package:jejuya/core/arch/presentation/controller/controller_provider.dart';
// import 'package:jejuya/flavors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

/// The root widget of the application.
class App extends StatelessWidget with GlobalControllerProvider {
  /// Default constructor.
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    NavigatorObserver? navigatorObserver;

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      enableScaleWH: () => false,
      enableScaleText: () => false,
      minTextAdapt: true,
      child: EasyLocalization(
        saveLocale: false,
        supportedLocales:
            LanguageSupported.values.map((e) => e.locale).nonNulls.toList(),
        path: 'assets/translations',
        fallbackLocale: LanguageSupported.english.locale,
        child: Observer(
          builder: (context) {
            final theme = globalController<SettingController>().theme.value;
            final locale =
                globalController<SettingController>().language.value.locale;
            if (locale != null) {
              context.setLocale(locale);
            }

            return GetMaterialApp(
              title: "Jejuya",
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                ...context.localizationDelegates,
              ],
              initialRoute: globalController<AppController>().initialRoute,
              getPages: PredefinedPage.allPages,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: theme.themeData,
              themeMode: theme.themeMode,
              navigatorObservers: [navigatorObserver].nonNulls.toList(),
              onGenerateTitle: (context) => "Jejuya",
              logWriterCallback: (text, {bool isError = false}) =>
                  isError ? log.error(text) : log.verbose(text),
              builder: (context, child) {
                return Stack(
                  children: [
                    if (child != null) child,
                    _loadingOverlay,
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget get _loadingOverlay => Observer(
        builder: (context) {
          final loading =
              globalController<LoadingOverlayController>().loading.value;
          if (loading == null) return const SizedBox.shrink();
          return IgnorePointer(
            key: ValueKey(loading),
            ignoring: !loading,
            child: LoadingOverlay(
              loading: loading,
            ),
          );
        },
      );
}
