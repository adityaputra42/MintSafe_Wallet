import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:connectivity_checker/connectivity_checker.dart';
import 'package:convert/convert.dart';
import 'dart:developer' as dev;
import 'package:erc20/erc20.dart';
import 'package:eth_abi_codec/eth_abi_codec.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../../data/data.dart';
import '../../utils/utils.dart';
import '../repository/repository.dart';
import 'db_controller.dart';

class EvmController extends GetxController {
  final Address address;
  var privateKeySelected = ''.obs;
  var mnemonicSelected = ''.obs;
  EvmController({required this.address});
  DBController db = Get.find();
  var isLoading = false.obs;
  var isLoadingCreateAccount = false.obs;
  var isLoadingImportAccount = false.obs;
  // var apiUrl = "https://api.avax-test.network/ext/C/rpc".obs;

  var isImport = false.obs;
  var importPrivateKeyController = TextEditingController();
  var isLoadingNetwork = false.obs;
  var prefBalance = 0.0.obs;
  Web3Client? web3client;
  ContractAbi? erc20Abi;
  var selectedChain = ChainNetwork().obs;
  var listChain = <ChainNetwork>[].obs;
  var dappsHistory = <DappsHistory>[].obs;

  final StreamController<EtherAmount> _ethBalanceController =
      StreamController<EtherAmount>();

  var balanceEth = 0.0.obs;

  late Timer timer;
  late Timer timerCheckTx;

  RxList<Address> addressList = <Address>[].obs;
  Rx<Address> selectedAddress = Address().obs;
  RxList<Result> tokenList = <Result>[].obs;
  RxList<RecentAddress> recentAddress = <RecentAddress>[].obs;
  RxList<TransactionHistory> transactionHistory = <TransactionHistory>[].obs;

  // late IOWebSocketChannel channel;
  late URLRequest urlRequest;

  var selectedPrivateKey = "".obs;
  var selectedMnemonic = "".obs;

  late ScrollController scrollController;
  // var listActivity = <Activity>[].obs;
  var page = 1.obs;
  var isLoadMoreRunning = false.obs;
  var hasNextPage = true.obs;

  var gasLimit = 0.0.obs;
  var gasPrice = 0.0.obs;

  var selectedTabActivity = 0.obs;

  var isLoadingActivity = false.obs;
  late ContractABI abi;

  decrypted(
    String pk,
  ) {
    // print("SELECTED ADDRESS : ${selectedAddress.value.address}");
    // print("SELECTED ADDRESS PK : ${selectedAddress.value.privateKey}");
    // print("SELECTED MNEMONIC  : ${selectedAddress.value.mnemonic}");

    final privateKey =  encrypter.decrypt64(pk, iv: iv);
    print("PRIVATE KEY : $privateKey");
    // final mnmemonic = encrypter.decrypt64(seed, iv: iv);

    selectedPrivateKey.value = privateKey;
    // selectedMnemonic.value = mnmemonic;
  }

  Future<void> initialize() async {
    /// GET CONTRACT ABI
    final erc20AbiString = await rootBundle.loadString('asset/abi/ERC-2O.json');
    erc20Abi = ContractAbi.fromJson(erc20AbiString, 'ERC20');
    abi = ContractABI.fromJson(jsonDecode(erc20AbiString));

    await initialzedNetwork();

    // final addresses = await db.readAddressList();

    // addressList.clear();
    // addressList.assignAll(addresses!);

    // if (selectedAddress.value.address == null) {
    //   selectedAddress.value = address;
    // }
  }

  initialzedNetwork() async {
    /// GET LIST NETWORK
    listChain.clear();
    final networkList = await db.getAllChainNetwork();

    if (networkList.isEmpty) {
      print("NETWORK FROM JSON");
      final chainlist = await rootBundle.loadString('asset/abi/chain.json');

      listChain.value = chainNetworkFromJson(chainlist);
      listChain[0].selected = true;
      await db.setChainNetwork(listChain);

      final selectedNetwork = await db.getSelectedChainNetwork();
      if (selectedNetwork == null) {
        selectedChain.value = listChain[0];
      } else {
        selectedChain.value = selectedNetwork;
      }

      print("SET JSON TO DB");
    } else {
      print(" NETWORK FROM DB");
      var chain = await db.getSelectedChainNetwork();
      selectedChain.value = chain!;
      listChain.value = networkList;
    }

    selectedChain.refresh();
    listChain.refresh();

    listChain.forEach((element) {
      dev.log(element.name!);
    });
  }

