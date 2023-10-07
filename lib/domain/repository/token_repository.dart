import 'dart:async';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';

import '../../data/data.dart';

class TokenRepository {
  Future<ResultToken> getToken(String address) async {
    EvmNewController evmController = Get.find();
    String explorer = evmController.selectedChain.value.explorer ?? "";
    String url =
        "$explorer/api?module=account&action=tokenlist&address=$address";
    log("URLLL : ${url}");
    var response = await http.get(Uri.parse(url));
    print("+==========Response===========+");
    print(response.body);
    return resultTokenFromJson(response.body);
  }
}
