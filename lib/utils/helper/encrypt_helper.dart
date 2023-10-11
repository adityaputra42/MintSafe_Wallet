import 'package:encrypt/encrypt.dart' as en;

final key = en.Key.fromUtf8('12678675490987575346789788765328');
// final key = en.Key.fromSecureRandom(32);
final iv = en.IV.fromUtf8("e16ce888a20dadb8");
final encrypter =
    en.Encrypter(en.AES(key),);
    
