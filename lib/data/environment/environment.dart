import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String getApiBaseUrl() {
    String? url = dotenv.env['PRODUCTION_URL'];
    if (dotenv.env['APP_ENV'] == 'dev') {
      url = dotenv.env['DEV_URL'];
    }
    if (dotenv.env['APP_ENV'] == 'staging') {
      url = dotenv.env['STAGING_URL'];
    }
    if (dotenv.env['APP_ENV'] == 'prod') {
      url = dotenv.env['PRODUCTION_URL'];
    }
    return url!;
  }

  static String getWSBaseUrl() {
    String? url = dotenv.env['WS_PRODUCTION_URL'];
    if (dotenv.env['APP_ENV'] == 'dev') {
      url = dotenv.env['WS_DEV_URL'];
    }
    if (dotenv.env['APP_ENV'] == 'staging') {
      url = dotenv.env['WS_STAGING_URL'];
    }
    if (dotenv.env['APP_ENV'] == 'prod') {
      url = dotenv.env['WS_PRODUCTION_URL'];
    }
    return url!;
  }

  static String? getApiAppVersion() {
    return dotenv.env['APP_VERSION'];
  }
}
