import 'package:mintsafe_wallet/domain/repository/dapp/dapp_repository.dart';
import '../../../config/config.dart';
import '../../../data/data.dart';

class DappRepositoryImpl implements DappRepository {
  final String baseUrl = Environment.getApiBaseUrl();
  final String? appVersion = Environment.getApiAppVersion();
  ApiClient client = ApiClient();

  @override
  Future<BaseResponse> getDapp({required String chain}) async {
    try {
      String url = "$baseUrl$appVersion/dapps?chain=$chain";
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