  initializeTokens() async {
    final tokens = await db.getAllToken();
    tokenList.clear();

    tokenList.addAll(tokens);

    refresh();
  }

  initializedTxHistory() async {
    final list = await db.getAllTxHistory();
    transactionHistory.clear();
    transactionHistory.addAll(list);
    transactionHistory.refresh();
    dev.log('TX HISTORY : ${transactionHistory.length}');
    // transactionHistory.sort(
    //   (a, b) => b.date!.compareTo(a.date!),
    // );
  }

  initializedRecentAddress() async {
    final list = await db.getRecentAddress();
    recentAddress.clear();
    recentAddress.addAll(list);
    recentAddress.refresh();
  }

  @override
  void onInit() async {
    isLoadingNetwork.value = true;
    await initialize();
    await initializeTokens();
    await initializedTxHistory();
    // getDappsHistory();

    // workerCheckTx();
    // findAllActivity();

    initializedRecentAddress();
    decrypted(
      selectedAddress.value.privateKey!,
    );
    var httpClient = Client();

    // channel = IOWebSocketChannel.connect("ws://128.199.211.112:8546");

    web3client = Web3Client(
      selectedChain.value.rpc ?? "",
      httpClient,
    );

    // if (await ConnectivityWrapper.instance.isConnected) {
    //   await getBalance();
    //   scrollController = ScrollController()..addListener(loadMoreActivity);
    //   isLoadingNetwork.value = false;
    //   await getMultipleTokenBalances();

    //   }
    //   // getTokenHistory("0xEBbc3452Cc911591e4F18f3b36727Df45d6bd1f9");

    //   // getEthBalancePeriodic();
    // } else {
    //   scrollController = ScrollController();
    //   isLoadingNetwork.value = false;
    // }
    // checkForUpdate();
    super.onInit();
  }

  // Future<void> checkForUpdate() async {
  //   InAppUpdate.checkForUpdate().then((info) {
  //     if (info.updateAvailability == UpdateAvailability.updateAvailable) {
  //       InAppUpdate.performImmediateUpdate().then((value) {
  //         if (value == AppUpdateResult.success) {
  //           alert("Update Success");
  //         }
  //       });
  //     } else if (info.flexibleUpdateAllowed) {
  //       InAppUpdate.startFlexibleUpdate().then((value) {
  //         if (value == AppUpdateResult.success) {
  //           InAppUpdate.completeFlexibleUpdate();
  //         }
  //       });
  //     }
  //   }).catchError((e) {
  //     alert(e.toString());
  //     Get.snackbar("", e.toString());
  //   });
  // }

  // updateTxStatus(List<TransactionHistory> listTx) async {
  //   for (var i = 0; i < transactionHistory.length; i++) {
  //     if (transactionHistory[i].chainId == selectedChain.value.chainId) {
  //       dev.log("txxxx length : ${transactionHistory.length}");

  //       dev.log("work tx : ${transactionHistory[i].txHash!}");
  //       final tx = await web3client!
  //           .getTransactionByHash(transactionHistory[i].txHash!);

  //       final blockInfo = await web3client!
  //           .getBlockInformation(blockNumber: tx.blockNumber.toBlockParam());

  //       final data = TransactionHistory(
  //           txHash: transactionHistory[i].txHash!,
  //           address: tx.from.hex,
  //           toAddress: tx.to!.hex,
  //           status: "confirmed",
  //           isContractInteraction: transactionHistory[i].isContractInteraction,
  //           amount: transactionHistory[i].amount,
  //           fromAddress: tx.from.hex,
  //           date: blockInfo.timestamp.toLocal(),
  //           chainId: selectedChain.value.chainId,
  //           contractAddress: transactionHistory[i].contractAddress,
  //           networkFee: (tx.gas.toDouble() * tx.gasPrice.getInWei.toInt()) /
  //               pow(10, 18),
  //           nonce: tx.nonce);

