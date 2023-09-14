import 'dart:async';

import 'package:get/get.dart';
import 'package:mintsafe_wallet/utils/helper/helper.dart';
import 'package:mintsafe_wallet/view/pages/onboarding/onboarding_screen.dart';
import 'package:mintsafe_wallet/view/pages/page.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    startTime();
    super.onInit();
  }

  startTime() async {
    return Timer(const Duration(milliseconds: 4500), checkWallet);
  }

  void checkWallet() async {
    final selectedAddress = await DbHelper.instance.getSelectedWallet();
    if (selectedAddress != null) {
      Get.offAll(() => MainPage(
            address: selectedAddress,
          ));
    } else {
      Get.to(() => OnboardingScreen());
    }
  }
}
