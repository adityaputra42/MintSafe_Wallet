import 'package:encrypt/encrypt.dart' as en;

class Ecryption {
  String privateKey = "12678675490987575346789788765328";
  String privateIv = "e16ce888a20dadb8";

  String decrypt(String encrypted) {
    final key = en.Key.fromUtf8(privateKey);
    final iv = en.IV.fromUtf8(privateIv);

    final encrypter = en.Encrypter(en.AES(key));
    en.Encrypted enBase64 = en.Encrypted.from64(encrypted);
    final decrypted = encrypter.decrypt(enBase64, iv: iv);
    return decrypted;
  }

  String encrypt(String value) {
    final key = en.Key.fromUtf8(privateKey);
    final iv = en.IV.fromUtf8(privateIv);

    final encrypter = en.Encrypter(en.AES(
      key,
    ));
    final encrypted = encrypter.encrypt(value, iv: iv);

    return encrypted.base64;
  }
}