  //       for (var j = 0; j < listTx.length; j++) {
  //         if (transactionHistory[i].txHash == listTx[j].txHash &&
  //             listTx[j].status == 'pending') {
  //           transactionHistory[i] = data;
  //           // await db.updateTx(transactionHistory[i]);
  //           break;
  //         }
  //       }

  //       await db.saveAllTxHistory(transactionHistory);

  //       transactionHistory.refresh();
  //     }
  //   }
  // }

  // workerCheckTx() async {
  //   Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
  //     if (transactionHistory
  //         .where((element) => element.chainId == selectedChain.value.chainId)
  //         .toList()
  //         .any((element) => element.status == "pending")) {
  //       await updateTxStatus(transactionHistory);
  //       dev.log("TX HISTORI LENGTH : ${transactionHistory.length}");
  //     }

  // //     // Print updated listTx
  //   });

    // var pendingData = transactionHistory
    //     .where((element) => element.status == "pending")
    //     .toList();

    // if (pendingData.isNotEmpty) {
    //   _timerCheckTx =
    //       Timer.periodic(const Duration(seconds: 10), (timer) async {
    //     dev.log("WORKER CHECK TX RUNNING....");
    //     List<TransactionHistory> updatedData = [];
    //     var pendingData = transactionHistory
    //         .where((element) => element.status == "pending")
    //         .toList();
    //     for (var p in pendingData) {
    //       var pendingTx = await getHistory(p.txHash!);
    //       pendingTx.id = p.id;
    //       updatedData.add(pendingTx);

    //       updatedData.forEach((element) {
    //         dev.log("UPDATED DATA ID : ${element.id}");
    //       });
    //     }

    //     db.changeTxStatus(updatedData);
    //     initializedTxHistory();

    //     var a = await db.getAllTxHistory();
    //     var isKosong =
    //         a.where((element) => element.status == "pending").toList();
    //     if (isKosong.isEmpty) {
    //       timer.cancel();
    //     }
    //     // timer.cancel();
    //   });
    // } else {
    //   // if (_timerCheckTx.isActive) {
    //   //   _timerCheckTx.cancel();
    //   // }
    // }
  // }

  @override
  void onReady() {
    print("on ready");

    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void importAccount() => isImport.value = !isImport.value;

  void inactiveStateImportAccount() {
    isImport.value = false;
    importPrivateKeyController.clear();
  }

  BigInt convertToGwei(double amount) {
    BigInt gweiBigInt = (BigInt.from(amount * 1000000000) ~/ BigInt.one);
    print("$gweiBigInt GWEI EQUAL $amount ETHER");
    return gweiBigInt;
  }

  // void changeNetwork(ChainNetwork network, BuildContext context) async {
  //   var httpClient = Client();
  //   Get.back();

  //   await db.unSelectNetwork(selectedChain.value.id!);
  //   selectedChain.value = network;
  //   selectedChain.refresh();

  //   isLoadingNetwork.value = true;

  //   await db.changeNetwork(network.id!);

  //   web3client = Web3Client(
  //     selectedChain.value.rpc ?? "",
  //     httpClient,
  //   );

  //   await getBalance();
  //   // await findAllActivity();
  //   isLoadingNetwork.value = false;
  //   await getMultipleTokenBalances();
  // }

  // void getEthBalancePeriodic() {
  //   _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
  //     getBalance();

  //     getMultipleTokenBalances();
  //   });
  // }

  // Stream<void> getEthBalance(String privateKey) async* {
  //   yield* Stream<Future<void>>.periodic(
  //     const Duration(seconds: 15),
  //     (_) {
  //       return getBalance();
  //     },
  //   );
  // }

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
          await db.updateWallet(add.id!, balanceParsed);
          if (add.address == selectedAddress.value.address) {
            selectedAddress.value.balance = balanceParsed;
            selectedAddress.refresh();
          }
        }

        print("ON");

