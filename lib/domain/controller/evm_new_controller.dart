// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:erc20/erc20.dart';
import 'package:eth_abi_codec/eth_abi_codec.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/data/model/token/selected_token.dart';
import 'package:web3dart/web3dart.dart';

import '../../data/data.dart';
import '../../utils/utils.dart';
import '../repository/repository.dart';
import 'activity_tx_controller.dart';
import 'network_controller.dart';

class EvmNewController extends GetxController {
  /// #######################################
  /// ############### HOME STATE ###############
  /// #######################################

  final Address initAddress;
  Web3Client? web3client;
  ContractAbi? erc20Abi;
  late ContractABI abi;
  var gasLimit = 0.0.obs;
  var gasPrice = 0.0.obs;

  var selectedChain = ChainNetwork().obs;
  EvmNewController(this.initAddress);

  void initialize() async {
    // INIT NETWORK
    isLoadingNetwork.value = true;
    await networkController.initialzedNetwork();

    /// INIT RPC
    initWeb3RPC();

    /// INIT CONTRACT
    final jsonString = await rootBundle.loadString('asset/abi/erc_20.json');
    erc20Abi = ContractAbi.fromJson(jsonString, 'ERC20');
    abi = ContractABI.fromJson(jsonDecode(jsonString));

    /// INIT ACCOUNT
    await initAccount();

    // INIT TOKEN
    //
    await initialzedToken();
    // await getTokenFromContract();
    // await fetchTokenByAddress();
    isLoadingNetwork.value = false;

    /// GET BALANCE
    if (await ConnectivityWrapper.instance.isConnected) {
      // await getBalance();
      // await getMultipleTokenBalances();
      // getEthBalancePeriodic();
    }
  }

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  /// #######################################
  /// ############### WEB3 RPC ###############
  /// #######################################
  void initWeb3RPC() {
    dev.log("RPC : ${networkController.selectedChain.value.rpc}");
    var httpClient = Client();
    web3client = Web3Client(
      networkController.selectedChain.value.rpc ?? "",
      httpClient,
    );
  }

