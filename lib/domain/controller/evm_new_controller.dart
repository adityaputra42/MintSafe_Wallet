// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:erc20/erc20.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_update/in_app_update.dart';
import 'package:mintsafe_wallet/data/model/token/selected_token.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:web3dart/web3dart.dart';

import '../../config/config.dart';
import '../../data/data.dart';
import '../../data/model/chain_network/list_chain_selected.dart';
import '../../data/model/chain_network/selected_chain.dart';
import '../../data/model/nft/nft.dart';
import '../../data/model/nft/nft_vew.dart';
import '../../utils/utils.dart';
import '../repository/activity_repository.dart';
import 'bottom_navbar_controller.dart';

class EvmNewController extends GetxController {
  /// #######################################
  /// ############### HOME STATE ###############
  /// #######################################
  var isShowImportBottomSheet = false.obs;

  showImportBottomSheet() => isShowImportBottomSheet.value = true;
  hideImportBottomSheet() {
    importAddressInputController.clear();
    isShowImportBottomSheet.value = false;
  }

  final Address initAddress;
  Web3Client? web3client;
  ContractAbi? erc20Abi;
  ContractAbi? tokenRegistryAbi;
  ContractAbi? erc721Abi;
  var gasLimit = 0.0.obs;
  var gasPrice = 0.0.obs;
  var tabHomeIndex = 0.obs;

  changeTabHome(int index) {
    tabHomeIndex.value = index;
  }

  EvmNewController(this.initAddress);

  var versionApp = "".obs;

