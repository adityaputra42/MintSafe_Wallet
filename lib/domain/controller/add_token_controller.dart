import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/model/token/selected_token.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import 'evm_new_controller.dart';

class AddTokenController extends GetxController {
  EvmNewController evm = Get.find();
  var selectedTab = 0.obs;
  void changeTab(int index) => selectedTab.value = index;
 

  void setToken(SelectedToken token) async {
    if (evm.tokenSelected.any((element) =>
        element.contractAddress!.toLowerCase() ==
            token.contractAddress!.toLowerCase() &&
        element.walletAddress == evm.selectedAddress.value.address)) {
      await DbHelper.instance.deleteSelectedToken(token.contractAddress ?? "");
      await evm.initialzedToken();
      evm.tokenList.refresh();
      evm.tokenSelected.refresh();
    } else {
      await DbHelper.instance.changeSelectedToken(token);
      await evm.initialzedToken();
      evm.tokenList.refresh();
      evm.tokenSelected.refresh();
    }
  }
}
