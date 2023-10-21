import 'dart:async';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController extends GetxController {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription connectivitySubscription;
  var hasInternet = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await initConnectivity();

    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Status Koneksi: Error', error: e);
      return;
    }

    return await updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus = result;

    switch (result) {
      case ConnectivityResult.mobile:
        hasInternet.value = true;
        break;
      case ConnectivityResult.wifi:
        hasInternet.value = true;
        break;
      case ConnectivityResult.none:
        hasInternet.value = false;
        break;

      default:
        hasInternet.value = false;
    }
  }

  Future<void> checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    connectionStatus = result;
  }
}