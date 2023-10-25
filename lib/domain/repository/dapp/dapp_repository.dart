import 'package:mintsafe_wallet/config/config.dart';

abstract class DappRepository {
  Future<BaseResponse> getDapp({
    required String chain,
  });
}
