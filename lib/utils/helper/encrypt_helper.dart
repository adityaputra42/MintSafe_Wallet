import 'package:encrypt/encrypt.dart' as en;

final key = en.Key.fromUtf8('12678675490987575346789788765328');
// final key = en.Key.fromSecureRandom(32);
final iv = en.IV.fromUtf8("e16ce888a20dadb8");
final encrypter = en.Encrypter(
  en.AES(key),
);

// import '../data/environment/environment.dart';

class Ecryption {
  // String privateKey = Environment.getKey();
  // String privateIv = Environment.getIV();
  String privateKey = "12678675490987575346789788765328";
  String privateIv = "e16ce888a20dadb8";

  String decrypt(String encrypted) {
    final key =
        en.Key.fromUtf8(privateKey); //hardcode combination of 16 character
    final iv = en.IV.fromUtf8(privateIv); //hardcode combination of 16 character

    final encrypter = en.Encrypter(en.AES(key));
    en.Encrypted enBase64 = en.Encrypted.from64(encrypted);
    final decrypted = encrypter.decrypt(enBase64, iv: iv);
    return decrypted;
  }

  String encrypt(String value) {
    final key = en.Key.fromUtf8(privateKey); //hardcode
    final iv = en.IV.fromUtf8(privateIv); //hardcode

    final encrypter = en.Encrypter(en.AES(
      key,
    ));
    final encrypted = encrypter.encrypt(value, iv: iv);

    return encrypted.base64;
  }
}
