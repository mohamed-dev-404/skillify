import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();

  //? Base URL
  static const String baseUrl = 'https://skillifyapi.tryasp.net/api';

  //? Zego App ID and Sign
  static final int zegoAppID = int.parse(dotenv.env[EnvKeys.zegoAppIDKey]!);
  static final String zegoAppSign = dotenv.env[EnvKeys.zegoAppSignKey]!;
}

/// Environment variable keys
class EnvKeys {
  EnvKeys._();

  static const String zegoAppIDKey = 'ZEGO_APP_ID';
  static const String zegoAppSignKey = 'ZEGO_APP_SIGN';
}
