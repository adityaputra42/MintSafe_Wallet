import 'dart:async';
import 'dart:developer' as dev;
import 'dart:math';

import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:erc20/erc20.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
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
  var gasLimit = 0.0.obs;
  var gasPrice = 0.0.obs;

  var selectedChain = ChainNetwork().obs;

  EvmNewController(this.initAddress);

  void initialize() async {
    // INIT NETWORK
    await networkController.initialzedNetwork();

    /// INIT RPC
    initWeb3RPC();

    /// INIT CONTRACT
    final erc20AbiString = await rootBundle.loadString('asset/abi/ERC-2O.json');
    final tokenRegistryAbiString =
        await rootBundle.loadString('asset/abi/token_registry.json');
    erc20Abi = ContractAbi.fromJson(erc20AbiString, 'ERC20');

    tokenRegistryAbi =
        ContractAbi.fromJson(tokenRegistryAbiString, "TokenRegistry");

    /// INIT ACCOUNT
    await initAccount();
    decrypted(
      selectedAddress.value.privateKey!,
    );

    // INIT TOKEN
    await initializeTokens();
    await getTokenFromContract();
    await fetchTokenByAddress();

    /// GET BALANCE
    if (await ConnectivityWrapper.instance.isConnected) {
      await getBalance();
      await getMultipleTokenBalances();
      getEthBalancePeriodic();
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
    // Get.back();
    // isLoadingNetwork.value = true;
    // networkController.changeNetwork(network);
    // initWeb3RPC();

    // if (Get.isRegistered<ActivityTxController>()) {
    //   Get.delete<ActivityTxController>();
    // }
    // await getBalance();
    // isLoadingNetwork.value = false;

    // await getMultipleTokenBalances();
    var httpClient = Client();
    Get.back();

    // await DbHelper.instance.unSelectNetwork(selectedChain.value.id!);
    networkController.changeNetwork(network);
    selectedChain.value = network;
    selectedChain.refresh();

    isLoadingNetwork.value = true;

    web3client = Web3Client(
      selectedChain.value.rpc ?? "",
      httpClient,
    );

    await getBalance();
    await getTokenFromContract();
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
  late Timer _timer;
  var isLoadingImportAccount = false.obs;
  var isLoadingCreateAccount = false.obs;

  var importAddressInputController = TextEditingController();

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
  }

  decrypted(
    String pk,
  ) {
    print("SELECTED ADDRESS : ${selectedAddress.value.address}");
    print("SELECTED ADDRESS PK : ${selectedAddress.value.privateKey}");
    // print("SELECTED MNEMONIC  : ${selectedAddress.value.mnemonic}");

    final privateKey = encrypter.decrypt64(pk, iv: iv);
    print("PRIVATE KEY : $privateKey");
    // final mnmemonic = encrypter.decrypt64(seed, iv: iv);

    selectedPrivateKey.value = privateKey;
    // selectedMnemonic.value = mnmemonic;
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
    _timer = Timer.periodic(const Duration(seconds: 15), (timer) {
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
    await getTokenFromContract();
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
    isLoadingCreateAccount.value = true;
    final mnemonic = WalletRepository().generateMnemonic();
    var account = WalletRepository().getAccountInfo(mnemonic);
    await DbHelper.instance.unSelectWallet(selectedAddress.value.id!);
    final mnemonicEncrypt = encrypter.encrypt(account['mnemonic']!, iv: iv);
    final privateKeyEncrypt =
        encrypter.encrypt(account['private_key']!, iv: iv);
    Address addressNew = Address(
        name: "Account",
        address: account['address'],
        mnemonic: mnemonicEncrypt.base64.toString(),
        balance: 0,
        selectedAddress: true,
        privateKey: privateKeyEncrypt.base64.toString());

    selectedAddress.value = addressNew;
    addressList.add(addressNew);
    Get.back();

    await DbHelper.instance.addAddress(addressNew);
    await DbHelper.instance.changeWallet(addressNew.id!);
    changeAddress(addressNew);
    decrypted(
      selectedAddress.value.privateKey!,
    );
    await getTokenFromContract();
    isLoadingCreateAccount.value = false;
    await getBalance();

    final listAddress = await DbHelper.instance.readAddressList();
    listAddress!.forEach((element) {
      print(element.name);
      print(element.address);
    });
  }

  /// IMPORT ADDRESS FROM MNEMONIC OR PRIVATE KEY
  Future<void> importAddress(String key) async {
    isLoadingImportAccount.value = true;

    if (WalletRepository().validateMnemonic(key)) {
      var address = await compute(importMnemonic, key);
      if (addressList
          .where((v) =>
              v.address!.toLowerCase() == address!.address!.toLowerCase())
          .isNotEmpty) {
       
      } else {
        await DbHelper.instance.unSelectWallet(selectedAddress.value.id!);
        selectedAddress.value = address!;
        addressList.add(address!);
        importAddressInputController.clear();
        Get.back();

        await DbHelper.instance.addAddress(address);
        await DbHelper.instance.changeWallet(address.id!);
        changeAddress(address);
        decrypted(
          selectedAddress.value.privateKey!,
        );

        await fetchTokenByAddress();
        await getMultipleTokenBalances();
        await getTokenFromContract();
        await getBalance();
      }
    } else {
      try {
        final isValid = WalletRepository().validatePrivateKey(key);

        if (isValid) {
          final credentials = EthPrivateKey.fromHex(key);
          final privatekeyEncrypted = encrypter.encrypt(key, iv: iv);
          if (addressList
              .where((v) => v.address == credentials.address.hex)
              .isNotEmpty) {
           
          } else {
            await DbHelper.instance.unSelectWallet(selectedAddress.value.id!);

            print("Private Key : $key");
            // print("privateKey encrypted : $privateKeySelected");
            Address addressNew = Address(
                name: "Account",
                address: credentials.address.hex,
                mnemonic: null,
                balance: 0,
                selectedAddress: true,
                privateKey: privatekeyEncrypted.base64.toString());

            selectedAddress.value = addressNew;
            addressList.add(addressNew);
            importAddressInputController.clear();
            Get.back();

            await DbHelper.instance.addAddress(addressNew);
            await DbHelper.instance.changeWallet(addressNew.id!);
            changeAddress(addressNew);
            decrypted(
              selectedAddress.value.privateKey!,
            );

            await fetchTokenByAddress();
            await getMultipleTokenBalances();
            await getTokenFromContract();
            await getBalance();
          }
        } else {
        }
      } catch (e) {throw Exception(e.toString());
      }
    }
    isLoadingImportAccount.value = false;
  }

  /// #######################################
  /// ############### TOKEN ###############
  /// #######################################
  RxList<Result> tokenList = <Result>[].obs;
  RxList<Result> tokenRegistryAll = <Result>[].obs;

  initializeTokens() async {
    final tokens = await DbHelper.instance.getAllToken();
    tokenList.clear();

    tokenList.addAll(tokens);

    refresh();
  }

  Future<void> fetchTokenByAddress() async {
    try {
      TokenRepository tokenRepository = TokenRepository();
      // await getTokenFromContract();
      dev.log("TOKENBYADDRESS");
      final response =
          await tokenRepository.getToken(selectedAddress.value.address!);

      dev.log("TOKENBYADDRESS : ${response.result!.length}");

      final List<Result> tokensByAddress = response.result ?? [];

      for (var element in tokensByAddress) {
        element.addressWallet = selectedAddress.value.address;
        element.chainId = networkController.selectedChain.value.chainId;
        element.selected = true;
        if (tokenRegistryAll
            .any((x) => x.contractAddress == element.contractAddress)) {
          element.image = tokenRegistryAll
              .singleWhere((y) => y.contractAddress == element.contractAddress)
              .image;
        }
      }

      tokensByAddress.removeWhere(
          (element) => element.type == "ERC-721" || element.type == "ERC-1155");

      dev.log("TOKENBYADDRESS TOKENLIST : ${tokenList.length}");
      tokensByAddress.forEach((element) async {
        dev.log("TOKENBYADDRESS SC  : ${element.contractAddress}");
        dev.log("TOKENBYADDRESS ADD WALL  : ${element.addressWallet}");
        dev.log("TOKENBYADDRESS SELECTED  : ${element.selected}");

        dev.log(
            "MASUK MASRBOOOO ${element.type != "ERC-1155" || element.type != "ERC-721"}");

        if (!tokenList.any((x) =>
            x.contractAddress == element.contractAddress &&
            x.addressWallet == selectedAddress.value.address)) {
          dev.log("TOKENBYADDRESS MASUK YGY");

          await DbHelper.instance.addToken(element.copyWith(
            selected: true,
            addressWallet: selectedAddress.value.address,
          ));
        }
      });

      dev.log("TOKENBYADDRESS : ${tokensByAddress.length}");
    } catch (e) {}
  }

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
        final tokenBalance = EtherAmount.fromUnitAndValue(
          EtherUnit.wei,
          balance,
        );

        tokenAddress.balance = (tokenBalance.getInWei /
            BigInt.from(pow(10, tokenAddress.decimals!)));

        print(
            "TOKEN ${tokenAddress.name} BALANCE : $balance Address : ${selectedAddress.value.address!}");
      }

      tokenList.refresh();
    }
  }

  Future<void> getTokenFromContract() async {
    // BETH

    final contract = DeployedContract(
        tokenRegistryAbi!,
        EthereumAddress.fromHex(networkController.selectedChain.value.tokenRegistry!));
    // final contract = DeployedContract(
    //     tokenRegistryAbi!,
    //     networkController.selectedChain.value.id == 1
    //         ? EthereumAddress.fromHex(
    //             "0xD432387df174a54489Ad6204A1400C97fF5545ef")
    //         : EthereumAddress.fromHex(
    //             "0x75AA2613E4102104682b8cC7C221692083131C72"));

    // BASE
    // final contract = DeployedContract(tokenRegistryAbi!,
    //     EthereumAddress.fromHex("0xdc198d1f11f5B5b7e7B10A657d44497236FEe9E8"));

    final query = contract.function('getTokenList');

    final List<dynamic> result = await web3client!.call(
      contract: contract,
      function: query,
      params: [],
    );

    dev.log("KANJUD : ${result}");

    var tokek = <Result>[];

    result.forEach((element) {
      if (element is List) {
        element.forEach((item) {
          dev.log("KONT : ${item}");

          final token = Result(
              addressWallet: selectedAddress.value.address,
              chainId: networkController.selectedChain.value.chainId,
              balance: 0,
              selected: false,
              contractAddress: item[0].toString(),
              name: item[1],
              symbol: item[2],
              decimals: item[3].toInt(),
              image: item[4]);
          tokek.add(token);
        });
      }
    });

    tokenRegistryAll.assignAll(tokek);

    tokenList.forEach((element) {
      final a = tokenRegistryAll.singleWhere(
        (tokek) =>
            element.contractAddress!.toLowerCase() ==
            tokek.contractAddress!.toLowerCase(),
        orElse: () => Result(),
      );
      if (a.contractAddress == null) {
        tokenRegistryAll.add(element);
      }
    });

    tokenRegistryAll.refresh();

    dev.log("Result tokek : ${tokenRegistryAll.length}");
  }

  // Future<void> resetWallet() async {
  //   await DbHelper.instance.resetWallet();
  //   Get.offAll(() => const OnBoardingPage());
  // }

  Future<String?> transferToken(
      {required String contractAddress,
      required String to,
      required double amount,
      required Result token}) async {
    final contract =
        DeployedContract(erc20Abi!, EthereumAddress.fromHex(contractAddress));
    var credentials = EthPrivateKey.fromHex(selectedPrivateKey.value);

    final map = {
      'contract': token.contractAddress,
      'to': to,
      'amount': amount,
    };

    dev.log(map.toString());

    final value = BigInt.from(amount * pow(10, token.decimals!));

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
      print("CONTRACT ADDRESS : $contractAddress");
      // await getHistory(response,
      //     contractAddress: token.contractAddress,
      //     value: amount,
      //     to: to,
      //     isContractInteraction: false);
      print("Transfer Token Result : $response");

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
    print('Gas fee estimate: $fee wei');
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
  final mnemonicEncrypted = encrypter.encrypt(mnemonic, iv: iv);
  final privateKeyEncrypted =
      encrypter.encrypt(account['private_key']!, iv: iv);

  Address address = Address(
      name: "Account",
      address: account['address'],
      mnemonic: mnemonicEncrypted.base64.toString(),
      balance: 0,
      selectedAddress: true,
      privateKey: privateKeyEncrypted.base64.toString());
  print(address.address);
  print(address.mnemonic);
  print(address.privateKey);

  // await DbHelper.instance.addAddress(address);

  // Get.offAll(() => MainPage(address: address));
  return address;
}
