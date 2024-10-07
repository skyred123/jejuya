import 'package:flutter_dotenv/flutter_dotenv.dart';

/// A class that contains the configuration for the application.
class AppConfig {
  AppConfig._();

  /// The API host URL.
  static final apiHost = dotenv.get('API_HOST');
}
