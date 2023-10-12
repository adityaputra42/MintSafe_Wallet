import 'package:get/get.dart';

import '../../data/data.dart';
import 'evm_new_controller.dart';

class AddTokenController extends GetxController {
  EvmNewController evm = Get.find();
  var selectedTab = 0.obs;
  void changeTab(int index) => selectedTab.value = index;
  var tokenList = <Token>[].obs;
  @override
  void onInit() {
    tokenList.value = evm.tokenList;
    super.onInit();
  }
}
