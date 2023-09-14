import 'package:encrypt/encrypt.dart' as en;

final key = en.Key.fromUtf8('12678675490987575346789788765328');
final iv = en.IV.fromLength(16);
final encrypter = en.Encrypter(en.AES(key));