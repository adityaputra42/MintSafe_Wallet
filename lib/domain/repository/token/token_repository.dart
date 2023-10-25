import 'package:mintsafe_wallet/config/config.dart';

abstract class TokenRepository {
  Future<BaseResponse> getTokenBalance({
    required String rpc,
    required String walletAddress,
    required String contractAddress,
  });

  Future<BaseResponse> getTokenTransaction({
    required String address,
    required String chainId,
    required String contractAddress,
  });

  Future<BaseResponse> getTokenPrice({
    required String contract,
  });
}
