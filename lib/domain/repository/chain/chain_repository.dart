import 'package:mintsafe_wallet/config/config.dart';

abstract class ChainRepository {
  Future<BaseResponse> getChainBalance({
    required String rpc,
    required String address,
  });

  Future<BaseResponse> getChaimTransaction({
    required String address,
    required String chainId,
  });

  Future<BaseResponse> getNFT({
    required String address,
    required String chainId,
  });
}