  /// #######################################
  /// ############### NETWORK ###############
  /// #######################################
  ///
  NetworkController networkController = Get.put(NetworkController());
  var isLoadingNetwork = false.obs;
  void changeNetwork(ChainNetwork network) async {
    var httpClient = Client();
    Get.back();
    networkController.changeNetwork(network);
    selectedChain.value = network;
    selectedChain.refresh();

    isLoadingNetwork.value = true;

    web3client = Web3Client(
      selectedChain.value.rpc ?? "",
      httpClient,
    );

    await getBalance();
    await initialzedToken();
    if (Get.isRegistered<ActivityTxController>()) {
      Get.delete<ActivityTxController>();
    }
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
  var isLoadingImportMnemonic = false.obs;
  var isLoadingImportPrivateKey = false.obs;
  var isLoadingCreateAccount = false.obs;

  var importAddressMnemonicController = TextEditingController();
  var passwordCreateAccountController = TextEditingController();
  var importAddressPrivateKeyController = TextEditingController();

  Future<void> initAccount() async {
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

    dev.log("Selected Address init ==> ${selectedAddress.value.address}");
    decrypted(
      selectedAddress.value.privateKey ?? "",
    );
  }

  decrypted(String pk) {
    final privateKey = Ecryption().decrypt(pk);
    selectedPrivateKey.value = privateKey;
  }

  Future<void> getBalance() async {
    // var credentials = EthPrivateKey.fromHex(privateKey);
    // var address = credentials.address;
    prefBalance.value = selectedAddress.value.balance!;
    for (var add in addressList) {
      try {
        if (await ConnectivityWrapper.instance.isConnected) {
          EtherAmount balance = await web3client!
              .getBalance(EthereumAddress.fromHex(add.address!));

          double balanceParsed = double.parse(
              balance.getValueInUnit(EtherUnit.ether).toStringAsPrecision(8));
          add.balance = balanceParsed;
          await DbHelper.instance.updateWallet(add.id!, balanceParsed);
          if (add.address == selectedAddress.value.address) {
            selectedAddress.value.balance = balanceParsed;
            selectedAddress.refresh();
          }
        }

        print("ON");

        balanceEth.value = selectedAddress.value.balance!;
        dev.log("KANJUD : ${balanceEth.value}");
      } catch (e) {
        print(e.toString());
      }

      // selectedAddress.value.balance = balanceEth.value;
      // selectedAddress.refresh();
    }

    balanceEth.value = selectedAddress.value.balance!;

    addressList.refresh();

    if (selectedAddress.value.balance! > 0 &&
        prefBalance.value != selectedAddress.value.balance) {
      print("============History Update============>");
      // findAllActivity();
    }
    print("=========PrevBalance=========>");
    print(prefBalance.value);
    print("=========new Balance=========>");
    print(selectedAddress.value.balance!);
    // print("GET BALANCE : ADDRESS LIST = ${selectedAddress.value.balance!}");
  }

  void getEthBalancePeriodic() {
    timer = Timer.periodic(const Duration(seconds: 15), (timer) {
      getBalance();

      // getMultipleTokenBalances();
    });
  }

  void changeAddress(Address address) async {
    print("SELECTED WALLET ADDRESS : ${selectedAddress.value.id}");
    await DbHelper.instance.unSelectWallet(selectedAddress.value.id!);
    dev.log("INIT ADDRESS : ${selectedAddress.value.id!}");

    selectedAddress.value = address;
    selectedAddress.refresh();

    await DbHelper.instance.changeWallet(address.id!);
    // await getTokenFromContract();
    dev.log("NEW ADDRESS : ${address.id!}");

    decrypted(
      selectedAddress.value.privateKey!,
    );
    Get.back();

    if (await ConnectivityWrapper.instance.isConnected) {
      await getBalance();
      await getMultipleTokenBalances();
      if (Get.isRegistered<ActivityTxController>()) {
        Get.delete<ActivityTxController>();
      }
    }
    decrypted(selectedAddress.value.privateKey!);
    anotherAddressList.clear();
    anotherAddressList.assignAll(
        addressList.where((e) => e.address != address.address).toList());
    anotherAddressList.refresh();
    // final listAddress = await DbHelper.instance.readAddressList();
    // listAddress!.forEach((element) {
    //   print(element.name);
    //   print(element.address);
    // });
  }

  Future<void> createNewAddress() async {
    var password = await DbHelper.instance.getPassword();
    if (passwordCreateAccountController.text == password.password) {
      isLoadingCreateAccount.value = true;
      final mnemonic = WalletRepository().generateMnemonic();
      var account = WalletRepository().getAccountInfo(mnemonic);
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

      Get.close(3);
      await DbHelper.instance.addAddress(addressNew);
      await DbHelper.instance.changeWallet(addressNew.id!);
      changeAddress(addressNew);
      decrypted(
        selectedAddress.value.privateKey!,
      );

      isLoadingCreateAccount.value = false;
      await getBalance();

      final listAddress = await DbHelper.instance.readAddressList();
      for (var element in listAddress!) {
        dev.log("${element.name}");
        dev.log("${element.address}");
      }
    } else {
      Get.snackbar("Failed", "Password didn't match!",
          backgroundColor: AppColor.redColor, colorText: Colors.white);
      passwordCreateAccountController.clear();
    }
  }

  /// IMPORT ADDRESS FROM MNEMONIC OR PRIVATE KEY
  Future<void> importAddressByMnemonic(String key) async {
    isLoadingImportMnemonic.value = true;

    if (WalletRepository().validateMnemonic(key)) {
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
      final isValid = WalletRepository().validatePrivateKey(key);

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

  getTokens() async {
    final tokens = await DbHelper.instance.getAllTokens();
    tokenList.clear();
    tokenList.addAll(tokens);
    refresh();
  }
  // initializeTokens() async {
  //   final tokens = await DbHelper.instance.getAllToken();
  //   tokenList.clear();

  //   tokenList.addAll(tokens);

  //   refresh();
//   // }
// var listToken = <Token>[].obs;

  Future<void> initialzedToken() async {
    tokenList.clear();
    tokenSelected.clear();
    final listTokens = await DbHelper.instance.getAllTokens();

    if (listTokens.isEmpty) {
      final tokens = await rootBundle.loadString('asset/abi/token.json');
      dev.log(tokens);
      final listToken = tokenFromJson(tokens);

      await DbHelper.instance.setToken(listToken);
      final tokenByChain = await DbHelper.instance.getListTokenByChainId(
          chainId: networkController.selectedChain.value.chainId ?? "");
      tokenList.assignAll(tokenByChain);
      final selectedToken = await DbHelper.instance.getSelectedToken(
        walletAddress: selectedAddress.value.address ?? "",
        chainID: networkController.selectedChain.value.chainId ?? "",
      );
      tokenSelected.assignAll(selectedToken);
    } else {
      final tokenByChain = await DbHelper.instance.getListTokenByChainId(
          chainId: networkController.selectedChain.value.chainId ?? "");
      tokenList.assignAll(tokenByChain);
      final token = await DbHelper.instance.getSelectedToken(
        walletAddress: selectedAddress.value.address ?? "",
        chainID: networkController.selectedChain.value.chainId ?? "",
      );
      tokenSelected.assignAll(token);
    }

    tokenSelected.refresh();
    tokenList.refresh();
  }

  // Future<void> fetchTokenByAddress() async {
  //   try {
  //     TokenRepository tokenRepository = TokenRepository();
  //     // await getTokenFromContract();
  //     dev.log("TOKENBYADDRESS");
  //     final response =
  //         await tokenRepository.getToken(selectedAddress.value.address!);

  //     dev.log("TOKENBYADDRESS : ${response.result!.length}");

  //     final List<Result> tokensByAddress = response.result ?? [];

  //     for (var element in tokensByAddress) {
  //       element.addressWallet = selectedAddress.value.address;
  //       element.chainId = networkController.selectedChain.value.chainId;
  //       element.selected = true;
  //       if (tokenRegistryAll
  //           .any((x) => x.contractAddress == element.contractAddress)) {
  //         element.image = tokenRegistryAll
  //             .singleWhere((y) => y.contractAddress == element.contractAddress)
  //             .image;
  //       }
  //     }

  //     tokensByAddress.removeWhere(
  //         (element) => element.type == "ERC-721" || element.type == "ERC-1155");

  //     dev.log("TOKENBYADDRESS TOKENLIST : ${tokenList.length}");
  //     tokensByAddress.forEach((element) async {
  //       dev.log("TOKENBYADDRESS SC  : ${element.contractAddress}");
  //       dev.log("TOKENBYADDRESS ADD WALL  : ${element.addressWallet}");
  //       dev.log("TOKENBYADDRESS SELECTED  : ${element.selected}");

  //       dev.log(
  //           "MASUK MASRBOOOO ${element.type != "ERC-1155" || element.type != "ERC-721"}");

  //       if (!tokenList.any((x) =>
  //           x.contractAddress == element.contractAddress &&
  //           x.addressWallet == selectedAddress.value.address)) {
  //         dev.log("TOKENBYADDRESS MASUK YGY");

  //         await DbHelper.instance.addToken(element.copyWith(
  //           selected: true,
  //           addressWallet: selectedAddress.value.address,
  //         ));
  //       }
  //     });

  //     dev.log("TOKENBYADDRESS : ${tokensByAddress.length}");
  //   } catch (e) {}
  // }

  Future<void> getMultipleTokenBalances() async {
    for (final tokenAddress in tokenList) {
      if (tokenAddress.contractAddress != null &&
          tokenAddress.chainId ==
              networkController.selectedChain.value.chainId) {
        final token = ERC20(
            client: web3client!,
            address: EthereumAddress.fromHex(tokenAddress.contractAddress!));

        final balance = await token
            .balanceOf(EthereumAddress.fromHex(selectedAddress.value.address!));
        final tokenBalance = EtherAmount.fromBigInt(
          EtherUnit.wei,
          balance,
        );

        tokenAddress.balance = (tokenBalance.getInWei /
            BigInt.from(pow(10, tokenAddress.decimal!)));

        print(
            "TOKEN ${tokenAddress.name} BALANCE : $balance Address : ${selectedAddress.value.address!}");
      }

      tokenList.refresh();
    }
  }

  Future<String?> transferToken(
      {required String contractAddress,
      required String to,
      required double amount,
      required SelectedToken token}) async {
    final contract =
        DeployedContract(erc20Abi!, EthereumAddress.fromHex(contractAddress));
    var credentials = EthPrivateKey.fromHex(selectedPrivateKey.value);

    final map = {
      'contract': token.contractAddress,
      'to': to,
      'amount': amount,
    };
    dev.log(map.toString());
    final value = BigInt.from(amount * pow(10, token.decimal!));
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
      return response;
    } catch (e) {
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
        chainId:
            int.parse(networkController.selectedChain.value.chainId ?? "1"),
      );
      dev.log("Send response => $response");
      // await Future.delayed(const Duration(seconds: 10));
      // await getHistory(response);

      /// GET TRANSACTION HASH
      // final tx = await web3client!.getTransactionByHash(response);
      // final blockInfo = await web3client!
      //     .getBlockInformation(blockNumber: tx.blockNumber.toBlockParam());

      // Map<String, String> txResult = {
      //   'blockNumber :': tx.blockNumber.blockNum.toString(),
      //   'blockHash': tx.blockHash.toString(),
      //   'from :': tx.from.hex,
      //   'to': to,
      //   'gas :': tx.gas.toString(),
      //   'gasPrice': tx.gasPrice.toString(),
      //   'hash : ': tx.hash,
      //   'value': tx.value.getInEther.toString(),
      //   'transactionIndex': tx.transactionIndex.toString(),
      //   'timestamp':
      //       DateFormat("MM-dd-yyyy hh:mm:ss").format(blockInfo.timestamp)
      // };

      // print(txResult);
      return response;
    } catch (e) {
      dev.log("Send error => $e");

      return null;
    }
  }

  BigInt convertToGwei(double amount) {
    BigInt gweiBigInt = (BigInt.from(amount * 1000000000) ~/ BigInt.one);
    print("$gweiBigInt GWEI EQUAL $amount ETHER");
    return gweiBigInt;
  }
}

Future<Address?> importMnemonic(String mnemonic) async {
  // await DbHelper.instance.setPassword(Password(password: password));

  var account = WalletRepository().getAccountInfo(mnemonic);
  final mnemonicEncrypted = Ecryption().encrypt(mnemonic);
  final privateKeyEncrypted = Ecryption().encrypt(account['private_key']!);

  Address address = Address(
      name: "Account",
      address: account['address'],
      mnemonic: mnemonicEncrypted,
      balance: 0,
      selectedAddress: true,
      privateKey: privateKeyEncrypted);
  print(address.address);
  print(address.mnemonic);
  print(address.privateKey);

  // await DbHelper.instance.addAddress(address);

  // Get.offAll(() => MainPage(address: address));
  return address;
}
