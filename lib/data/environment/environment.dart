import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String getKey() {
    String? key = dotenv.env["PRIVATE_KEY_ENCRYPT"];

    return key!;
  }

  static String getIV() {
    String? iv = dotenv.env["IV_ENCRYPT"];

    return iv!;
  }
}
