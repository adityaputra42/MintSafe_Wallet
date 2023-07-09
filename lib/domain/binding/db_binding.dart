import 'package:get/get.dart';

import '../controller/controller.dart';

class DbBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<DBController>(DBController());
  }
}