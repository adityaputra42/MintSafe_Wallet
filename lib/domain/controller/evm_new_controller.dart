import 'dart:convert';
import 'dart:developer';

import 'package:eth_abi_codec/eth_abi_codec.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import '../../data/data.dart';
import '../../utils/utils.dart';

class EvmNewController extends GetxController {
  final Address address;
  EvmNewController({required this.address});

  var selectedPrivateKey = "".obs;
  var selectedMnemonic = "".obs;
  var isLoadingNetwork = false.obs;
  var selectedChain = ChainNetwork().obs;
  var listChain = <ChainNetwork>[].obs;
  var listToken = <Token>[].obs;
  var listSelectedToken = <Token>[].obs;
  var dappsHistory = <DappsHistory>[].obs;

  Web3Client? web3client;
  ContractAbi? erc20Abi;
  RxList<Address> addressList = <Address>[].obs;
  Rx<Address> selectedAddress = Address().obs;
  RxList<Result> tokenList = <Result>[].obs;
  RxList<RecentAddress> recentAddress = <RecentAddress>[].obs;
  RxList<TransactionHistory> transactionHistory = <TransactionHistory>[].obs;
  late ContractABI abi;

  @override
  void onInit() async {
    isLoadingNetwork.value = true;
    await initialize();
    await getTokens();

    initializedRecentAddress();
    decrypted(
      selectedAddress.value.privateKey ?? "",
    );
    var httpClient = http.Client();
    web3client = Web3Client(
      selectedChain.value.rpc ?? "",
      httpClient,
    );

    isLoadingNetwork.value = false;
    super.onInit();
  }

  decrypted(
    String pk,
  ) {
    final privateKey = encrypter.decrypt64(pk, iv: iv);
    // final mnmemonic = encrypter.decrypt64(seed, iv: iv);
    selectedPrivateKey.value = privateKey;
    // selectedMnemonic.value = mnmemonic;
  }

  Future<void> initialize() async {
    try {
      final jsonString = await rootBundle.loadString('asset/abi/erc_20.json');
      erc20Abi = ContractAbi.fromJson(jsonString, 'ERC20');
      abi = ContractABI.fromJson(jsonDecode(jsonString));

      await initialzedNetwork();
    } catch (error) {
      log("Error loading asset: $error");
    }

    final addresses = await DbHelper.instance.readAddressList();

    addressList.clear();
    addressList.assignAll(addresses!);

    if (selectedAddress.value.address == null) {
      selectedAddress.value = address;
    }
  }

  initialzedNetwork() async {
    /// GET LIST NETWORK
    listChain.clear();
    final networkList = await DbHelper.instance.getAllChainNetwork();

    if (networkList.isEmpty) {
      final chainlist = await rootBundle.loadString('asset/abi/chain.json');
      listChain.value = chainNetworkFromJson(chainlist);
      listChain[0].selected = true;
      await DbHelper.instance.setChainNetwork(listChain);
      final selectedNetwork = await DbHelper.instance.getSelectedChainNetwork();
      if (selectedNetwork == null) {
        selectedChain.value = listChain[0];
      } else {
        selectedChain.value = selectedNetwork;
      }
    } else {
      var chain = await DbHelper.instance.getSelectedChainNetwork();
      selectedChain.value = chain!;
      listChain.value = networkList;
    }

    selectedChain.refresh();
    log(selectedChain.value.symbol ?? '');
    listChain.refresh();
    initialzedToken();
  }

  initialzedToken() async {
    /// GET LIST Token
    listToken.clear();
    final listTokens = await DbHelper.instance.getAllTokens();

    if (listTokens.isEmpty) {
      final tokens = await rootBundle.loadString('asset/abi/token.json');
      listToken.value = tokenFromJson(tokens);
      await DbHelper.instance.setToken(listToken);
      final selectedToken = await DbHelper.instance
          .getSelectedListToken(selectedChain.value.chainId ?? "");
      if (selectedToken.isEmpty) {
        listSelectedToken.value = [];
      } else {
        listSelectedToken.value = selectedToken;
      }
    } else {
      final token = await DbHelper.instance
          .getSelectedListToken(selectedChain.value.chainId ?? "");
      listSelectedToken.value = token;
      listToken.value = listTokens;
    }

    listSelectedToken.refresh();
    listToken.refresh();
  }

  getTokens() async {
    final tokens = await DbHelper.instance.getAllToken();
    tokenList.clear();
    tokenList.addAll(tokens);

    refresh();
  }

  initializedRecentAddress() async {
    final list = await DbHelper.instance.getRecentAddress();
    recentAddress.clear();
    recentAddress.addAll(list);
    recentAddress.refresh();
  }
}