  void getVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    versionApp.value = "v$version ($buildNumber)";
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate().then((value) {
          if (value == AppUpdateResult.success) {
            dev.log("Update Success");
          }
        });
      } else if (info.flexibleUpdateAllowed) {
        InAppUpdate.startFlexibleUpdate().then((value) {
          if (value == AppUpdateResult.success) {
            InAppUpdate.completeFlexibleUpdate();
          }
        });
      }
    });
  }

  void initialize() async {
    isLoadingNetwork.value = true;
    // INIT NETWORK

    await initAccount();
    await initialzedNetwork();

    /// INIT RPC
    initWeb3RPC();

    /// INIT CONTRACT
    final erc20AbiString = await rootBundle.loadString('asset/abi/ERC-20.json');
    final nftAbiString = await rootBundle.loadString('asset/abi/ERC-721.json');
    erc20Abi = ContractAbi.fromJson(erc20AbiString, 'ERC20');
    erc721Abi = ContractAbi.fromJson(nftAbiString, 'ERC721');

    /// INIT ACCOUNT
    decrypted(
      selectedAddress.value.privateKey!,
    );

    // INIT TOKEN

    await initializeNFt();
    await initialzedToken();

    // getVersionInfo();
    isLoadingNetwork.value = false;
    //  GET BALANCE
    if (await ConnectivityWrapper.instance.isConnected) {
      findAllActivity();
      await getBalance();
      await getMultipleTokenBalances();
      getEthBalancePeriodic();
    }
  }

  @override
  void onInit() {
    initialize();
    // checkForUpdate();
    super.onInit();
  }

  /// #######################################
  /// ############### WEB3 RPC ###############
  /// #######################################
  void initWeb3RPC() {
    dev.log("RPC : ${selectedChain.value.rpc}");
    var httpClient = http.Client();
    web3client = Web3Client(
      selectedChain.value.rpc ?? "",
      httpClient,
    );
  }

  /// #######################################
  /// ############### NETWORK ###############
  /// #######################################
  ///

  var isLoadingNetwork = false.obs;
  var selectedChain = ListChainSelected().obs;
  var listChain = <ChainNetwork>[].obs;
  var listChainSelected = <ListChainSelected>[].obs;

  Future<void> initialzedNetwork() async {
    /// GET LIST NETWORK
    listChain.clear();
    listChainSelected.clear();
    final networkList = await DbHelper.instance.getAllChainNetwork();
    if (networkList.isEmpty) {
      final chainlist = await rootBundle.loadString('asset/abi/chain.json');
      listChain.value = chainNetworkFromJson(chainlist);
      await DbHelper.instance.setAllChainNetwork(listChain);
    } else {
      listChain.assignAll(networkList);
    }
    final listChainWallet = await DbHelper.instance.getSelectedChainWallet(
      walletAddress: selectedAddress.value.address ?? "",
    );
    if (listChainWallet.isEmpty) {
      var selectChain = ListChainSelected(
        name: listChain.first.name,
        symbol: listChain.first.symbol,
        rpc: listChain.first.rpc,
        chainId: listChain.first.chainId,
        explorer: listChain.first.explorer,
        explorerApi: listChain.first.explorerApi,
        logo: listChain.first.logo,
        color: listChain.first.color,
        isTestnet: listChain.first.isTestnet,
        walletAddress: selectedAddress.value.address ?? "",
      );
      await DbHelper.instance.setSelectedChainWallet(selectChain);
      final chainWallet = await DbHelper.instance.getSelectedChainWallet(
        walletAddress: selectedAddress.value.address ?? "",
      );
      listChainSelected.assignAll(chainWallet);
    } else {
      listChainSelected.assignAll(listChainWallet);
    }

    final chainSelected = await DbHelper.instance.getSelectedChain();
    dev.log("SelectedChain => ${chainSelected.chainId}");
    if (chainSelected.chainId == null) {
      final selected = SelectedChain(chainId: listChain.first.chainId);
      await DbHelper.instance.setSelectedChain(selected);
      selectedChain.value = listChainSelected.first;
    } else if (!listChainSelected.any((element) =>
        element.chainId!.toLowerCase() ==
        chainSelected.chainId!.toLowerCase())) {
      changeNetwork(listChainSelected.first);
    } else {
      var chain = await DbHelper.instance.getSelectedChainNetwork();
      selectedChain.value = chain!;
    }
    selectedChain.refresh();
    listChain.refresh();
    listChainSelected.refresh();
    dev.log("Selected chain ==> ${selectedChain.value.chainId}");
    for (var value in listChain) {
      dev.log("List Chain ==> ${value.chainId}");
    }
  }

  // Future<void> initialzedNetwork() async {
  //   /// GET LIST NETWORK
  //   listChain.clear();
  //   listChainSelected.clear();
  //   final networkList = await DbHelper.instance.getAllChainNetwork();
  //   List<int> id = [];
  //   for (final value in networkList) {
  //     id.add(value.id!);
  //   }
  //   await DbHelper.instance.deleteAllChainNetwork(id);
  //   final chainlist = await rootBundle.loadString('asset/abi/chain.json');
  //   listChain.value = chainNetworkFromJson(chainlist);
  //   await DbHelper.instance.setChainNetwork(listChain);

  //   final listChainWallet = await DbHelper.instance.getSelectedChainWallet(
  //     walletAddress: selectedAddress.value.address ?? "",
  //   );
  //   if (listChainWallet.isEmpty) {
  //     var selectChain = ListChainSelected(
  //       name: listChain.first.name,
  //       symbol: listChain.first.symbol,
  //       rpc: listChain.first.rpc,
  //       chainId: listChain.first.chainId,
  //       explorer: listChain.first.explorer,
  //       explorerApi: listChain.first.explorerApi,
  //       logo: listChain.first.logo,
  //       color: listChain.first.color,
  //       isTestnet: listChain.first.isTestnet,
  //       walletAddress: selectedAddress.value.address ?? "",
  //     );
  //     await DbHelper.instance.setSelectedChainWallet(selectChain);
  //     final chainWallet = await DbHelper.instance.getSelectedChainWallet(
  //       walletAddress: selectedAddress.value.address ?? "",
  //     );
  //     listChainSelected.assignAll(chainWallet);
  //   } else {
  //     listChainSelected.assignAll(listChainWallet);
  //   }

  //   final chainSelected = await DbHelper.instance.getSelectedChain();
  //   dev.log("SelectedChain => ${chainSelected.chainId}");
  //   if (chainSelected.chainId == null) {
  //     final selected = SelectedChain(chainId: listChain.first.chainId);
  //     await DbHelper.instance.setSelectedChain(selected);
  //     selectedChain.value = listChainSelected.first;
  //   } else if (!listChainSelected.any((element) =>
  //       element.chainId!.toLowerCase() ==
  //       chainSelected.chainId!.toLowerCase())) {
  //     changeNetwork(listChainSelected.first);
  //   } else {
  //     var chain = await DbHelper.instance.getSelectedChainNetwork();
  //     selectedChain.value = chain!;
  //   }
  //   selectedChain.refresh();
  //   listChain.refresh();
  //   listChainSelected.refresh();
  //   dev.log("Selected chain ==> ${selectedChain.value.chainId}");
  //   for (var value in listChain) {
  //     dev.log("List Chain ==> ${value.chainId}");
  //   }
  // }

  void changeNetwork(ListChainSelected network) async {
    isLoadingNetwork.value = true;
    selectedChain.value = network;
    selectedChain.refresh();
    await DbHelper.instance.changeNetwork(network);
    Get.back();
    initWeb3RPC();
    await getBalance();
    await initialzedToken();
    await findAllActivity(isRefresh: true);
    isLoadingNetwork.value = false;
    await getMultipleTokenBalances();
  }

  /// #######################################
  /// ############### ACCOUNT ###############
  /// #######################################

  RxList<Address> addressList = <Address>[].obs;
  RxList<Address> anotherAddressList = <Address>[].obs;
  Rx<Address> selectedAddress = Address().obs;
  var selectedPrivateKey = ''.obs;
  var prefBalance = 0.0.obs;
  var balanceEth = 0.0.obs;
  late Timer timer;
  var isLoadingImportAccount = false.obs;
  var isLoadingCreateAccount = false.obs;
  var isLoadingInitAccount = false.obs;
  var isLoadingBalance = false.obs;

  Future<void> initAccount() async {
    isLoadingInitAccount.value = true;
    final addresses = await DbHelper.instance.readAddressList();

    addressList.clear();
    addressList.assignAll(addresses!);

    if (selectedAddress.value.address == null) {
      selectedAddress.value = initAddress;
    }
    anotherAddressList.clear();
    anotherAddressList.assignAll(addressList
        .where((e) => e.address != selectedAddress.value.address)
        .toList());
    isLoadingInitAccount.value = false;
  }

  decrypted(
    String pk,
  ) {
    dev.log("SELECTED ADDRESS : ${selectedAddress.value.address}");
    dev.log("SELECTED ADDRESS PK : ${selectedAddress.value.privateKey}");
    // dev.log("SELECTED MNEMONIC  : ${selectedAddress.value.mnemonic}");

    final privateKey = Ecryption().decrypt(pk);
    dev.log("PRIVATE KEY : $privateKey");
    // final mnmemonic = Ecryption().decrypt(seed);

    selectedPrivateKey.value = privateKey;
    // selectedMnemonic.value = mnmemonic;
  }

  Future<void> getBalance() async {
    prefBalance.value = selectedAddress.value.balance!;
    for (var add in addressList) {
      try {
        if (await ConnectivityWrapper.instance.isConnected) {
          EtherAmount balance = await web3client!
              .getBalance(EthereumAddress.fromHex(add.address!));
          dev.log("balance eth => $balance");
          double balanceParsed = double.parse(
              balance.getValueInUnit(EtherUnit.ether).toStringAsPrecision(5));
          dev.log("balance eth => $balanceParsed");
          add.balance = balanceParsed;
          await DbHelper.instance.updateWallet(add.id!, balanceParsed);
          if (add.address == selectedAddress.value.address) {
            selectedAddress.value.balance = balanceParsed;
            selectedAddress.refresh();
          }
        }
        balanceEth.value = selectedAddress.value.balance!;
      } catch (e) {
        dev.log("Failed to Get balance => $e");
      }

      selectedAddress.value.balance = balanceEth.value;
      selectedAddress.refresh();
    }

    balanceEth.value = selectedAddress.value.balance!;
    addressList.refresh();
    if (selectedAddress.value.balance! > 0 &&
        prefBalance.value != selectedAddress.value.balance) {
      dev.log("============History Update============>");
    }
    dev.log("=========PrevBalance=========>");
    dev.log(prefBalance.value.toString());
    dev.log("=========new Balance=========>");
    dev.log(selectedAddress.value.balance!.toString());
    // dev.log("GET BALANCE : ADDRESS LIST = ${selectedAddress.value.balance!}");
  }

  void getEthBalancePeriodic() {
    timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      getBalance();
      getMultipleTokenBalances();
    });
  }

  void changeAddress(Address address) async {
    dev.log("SELECTED WALLET ADDRESS : ${selectedAddress.value.id}");
    await DbHelper.instance.unSelectWallet(selectedAddress.value.id!);
    dev.log("INIT ADDRESS : ${selectedAddress.value.id!}");

    selectedAddress.value = address;
    selectedAddress.refresh();

    await DbHelper.instance.changeWallet(address.id!);
    // await getTokenFromContract();
    await initializeNFt();
    dev.log("NEW ADDRESS : ${address.id!}");

    decrypted(
      selectedAddress.value.privateKey!,
    );
    Get.back();

    if (await ConnectivityWrapper.instance.isConnected) {
      await initialzedNetwork();
      await findAllActivity(isRefresh: true);
      await initializeNFt();
      await getBalance();
      await getMultipleTokenBalances();
    }
    decrypted(selectedAddress.value.privateKey!);

    anotherAddressList.clear();

    anotherAddressList.assignAll(
        addressList.where((e) => e.address != address.address).toList());
    anotherAddressList.refresh();

    // final listAddress = await db.readAddressList();
    // listAddress!.forEach((element) {
    //   dev.log(element.name);
    //   dev.log(element.address);
    // });
  }

  Future<void> createNewAddress() async {
    isLoadingCreateAccount.value = true;
    final mnemonic = WalletHelper().generateMnemonic();
    var account = WalletHelper().getAccountInfo(mnemonic);
    await DbHelper.instance.unSelectWallet(selectedAddress.value.id!);
    final mnemonicEncrypt = Ecryption().encrypt(account['mnemonic']!);
    final privateKeyEncrypt = Ecryption().encrypt(account['private_key']!);
    Address addressNew = Address(
        name: "Account",
        address: account['address'],
        mnemonic: mnemonicEncrypt,
        balance: 0,
        selectedAddress: true,
        privateKey: privateKeyEncrypt);

    selectedAddress.value = addressNew;
    addressList.add(addressNew);
    Get.back();

    await DbHelper.instance.addAddress(addressNew);
    await DbHelper.instance.changeWallet(addressNew.id!);
    changeAddress(addressNew);
    decrypted(
      selectedAddress.value.privateKey!,
    );

    findAllActivity(isRefresh: true);
    await initializeNFt();
    await getBalance();
    isLoadingCreateAccount.value = false;
    final listAddress = await DbHelper.instance.readAddressList();
    for (var element in listAddress!) {
      dev.log(element.name.toString());
      dev.log(element.address.toString());
    }
  }

  /// IMPORT ADDRESS FROM MNEMONIC OR PRIVATE KEY

  var importAddressInputController = TextEditingController();
  var passwordCreateAccountController = TextEditingController();
  var importAddressPrivateKeyController = TextEditingController();
  var importAddressMnemonicController = TextEditingController();
  var isLoadingImportMnemonic = false.obs;
  var isLoadingImportPrivateKey = false.obs;
  Future<void> importAddressByMnemonic(String key) async {
    isLoadingImportMnemonic.value = true;

    if (WalletHelper().validateMnemonic(key)) {
      var address = await compute(importMnemonic, key);
      if (addressList
          .where((v) =>
              v.address!.toLowerCase() == address!.address!.toLowerCase())
          .isNotEmpty) {
      } else {
        await DbHelper.instance.unSelectWallet(selectedAddress.value.id!);
        selectedAddress.value = address!;
        addressList.add(address);
        importAddressMnemonicController.clear();
        Get.back();

        await DbHelper.instance.addAddress(address);
        await DbHelper.instance.changeWallet(address.id!);
        changeAddress(address);
        decrypted(
          selectedAddress.value.privateKey!,
        );

        // await fetchTokenByAddress();
        await getMultipleTokenBalances();
        // await getTokenFromContract();
        await getBalance();
      }
    } else {}
    isLoadingImportMnemonic.value = false;
  }

  Future<void> importAddressByPrivatekey(String key) async {
    isLoadingImportPrivateKey.value = true;

    try {
      final isValid = WalletHelper().validatePrivateKey(key);

      if (isValid) {
        final credentials = EthPrivateKey.fromHex(key);
        final privatekeyEncrypted = Ecryption().encrypt(key);
        if (addressList
            .where((v) => v.address == credentials.address.hex)
            .isNotEmpty) {
        } else {
          await DbHelper.instance.unSelectWallet(selectedAddress.value.id!);

          Address addressNew = Address(
              name: "Account",
              address: credentials.address.hex,
              mnemonic: null,
              balance: 0,
              selectedAddress: true,
              privateKey: privatekeyEncrypted);

          selectedAddress.value = addressNew;
          addressList.add(addressNew);
          importAddressPrivateKeyController.clear();
          Get.back();

          await DbHelper.instance.addAddress(addressNew);
          await DbHelper.instance.changeWallet(addressNew.id!);
          changeAddress(addressNew);
          decrypted(
            selectedAddress.value.privateKey!,
          );

          // await fetchTokenByAddress();
          await getMultipleTokenBalances();
          // await getTokenFromContract();
          await getBalance();
        }
      } else {}
    } catch (e) {
      throw Exception(e.toString());
    }

    isLoadingImportPrivateKey.value = false;
  }

  /// #######################################
  /// ############### TOKEN ###############
  /// #######################################
  RxList<Token> tokenList = <Token>[].obs;
  RxList<SelectedToken> tokenSelected = <SelectedToken>[].obs;

  TextEditingController searchTokenController = TextEditingController();

  Future<void> initialzedToken() async {
    tokenList.clear();
    tokenSelected.clear();
    final listTokens = await DbHelper.instance.getAllTokens();
    if (listTokens.isEmpty) {
      final tokens = await rootBundle.loadString('asset/abi/token.json');
      dev.log(tokens);
      final listToken = tokenFromJson(tokens);

      await DbHelper.instance.setAllToken(listToken);
      final tokenByChain = await DbHelper.instance
          .getListTokenByChainId(chainId: selectedChain.value.chainId ?? "");
      tokenList.assignAll(tokenByChain);
      final selectedToken = await DbHelper.instance.getSelectedToken(
        walletAddress: selectedAddress.value.address ?? "",
        chainID: selectedChain.value.chainId ?? "",
      );
      tokenSelected.assignAll(selectedToken);
    } else {
      final tokenByChain = await DbHelper.instance
          .getListTokenByChainId(chainId: selectedChain.value.chainId ?? "");
      tokenList.assignAll(tokenByChain);
      final token = await DbHelper.instance.getSelectedToken(
        walletAddress: selectedAddress.value.address ?? "",
        chainID: selectedChain.value.chainId ?? "",
      );
      tokenSelected.assignAll(token);
    }

    tokenSelected.refresh();
    tokenList.refresh();
  }

  Future<void> getMultipleTokenBalances() async {
    if (tokenSelected.isNotEmpty) {
      for (final tokenAddress in tokenSelected) {
        if (tokenAddress.contractAddress != null &&
            tokenAddress.chainId == selectedChain.value.chainId) {
          final token = ERC20(
              client: web3client!,
              address: EthereumAddress.fromHex(tokenAddress.contractAddress!));

          final balance = await token.balanceOf(
              EthereumAddress.fromHex(selectedAddress.value.address!));
          final tokenBalance = EtherAmount.fromUnitAndValue(
            EtherUnit.wei,
            balance,
          );

          tokenAddress.balance = (tokenBalance.getInWei /
              BigInt.from(pow(10, tokenAddress.decimal!)));

          dev.log(
              "TOKEN ==>Balance ${tokenAddress.name} BALANCE : $balance Address : ${selectedAddress.value.address!}");
        }
        tokenSelected.refresh();
      }
    }
  }

  // Future<void> resetWallet() async {
  //   await DbHelper.instance.resetWallet();
  //   Get.offAll(() => OnboardingScreen());
  // }

  Future<String?> transferToken(
      {required String contractAddress,
      required String to,
      required double amount,
      required SelectedToken token}) async {
    dev.log("Transfer Token => $contractAddress");

    final contract =
        DeployedContract(erc20Abi!, EthereumAddress.fromHex(contractAddress));
    var credentials = EthPrivateKey.fromHex(selectedPrivateKey.value);
    dev.log(credentials.address.toString());
    final map = {
      'contract': token.contractAddress,
      'to': to,
      'amount': amount,
    };

    dev.log("Transfer Token => $map");

    final value = BigInt.from(amount * pow(10, token.decimal!));
    dev.log("ChainId : ${selectedChain.value.chainId!}");

    try {
      final transaction = Transaction.callContract(
        contract: contract,
        from: credentials.address,
        function: contract.function('transfer'),
        parameters: <dynamic>[
          EthereumAddress.fromHex(to),
          value,
        ],
      );

      final response = await web3client!.sendTransaction(
          credentials, transaction,
          chainId: int.parse(selectedChain.value.chainId!));
      dev.log("CONTRACT ADDRESS : $contractAddress");

      dev.log("Transfer Token Result : $response");
      Get.snackbar("Transaction Submitted", "Waiting for confirmation",
          backgroundColor: AppColor.primaryColor, colorText: AppColor.textDark);

      Get.close(3);

      return response;
    } catch (e) {
      dev.log("Error Transfer Token=> $e");
      Get.snackbar("Error", "$e",
          backgroundColor: AppColor.redColor, colorText: AppColor.textDark);

      return null;
    }
  }

  Future<double> getEstimateGasFee(
      {required String to, required double amount}) async {
    final Credentials credentials =
        EthPrivateKey.fromHex(selectedPrivateKey.value);
    BigInt gweiBigInt = (BigInt.from(amount * 1000000000) ~/ BigInt.one);
    try {
      EtherAmount gasprice = await web3client!.getGasPrice();

      final gaslimit = await web3client!.estimateGas(
        to: EthereumAddress.fromHex(to),
        sender: credentials.address,
        value: EtherAmount.fromUnitAndValue(EtherUnit.gwei, gweiBigInt),
        gasPrice: gasprice,
      );

      gasLimit.value = gaslimit.toDouble();
      gasPrice.value =
          (gasprice.getInWei / BigInt.from(pow(10, 18))).ceilToDouble();

      final txFee = gasprice.getInWei * gaslimit;

      // var etherAmount = estimateGas / BigInt.from(10).pow(8);

      return txFee / BigInt.from(10).pow(18);
    } catch (e) {
      return 0.0;
    }
  }

  Future<double> getEstimateGasTokenTransfer({
    required String contractAddress,
    required String to,
    required double amount,
    required int decimal,
  }) async {
    final credentials = EthPrivateKey.fromHex(selectedPrivateKey.value);

    final contract =
        DeployedContract(erc20Abi!, EthereumAddress.fromHex(contractAddress));

    final fromAddress = credentials.address;

    final gasPrice = await web3client!.getGasPrice();
    final transferFunction = contract.function('transfer');
    final transferParams = [EthereumAddress.fromHex(to), BigInt.from(0)];
    final transferData = transferFunction.encodeCall(transferParams);

    final gasLimit = await web3client!.estimateGas(
      data: transferData,
      gasPrice: gasPrice,
      to: EthereumAddress.fromHex(to),
      sender: fromAddress,
      value: EtherAmount.zero(),
    );

    final txFee = gasPrice.getInWei * gasLimit;
    final fee = txFee / BigInt.from(10).pow(18);
    dev.log('Gas fee estimate: $fee wei');
    return fee;
  }

  Future<String?> sendEth(
      {required String to, required double amount, double? gasPrice}) async {
    final Credentials credentials =
        EthPrivateKey.fromHex(selectedPrivateKey.value);
    final toAddress = EthereumAddress.fromHex(to);

    try {
      /// CONVERT GWEI TO ETHER
      BigInt gweiBigInt = convertToGwei(amount);
      dev.log("Send gas Fee => $gasPrice");

      /// SEND TRANSACTION
      final transaction = Transaction(
          from: credentials.address,
          to: toAddress,
          gasPrice: gasPrice == null
              ? null
              : EtherAmount.fromUnitAndValue(EtherUnit.ether, gasPrice),
          value: EtherAmount.fromUnitAndValue(EtherUnit.gwei, gweiBigInt));
      dev.log("Send transaction => $transaction");
      final response = await web3client!.sendTransaction(
        credentials,
        transaction,
        chainId: int.parse(selectedChain.value.chainId ?? "1"),
      );
      dev.log("Send response => $response");

      Get.snackbar("Transaction Submitted", "Waiting for confirmation",
          backgroundColor: AppColor.primaryColor, colorText: AppColor.textDark);

      Get.close(3);
      BottomNavBarController navBarController = Get.find();
      navBarController.changeIndexBar(1);
      return response;
    } catch (e) {
      dev.log("Send error => $e");

      Get.snackbar("Error", "$e",
          backgroundColor: AppColor.redColor, colorText: AppColor.textDark);

      return null;
    }
  }

  BigInt convertToGwei(double amount) {
    BigInt gweiBigInt = (BigInt.from(amount * 1000000000) ~/ BigInt.one);
    dev.log("$gweiBigInt GWEI EQUAL $amount ETHER");
    return gweiBigInt;
  }

  //// ##############
  /// SETTING
  /// ###############

  openExplorer() async {
    final url = selectedChain.value.explorer;
    ChromeSafariBrowser browser = ChromeSafariBrowser();
    await browser.open(
        url: Uri.parse("$url/address/${selectedAddress.value.address}"));
  }

  var isLoading = false.obs;
  var listActivity = <Activity>[].obs;
  var selectedTabActivity = 0.obs;
  var page = 1.obs;

  void changeActivity(int index) => selectedTabActivity.value = index;

  Future<void> findAllActivity({bool isRefresh = false}) async {
    isLoading.value = true;
    ActivityRepository activityRepository = ActivityRepository();

    final response = await activityRepository.findAllActivity(
        page: isRefresh ? 1 : page.value,
        selectedAddress.value.address ?? "",
        isTestnet: selectedChain.value.isTestnet ?? false);
    dev.log("RESPONSE LENGTH : $response");
    final tokenResponse = await activityRepository.findActivityToken(
        selectedAddress.value.address ?? "",
        page: page.value,
        isTestnet: selectedChain.value.isTestnet!);

    for (var element in tokenResponse) {
      dev.log("Token name  : ${element.name}");
    }

    if (isRefresh) {
      page.value = 1;
      listActivity.clear();
    }

    listActivity.addAll(response);
    listActivity.addAll(tokenResponse);
    dev.log("List Activity : $listActivity");
    dev.log("List Activity : ${page.value}");

    listActivity.refresh();
    isLoading.value = false;
  }

  //// ##############
  /// NFT
  /// ###############
  var listNFT = <Nft>[].obs;
  var listUniqueNft = <NftView>[].obs;

  initializeNFt() async {
    listNFT.clear();
    listUniqueNft.clear();
    final nfts = await DbHelper.instance.getAllNFT(
        owner: selectedAddress.value.address ?? "",
        chainId: selectedChain.value.chainId ?? "");
    listNFT.assignAll(nfts);
    var unique = removeDuplicates(nfts);
    listUniqueNft.assignAll(unique);
  }

  List<NftView> removeDuplicates(List<Nft> list) {
    Set<String> seen = {};
    List<String> itemContract = [];
    List<NftView> nftView = [];
    for (var item in list) {
      if (!seen.contains(item.contractAddress)) {
        itemContract.add(item.contractAddress!);
        seen.add(item.contractAddress!);
      }
    }
    dev.log(itemContract.toString());
    for (var item in itemContract) {
      var nftByContract =
          list.where((element) => element.contractAddress == item).toList();
      nftView.add(NftView(
        contract: item,
        name: nftByContract.first.name,
        length: nftByContract.length,
        chainID: nftByContract.first.chainId,
        image: nftByContract.first.imageByte ?? '',
        listNft: nftByContract,
      ));
    }
    for (var element in nftView) {
      dev.log(element.contract!);
      dev.log(element.name!);
      dev.log(element.length.toString());
    }
    return nftView;
  }
}

Future<Address?> importMnemonic(String mnemonic) async {
  // await db.setPassword(Password(password: password));

  var account = WalletHelper().getAccountInfo(mnemonic);
  final mnemonicEncrypted = Ecryption().encrypt(
    mnemonic,
  );
  final privateKeyEncrypted = Ecryption().encrypt(account['private_key']!);

  Address address = Address(
      name: "Account",
      address: account['address'],
      mnemonic: mnemonicEncrypted,
      balance: 0,
      selectedAddress: true,
      privateKey: privateKeyEncrypted);
  dev.log(address.address.toString());
  dev.log(address.mnemonic.toString());
  dev.log(address.privateKey.toString());

  // await db.addAddress(address);

  // Get.offAll(() => MainPage(address: address));
  return address;

  //// ##############
  /// SETTING
  /// ###############
  ///
  ///
}