        balanceEth.value = selectedAddress.value.balance!;
      } catch (e) {
        print(e.toString());
        // alert("Failed to Network");
      }

      selectedAddress.value.balance = balanceEth.value;
      selectedAddress.refresh();
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

  Future<void> getMultipleTokenBalances() async {
    for (final tokenAddress in tokenList) {
      if (tokenAddress.contractAddress != null &&
          tokenAddress.chainId == selectedChain.value.chainId) {
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

  // Future<void> findAllActivity({bool isRefresh = false}) async {
  //   isLoadingActivity.value = true;
  //   ActivityRepository activityRepository = ActivityRepository();

  //   final response = await activityRepository.findAllActivity(
  //       page: isRefresh ? 1 : page.value,
  //       selectedAddress.value.address ?? "",
  //       isTestnet: selectedChain.value.isTestnet ?? false);

  //   final tokenResponse = await activityRepository.findActivityToken(
  //       selectedAddress.value.address ?? "",
  //       page: page.value,
  //       isTestnet: selectedChain.value.isTestnet!);

  //   print("TOKEN RESPONSE LENGTH : $tokenResponse");

  //   tokenResponse.forEach((element) {
  //     print("Token name  : ${element.name}");
  //   });

  //   for (int i = 0; i < response.length; i++) {
  //     if (response[i].contractAddress == "") {
  //       var token = tokenResponse.singleWhere(
  //         (element) => element.hash == response[i].hash,
  //         orElse: () {
  //           return response[i];
  //         },
  //       );

  //       response[i] = response[i].copyWith(
  //           name: token.name,
  //           symbol: token.symbol,
  //           decimal: token.decimal,
  //           value: token.value,
  //           contractAddress: token.contractAddress);
  //     }

  //     // print(response[i].name);
  //     // print(response[i].value);
  //     // print(response[i].symbol);
  //     // print(response[i].input);
  //   }
  //   if (isRefresh) {
  //     page.value = 1;
  //     listActivity.clear();
  //   }

  //   listActivity.assignAll(response);
  //   debugPrint('====================${listActivity.length}');

  //   // for (Activity activity in listActivity) {
  //   //   if (activity.input != "0x" && activity.input != "") {
  //   //     var data = hex.decode(activity.input!.substring(2));
  //   //     try {
  //   //       var call = abi.decomposeCall(Uint8List.fromList(data));
  //   //       print(call.functionName);
  //   //       activity.method = call.functionName.substring(0, 1).toUpperCase() +
  //   //           call.functionName.substring(1);
  //   //       ;
  //   //       activity.value = call.getCallParam('_value').toString();
  //   //     } catch (e) {
  //   //       activity.method = "Smart Contract Call";
  //   //       activity.name = selectedChain.value.symbol;
  //   //       print(e.toString());
  //   //     }
  //   //   }
  //   // }

  //   // listActivity.forEach((element) async {
  //   //   if (element.contractAddress != "") {
  //   //     final token = ERC20(
  //   //         client: web3client!,
  //   //         address: EthereumAddress.fromHex(element.contractAddress!));

  //   //     // element. = await token.name();
  //   //     // element.symbol = await token.symbol();

  //   //     // var data = hex.decode(element.input!);
  //   //     // print(data);
  //   //     // var call = contractABI.decomposeCall(Uint8List.fromList(data));

  //   //     // print(call.callParams);
  //   //   }
  //   // });

  //   listActivity.refresh();
  //   isLoadingActivity.value = false;

  //   dev.log("Activity length : ${listActivity.length}");
  // }

  // Future<void> findActivityToken() async {
  //   ActivityRepository activityRepository = ActivityRepository();
  //   await activityRepository
  //       .findActivityToken(selectedAddress.value.address ?? "", page: page.value, isTestnet: selectedChain.value.isTestnet!);
  // }

  // void loadMoreActivity() async {
  //   if (hasNextPage.value == true &&
  //       isLoadingActivity.value == false &&
  //       isLoadMoreRunning.value == false &&
  //       scrollController.position.extentAfter < 300) {
  //     isLoadMoreRunning.value = true;
  //     page.value++;

  //     String testnet = "https://testnet.spectachains.org";
  //     String mainet = "https://explorer.spectachains.org";

  //     String url =
  //         "${(selectedChain.value.isTestnet ?? false) ? testnet : mainet}/api?module=account&action=txlist&address=${selectedAddress.value.address ?? ""}&sort=desc&page=${page.value}";
  //     var response = await http.get(Uri.parse(url));
  //     var json = jsonDecode(response.body)['result'];

  //     if (json is List && json.isNotEmpty) {
  //       listActivity.addAll(json.map((e) => Activity.fromJson(e)).toList());
  //       debugPrint('====================${listActivity.length}');
  //     } else {
  //       hasNextPage.value = false;
  //     }

  //     isLoadMoreRunning.value = false;
  //   }
  // }

  // Future<String?> transferToken(
  //     {required String contractAddress,
  //     required String to,
  //     required double amount,
  //     required Result token}) async {
  //   final contract =
  //       DeployedContract(erc20Abi!, EthereumAddress.fromHex(contractAddress));
  //   var credentials = EthPrivateKey.fromHex(selectedPrivateKey.value);

  //   final map = {
  //     'contract': token.contractAddress,
  //     'to': to,
  //     'amount': amount,
  //   };

  //   dev.log(map.toString());

  //   final value = BigInt.from(amount * pow(10, token.decimals!));

  //   try {
  //     final transaction = Transaction.callContract(
  //       contract: contract,
  //       from: credentials.address,
  //       function: contract.function('transfer'),
  //       parameters: <dynamic>[
  //         EthereumAddress.fromHex(to),
  //         value,
  //       ],
  //     );

  //     final response = await web3client!.sendTransaction(
  //         credentials, transaction,
  //         chainId: int.parse(selectedChain.value.chainId!));
  //     print("CONTRACT ADDRESS : $contractAddress");
  //     await getHistory(response,
  //         contractAddress: token.contractAddress,
  //         value: amount,
  //         to: to,
  //         isContractInteraction: false);
  //     print("Transfer Token Result : $response");

  //     return response;
  //   } catch (e) {
  //     alert(e.toString());
  //     return null;
  //   }
  // }

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
      // alert(e.toString());
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

      /// SEND TRANSACTION
      final transaction = Transaction(
          from: credentials.address,
          to: toAddress,
          gasPrice: gasPrice == null
              ? null
              : EtherAmount.fromUnitAndValue(EtherUnit.ether, gasPrice),
          value: EtherAmount.fromUnitAndValue(EtherUnit.gwei, gweiBigInt));

      final response = await web3client!.sendTransaction(
        credentials,
        transaction,
        // chainId: int.parse(selectedChain.value.chainId ?? "1"),
      );
      print("Txhash : $response");
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
      print(e.toString());
      // alert(e.toString());
      return null;
    }
  }

  Future<void> createNewAddress() async {
    isLoadingCreateAccount.value = true;
    final mnemonic = WalletRepository().generateMnemonic();
    var account = WalletRepository().getAccountInfo(mnemonic);
    await db.unSelectWallet(selectedAddress.value.id!);
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

    await db.addAddress(addressNew);
    await db.changeWallet(addressNew.id!);
    decrypted(
      selectedAddress.value.privateKey!,
    );
    isLoadingCreateAccount.value = false;
    await getBalance();

    final listAddress = await db.readAddressList();
    listAddress!.forEach((element) {
      print(element.name);
      print(element.address);
    });
  }

  void changeAddress(Address address) async {
    print("SELECTED WALLET ADDRESS : ${selectedAddress.value.id}");
    await db.unSelectWallet(selectedAddress.value.id!);
    dev.log("INIT ADDRESS : ${selectedAddress.value.id!}");

    selectedAddress.value = address;
    selectedAddress.refresh();

    await db.changeWallet(address.id!);
    dev.log("NEW ADDRESS : ${address.id!}");

    decrypted(
      selectedAddress.value.privateKey!,
    );
    Get.back();

    if (await ConnectivityWrapper.instance.isConnected) {
      await getBalance();
      await getMultipleTokenBalances();
      // await findAllActivity();
    }
    decrypted(selectedAddress.value.privateKey!);

    final listAddress = await db.readAddressList();
    listAddress!.forEach((element) {
      print(element.name);
      print(element.address);
    });
  }

  Future<void> importAddress(String privateKey) async {
    // VALIDATE PRIVATE KEY
    isLoadingImportAccount.value = true;

    try {
      final isValid = WalletRepository().validatePrivateKey(privateKey);

      if (isValid) {
        final credentials = EthPrivateKey.fromHex(privateKey);
        final privatekeyEncrypted = encrypter.encrypt(privateKey, iv: iv);
        if (addressList
            .where((v) => v.address == credentials.address.hex)
            .isNotEmpty) {
          // alert("Address already exist");
        } else {
          await db.unSelectWallet(selectedAddress.value.id!);

          print("Private Key : $privateKey");
          print("privateKey encrypted : $privateKeySelected");
          Address addressNew = Address(
              name: "Account",
              address: credentials.address.hex,
              mnemonic: null,
              balance: 0,
              selectedAddress: true,
              privateKey: privatekeyEncrypted.base64.toString());

          selectedAddress.value = addressNew;
          addressList.add(addressNew);
          importPrivateKeyController.clear();
          Get.back();

          await db.addAddress(addressNew);
          await db.changeWallet(addressNew.id!);
          decrypted(
            selectedAddress.value.privateKey!,
          );

          await getBalance();
        }
      } else {
        // alert("Invalid private key");
      }
    } catch (e) {
      // alert("Invalid private key");
    }
    isLoadingImportAccount.value = false;
  }

  // Future<void> testHistory(String tx) async {
  //   try {
  //     final hash = await web3client!.getTransactionByHash(tx);
  //     dev.log(hash.hash);
  //     dev.log(hash.to.toString());
  //     dev.log(hash.blockNumber.toBlockParam());
  //   } catch (e) {
  //     dev.log("Failedd");
  //   }
  // }

  // Future<TransactionHistory> getHistory(String txHash,
  //     {String? contractAddress,
  //     double? value,
  //     String? to,
  //     required bool isContractInteraction}) async {
  //   // / GET TRANSACTION HASH
  //   // await Future.delayed(const Duration(seconds: 5));
  //   print("CONTRACT ADDRESS History : $contractAddress");
  //   try {
  //     final tx = await web3client!.getTransactionByHash(txHash);

  //     // final contract = contractAddress != null
  //     //     ? DeployedContract(
  //     //         erc20Abi!, EthereumAddress.fromHex(contractAddress))
  //     //     : null;

  //     final blockInfo = await web3client!
  //         .getBlockInformation(blockNumber: tx.blockNumber.toBlockParam());

  //     final data = TransactionHistory(
  //         txHash: txHash,
  //         address: tx.from.hex,
  //         toAddress: tx.to!.hex,
  //         status: "confirmed",
  //         amount: tx.value.getInEther.toDouble(),
  //         fromAddress: tx.from.hex,
  //         date: blockInfo.timestamp.toLocal(),
  //         chainId: selectedChain.value.chainId,
  //         contractAddress: contractAddress,
  //         isContractInteraction: isContractInteraction,
  //         networkFee:
  //             (tx.gas.toDouble() * tx.gasPrice.getInWei.toInt()) / pow(10, 18),
  //         nonce: tx.nonce);
  //     transactionHistory.add(data);
  //     transactionHistory.sort(
  //       (a, b) => b.date!.compareTo(a.date!),
  //     );

  //     // transactionHistory.refresh();
  //     // if (checkOnly == null || false) {
  //     dev.log("Tx saved");
  //     await db.saveTxHistory(data);
  //     // }

  //     return data;
  //   } catch (e) {
  //     print("contractAddress catch: $contractAddress");
  //     final data = TransactionHistory(
  //         txHash: txHash,
  //         address: selectedAddress.value.address,
  //         toAddress: to,
  //         amount: value,
  //         status: "pending",
  //         fromAddress: selectedAddress.value.address,
  //         date: DateTime.now(),
  //         chainId: selectedChain.value.chainId,
  //         isContractInteraction: isContractInteraction,
  //         contractAddress: contractAddress,
  //         networkFee: 0,
  //         nonce: 0);
  //     // if (checkOnly == null || false) {
  //     await db.saveTxHistory(data);
  //     // }
  //     return data;
  //   }
  // }

  // List<TransactionHistory> txHistoryCoin() {
  //   return transactionHistory
  //       .where((element) =>
  //           element.address == selectedAddress.value.address ||
  //           element.contractAddress == null)
  //       .toList();
  // }

  // Future getTokenHistory(String contractAddress) async {
  //   final contract =
  //       DeployedContract(erc20Abi!, EthereumAddress.fromHex(contractAddress));

  //   final filter = FilterOptions.events(
  //       contract: contract,
  //       event: contract.event('Transfer'),
  //       fromBlock: const BlockNum.genesis(),
  //       toBlock: const BlockNum.current());

  //   final events = await web3client!.getLogs(filter);

  //   events.forEach((element) {
  //     print("TX HASH TOKEN : ${element.transactionHash}");
  //   });
  // }

  // void setActivity(int value) => selectedTabActivity.value = value;

  // Future<void> resetWallet() async {
  //   await db.resetWallet();
  //   Get.offAll(() => const OnBoardingPage());
  // }

  // Future getTx(String hash) async {
  //   final response = await web3client!.getTransactionByHash(hash);

  //   dev.log("from : ${response.from}");
  //   dev.log("to : ${response.to}");
  //   dev.log("tx : ${response.hash}");
  //   dev.log("value : ${response.value}");

  //   dev.log(response.toString());
  // }

  // Future<void> addNetwork(ChainNetwork network) async {
  //   await db.addChainNetwork(network);
  //   final networkList = await db.getAllChainNetwork();

  //   listChain.assignAll(networkList);
  //   listChain.refresh();
  // }

  // Future<void> editNetwork(ChainNetwork network) async {
  //   await db.ediChainNetwork(network);
  //   final networkList = await db.getAllChainNetwork();
  //   listChain.assignAll(networkList);
  //   listChain.refresh();
  // }

  // Future<void> deleteNetwork(ChainNetwork network) async {
  //   await db.deleteChainNetwork(network.id!);
  //   final networkList = await db.getAllChainNetwork();
  //   listChain.assignAll(networkList);
  //   listChain.refresh();
  // }

  // Future<String> swap() async {
  //   final Credentials credentials =
  //       EthPrivateKey.fromHex(selectedPrivateKey.value);
  //   final toAddress =
  //       EthereumAddress.fromHex("0x13f4EA83D0bd40E75C8222255bc855a974568Dd4");

  //   final transaction = Transaction(
  //       from: credentials.address,
  //       data: Uint8List.fromList(utf8.encode(
  //           "0x5ae401dc0000000000000000000000000000000000000000000000000000000064880e8b00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000e404e45aaf000000000000000000000000bb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c0000000000000000000000000e09fabb73bd3ade0a17ecc321fd13a19e81ce8200000000000000000000000000000000000000000000000000000000000001f40000000000000000000000004ffd705b627d7a6997840320c2742e3388be8d3e0000000000000000000000000000000000000000000000000000209acdcfcc8000000000000000000000000000000000000000000000000000159de26efac128000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000")),
  //       to: toAddress,
  //       gasPrice: EtherAmount.fromUnitAndValue(
  //           EtherUnit.gwei, BigInt.from(0.00025867)),
  //       value: EtherAmount.fromUnitAndValue(
  //           EtherUnit.ether, BigInt.from(0.00003584925)));

  //   final response = await web3client!.sendTransaction(
  //     credentials,
  //     transaction,
  //     chainId: int.parse(selectedChain.value.chainId ?? "1"),
  //   );
  //   print("Txhash : $response");

  //   return response;

  // }

  Uint8List hexToBytes(String hexString) {
    final bytes = hex.decode(hexString.replaceAll('0x', ''));
    return Uint8List.fromList(bytes);
  }

  // Future<void> getDappsHistory() async {
  //   final list = await db.getDappsHistory();
  //   dappsHistory.assignAll(list);
  //   dappsHistory.refresh();
  // }

  // Future<void> addDappsHistory(DappsHistory history) async {
  //   await db.addHistoryDapps(history);
  //   await getDappsHistory();
  // }

  // Future<void> deleteDappsHistory(int id) async {
  //   await db.deleteDappsHistory(id);
  //   await getDappsHistory();
  // }

  @override
  void dispose() {
    _ethBalanceController.close();
    // channel.sink.close();
    super.dispose();
  }
}