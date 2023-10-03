import 'package:mintsafe_wallet/data/data.dart';

class EvmHelper {
  late Address address;
  EvmHelper._privateConstructor();
  static final EvmHelper instance = EvmHelper._privateConstructor();
  factory EvmHelper() {
    return instance;
  }
}
