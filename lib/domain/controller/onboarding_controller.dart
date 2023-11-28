import 'package:get/get.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../view/pages/page.dart';

class OnboardingController extends GetxController {
  var selectedIndex = 0.obs;
  changeIndex() {
    if (selectedIndex.value < 2) {
      selectedIndex.value++;
    } else {
      PrefHelper.instance.setFirstInstall();
      Get.to(() => const GetStartedPage());
      selectedIndex.value = 0;
    }
  }
}
