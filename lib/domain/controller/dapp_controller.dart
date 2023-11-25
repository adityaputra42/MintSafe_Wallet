import 'dart:developer';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mintsafe_wallet/domain/controller/browser_controller.dart';
import 'package:web3_provider/web3_provider.dart';
import 'package:web3dart/web3dart.dart';

import '../../data/data.dart';
import '../../data/model/browser/browser_tab.dart';
import '../../utils/utils.dart';
import 'evm_new_controller.dart';

class DappsController extends GetxController {
  EvmNewController evm = Get.find();
  BrowserController browserController = Get.find();

  // AddNetworkController addNetworkController = Get.put(AddNetworkController());
  var title = "".obs;
  var url = "".obs;
  var isSearch = false.obs;
  Web3Client? web3client;
  DebouncerHelper debouncer = DebouncerHelper(milliseconds: 500);
  late InAppWebViewController webController;

  var listBrowserTab = <BrowserTab>[].obs;

  @override
  void onInit() {
    var httpClient = Client();
    web3client = Web3Client(
      evm.selectedChain.value.rpc ?? "",
      httpClient,
    );

    loadTabs();

    super.onInit();
  }

  setSearch(String? value) {
    if (value != null) {
      if (value.isNotEmpty) {
        isSearch.value = true;
      } else {
        isSearch.value = false;
      }
    }
  }

  changedTitle(String value) {
    title.value = value;
  }

  initWebController(InAppWebViewController controller) async {
    webController = controller;
    final title = await webController.getTitle();
    final uri = await webController.getUrl();
    // final image = await webController.requestImageRef();

    url.value = uri.toString();

    if (title != "") {
      await browserController
          .addDappsHistory(DappsHistory(title: title, url: uri.toString()));
    }
  }

  void onSearchChange(String value) {
    debouncer.run(() {
      loadUrl(value);
    });
  }

  loadUrl(String? url) {
    final uri = Uri.tryParse(url!);

    if (uri != null && uri.isAbsolute) {
      webController.loadUrl(urlRequest: URLRequest(url: Uri.parse(url)));
    } else {
      webController.loadUrl(
          urlRequest: URLRequest(
              url: Uri.parse("https://www.google.com/search?q=$url")));
    }
  }

  loadTabs() async {
    listBrowserTab.value = await DbHelper.instance.getAllBrowserTab();
    if (listBrowserTab.isEmpty) {
      addTab(BrowserTab(
          isSelected: true,
          name: "New Tab",
          url: evm.selectedChain.value.explorer));
    }
  }

  BrowserTab selectedTab() {
    final selected = listBrowserTab.where(
      (element) => element.isSelected == true,
    );

    if (selected.isNotEmpty) {
      return selected.first;
    } else {
      return BrowserTab();
    }
  }

  addTab(BrowserTab tab) async {
    await DbHelper.instance.addBrowserTab(tab);
    await changeTab(tab);
    await loadTabs();
    // listBrowserTab.add(tab);
  }

  closeAllTab() async {
    await DbHelper.instance.closeAllBrowserTab();
    listBrowserTab.clear();
    await loadTabs();
  }

  changeTab(BrowserTab tab) async {
    await DbHelper.instance.changeBrowserTab(tab);
    // listBrowserTab.remove(tab);
    await loadTabs();
  }

  onChangeEventTab(BrowserTab tab) async {
    await DbHelper.instance.onTabStateChanged(tab);
    await loadTabs();
  }

  closeTabs(int id) async {
    final indexToDelete = listBrowserTab.indexWhere((tab) => tab.id == id);

    if (indexToDelete != -1) {
      if (indexToDelete > 0) {
        listBrowserTab[indexToDelete - 1].isSelected = true;
        DbHelper.instance.changeBrowserTab(listBrowserTab[indexToDelete - 1]);
      }

      if (indexToDelete < listBrowserTab.length - 1) {
        listBrowserTab[indexToDelete + 1].isSelected = true;
        DbHelper.instance.changeBrowserTab(listBrowserTab[indexToDelete + 1]);
      }

      listBrowserTab.removeAt(indexToDelete);
      await DbHelper.instance.deleteBrowserTab(id);
      await loadTabs();
    } else {
      log("Tab with ID $id not found.");
    }
  }

  Future<String> screenshotTab() async {
    final ss = await webController
        .takeScreenshot(
            screenshotConfiguration: ScreenshotConfiguration(
          compressFormat: CompressFormat.JPEG,
          quality: 20,
        ))
        .timeout(
          const Duration(
            milliseconds: 1500,
          ),
          onTimeout: () => null,
        );

    String hexString = ss!.map((byte) {
      return byte.toRadixString(16).padLeft(2, '0');
    }).join('');

    return hexString;
  }

  Uint8List getImageTab(String hexString) {
    Uint8List image =
        Uint8List.fromList(List<int>.generate(hexString.length ~/ 2, (index) {
      return int.parse(hexString.substring(index * 2, index * 2 + 2),
          radix: 16);
    }));
    return image;
  }
}
