import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:ffcache/ffcache.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../data/data.dart';
import '../controller/evm_new_controller.dart';

class ActivityRepository {
  Future<List<Activity>> findAllActivity(String address,
      {required bool isTestnet, required int page}) async {
    EvmNewController evm = Get.find();

    String explorer = evm.selectedChain.value.explorerApi ?? "";
    final cache = FFCache(debug: true);

    String url =
        "$explorer/api?module=account&action=txlist&address=$address&sort=desc&page=$page";
    print(url);

    if (await ConnectivityWrapper.instance.isConnected) {
      print("CONNECTED");
      var response = await http.get(Uri.parse(url));

      log("response => ${response.body}");
      var json = jsonDecode(response.body)['result'];
      if (json is List && json.isNotEmpty) {
        await cache.setJSON('key', json);
        return json.map((e) => Activity.fromJson(e)).toList();
      }
    } else {
      print("NO DATA");

      print("CACHE : $cache");
      var json = await cache.getJSON('key');
      print(json);

      if (json is List) {
        return json.map((e) => Activity.fromJson(e)).toList();
      }
    }

    return [];
  }

  Future<List<Activity>> findActivityToken(String address,
      {required bool isTestnet, required int page}) async {
    EvmNewController evm = Get.find();

    String explorer = evm.selectedChain.value.explorer ?? "";
    final cache = FFCache(debug: true);

    String url =
        "$explorer/api?module=account&action=tokentx&address=$address&sort=desc&page=$page";
    print(url);

    if (await ConnectivityWrapper.instance.isConnected) {
      print("CONNECTED");
      var response = await http.get(Uri.parse(url));
      var json = jsonDecode(response.body)['result'];
      if (json is List && json.isNotEmpty) {
        await cache.setJSON('key1', json);
        return json.map((e) => Activity.fromJson(e)).toList();
      }
    } else {
      print("NO DATA");

      print("CACHE : $cache");
      var json = await cache.getJSON('key1');
      print(json);

      if (json is List) {
        return json.map((e) => Activity.fromJson(e)).toList();
      }
    }

    return [];
  }

// https://t-explorer.beonescan.com/address/0x69c2A487a3F4dC3a1d0971DfE1daEdF93C18e86E?type=JSON
  // Future findActivityToken(String address) async {
  //   // String url =
  //   //     "https://www.bethscan.io/address/$address/token-transfers?type=JSON";

  //   String url =
  //       "https://www.bethscan.io/address/0xc8D3428dBb64cd8b1f1BA53c6840C2EddA0E2EC0/token-transfers?type=JSON";

  //   var response = await http.get(Uri.parse(url));
  //   var json = jsonDecode(response.body);

  //   var items = json['items'];

  //   // // / HASH
  //   // final regex = RegExp(r'data-identifier-hash="(.*?)"');
  //   // final match = regex.firstMatch(items[0]);
  //   // final value = match?.group(1);

  //   // // /// To
  //   // final regexTo = RegExp(r'data-address-hash="(.*?)"');
  //   // final matchTo = regexTo.firstMatch(items[0]);
  //   // final valueTo = matchTo?.group(1);

  //   final regexToken =  RegExp(r'<a.*?>(.*?)<\/a>');
  //   final matchToken = regexToken.firstMatch(items[0]);
  //   final valueToken = matchToken?.group(1);

  //   // print("HASH VALUE : $value");
  //   // print("TO : $valueTo");
  //   print("TOKEN : $valueToken");

  //   // print(document.querySelector('div[data-identifier-hash]'));
  //   // var divElement = document.querySelector('div[data-identifier-hash]');
  //   // var identifierHash = divElement!.attri butes['data-identifier-hash'];
  //   // print("IDENTIFIER HASH : $identifierHash");

  //   return 'response';
  // }
}
