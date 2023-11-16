import 'package:get/get.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../data/data.dart';

class BrowserController extends GetxController {
  var dappsHistory = <DappsHistory>[].obs;

  @override
  void onInit() {
    getDappsHistory();
    super.onInit();
  }

  Future<void> getDappsHistory() async {
    final list = await DbHelper.instance.getDappsHistory();
    dappsHistory.assignAll(list);
    dappsHistory.refresh();
  }

  Future<void> addDappsHistory(DappsHistory history) async {
    await DbHelper.instance.addHistoryDapps(history);
    await getDappsHistory();
  }

  Future<void> deleteDappsHistory(int id) async {
    await DbHelper.instance.deleteDappsHistory(id);
    await getDappsHistory();
  }
}
