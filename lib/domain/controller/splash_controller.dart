import 'dart:async';

import 'package:get/get.dart';
import 'package:mintsafe_wallet/view/pages/page.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    startTime();
    super.onInit();
  }

  startTime() async {
    return Timer(const Duration(milliseconds: 4500), isNewUser);
  }

  void isNewUser() async {
    Get.to(()=>const GetStartedPage());
  }
}
