import 'package:mintsafe_wallet/domain/repository/token/token_repository.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';

class TokenRepositoryImpl implements TokenRepository {
  final String baseUrl = Environment.getApiBaseUrl();
  final String? appVersion = Environment.getApiAppVersion();
  ApiClient client = ApiClient();

  @override
  Future<BaseResponse> getTokenBalance({
    required String rpc,
    required String walletAddress,
    required String contractAddress,
  }) async {
    try {
      String url =
          "$baseUrl$appVersion/balance/token?rpc=$rpc&contractAddress=$contractAddress&walletAddress=$walletAddress";
      var response = await client.get(Uri.parse(url));
      return BaseResponse(
        response.statusCode,
        response.body,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<BaseResponse> getTokenPrice({
    required String contract,
  }) async {
    try {
      String url = "$baseUrl$appVersion/token/price?contract=$contract";
      var response = await client.get(Uri.parse(url));
      return BaseResponse(
        response.statusCode,
        response.body,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<BaseResponse> getTokenTransaction(
      {required String address,
      required String chainId,
      required String contractAddress}) async {
    try {
      String url =
          "$baseUrl$appVersion/token/tx?address=$address&contract=$contractAddress&chainId=$chainId";
      var response = await client.get(Uri.parse(url));
      return BaseResponse(
        response.statusCode,
        response.body,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
