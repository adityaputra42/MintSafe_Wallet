import 'package:get/get.dart';

class CreateWalletController extends GetxController {
  var stepIndex = 0.obs;

  void changeStep(int index) => stepIndex.value = index;
}
