import 'package:mintsafe_wallet/domain/repository/chain/chain_repository.dart';

import '../../../config/config.dart';
import '../../../data/data.dart';

class ChainRepositoryImpl implements ChainRepository {
  final String baseUrl = Environment.getApiBaseUrl();
  final String? appVersion = Environment.getApiAppVersion();
  ApiClient client = ApiClient();

  @override
  Future<BaseResponse> getChaimTransaction(
      {required String address, required String chainId}) async {
    try {
      String url = "$baseUrl$appVersion/tx?address=$address &chainId=$chainId";
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
  Future<BaseResponse> getChainBalance(
      {required String rpc, required String address}) async {
    try {
      String url = "$baseUrl$appVersion/balance?rpc=$rpc&address=$address";
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
  Future<BaseResponse> getNFT(
      {required String address, required String chainId}) async {
    try {
      String url = "$baseUrl$appVersion/nft?address=$address&chain=$chainId";
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
