import 'package:get/get.dart';
import 'package:isar/isar.dart';
import '../../data/data.dart';

const String addressKey = "address";
const String selectedAddressKey = "addresskey";

class DBController extends GetxController {
  var isWalletExist = false.obs;
  late Isar isar;
  var password = Password().obs;
  @override
  void onInit() async {
    isar = await Isar.open(
      [
        PasswordSchema,
        AddressSchema,
        ChainNetworkSchema,
        ResultSchema,
        TransactionHistorySchema,
        RecentAddressSchema,
        DappsHistorySchema
      ],
      inspector: true, directory: '',
    );
    // readAddress();
    final address = await getSelectedWallet();

    isWalletExist.value = address != null;
    super.onInit();
  }

  Future<void> setPassword(Password password) async {
    await isar.writeTxn(() async {
      await isar.passwords.put(password);
    });
  }

  Future<void> getPassword() async {
    // var password = Password();
    await isar.txn(() async {
      final pass = await isar.passwords.where().findAll();
      password.value = pass.first;
    });

    // return password.value;
  }

  Future<void> addAddress(Address address) async {
    await isar.writeTxn(() async {
      await isar.address.put(address);
    });
  }

  Future<List<Address>?> readAddressList() async {
    final List<Address> addressList = [];
    final allAddress =
        await isar.address.where(distinct: true, sort: Sort.asc).findAll();

    addressList.addAll(allAddress);

    return addressList;
  }

  Future<void> deleteAddress(int id) async {
    await isar.writeTxn(() async {
      await isar.address.delete(id);
    });
  }

  Future<void> changeWallet(int id) async {
    await isar.writeTxn(() async {
      final add = await isar.address.get(id);

      add!.selectedAddress = true;
      await isar.address.put(add);
    });

    // final res = box.get(address.address);
  }

  Future<void> unSelectWallet(int id) async {
    await isar.writeTxn(() async {
      final add = await isar.address.get(id);

      add!.selectedAddress = false;
      await isar.address.put(add);
    });
  }

  Future<void> updateWallet(int id, double balance) async {
    await isar.writeTxn(() async {
      final address = await isar.address.get(id);
      if (address != null) {
        address.balance = balance;
        await isar.address.put(address);
      }
    });
  }

  Future<Address?> getSelectedWallet() async {
    // final box = await Hive.openBox<Address>(selectedAddressKey);
    // final address = box.get(selectedAddressKey);
    final address =
        await isar.address.filter().selectedAddressEqualTo(true).findFirst();

    return address;
  }

  /// ########################### NETWORK #################################
  Future<void> setChainNetwork(List<ChainNetwork> networks) async {
    await isar.writeTxn(() async {
      await isar.chainNetworks.putAll(networks);
    });
  }

  Future<void> changeNetwork(int id) async {
    await isar.writeTxn(() async {
      final add = await isar.chainNetworks.get(id);

      add!.selected = true;
      await isar.chainNetworks.put(add);
    });
  }

  Future<void> unSelectNetwork(int id) async {
    await isar.writeTxn(() async {
      final add = await isar.chainNetworks.get(id);

      add!.selected = false;
      await isar.chainNetworks.put(add);
    });
  }

  Future<List<ChainNetwork>> getAllChainNetwork() async {
    List<ChainNetwork> networks = [];
    await isar.txn(() async {
      networks = await isar.chainNetworks.where().findAll();
    });

    return networks;
  }

  Future<ChainNetwork?> getSelectedChainNetwork() async {
    final chain =
        await isar.chainNetworks.filter().selectedEqualTo(true).findFirst();

    return chain;
  }

  Future<void> addChainNetwork(ChainNetwork network) async {
    await isar.writeTxn(() async {
      await isar.chainNetworks.put(network);
    });
  }

  Future<void> ediChainNetwork(ChainNetwork network) async {
    await isar.writeTxn(() async {
      final item = await isar.chainNetworks.get(network.id!);
      item!.chainId = network.chainId;
      item.name = network.name;
      item.rpc = network.rpc;
      item.symbol = network.symbol;
      item.explorer = network.explorer;
      item.isTestnet = network.isTestnet;

      await isar.chainNetworks.put(item);
    });
  }

  Future<void> deleteChainNetwork(int id) async {
    await isar.writeTxn(() async {
      await isar.chainNetworks.delete(id);
    });
  }

  Future<List<Result>> getAllToken() async {
    List<Result> tokens = [];
    await isar.txn(() async {
      tokens = await isar.results.where().findAll();
    });
    return tokens;
  }

  Future<void> addAllToken(List<Result> tokens) async {
    await isar.writeTxn(() async {
      await isar.results.putAll(tokens);
    });
  }

  Future<void> addToken(Result token) async {
    await isar.writeTxn(() async {
      await isar.results.put(token);
    });
  }

  Future<void> selectToken(Result token) async {
    await isar.writeTxn(() async {
      final result = await isar.results.get(token.id!);
      result!.selected = token.selected;
      await isar.results.put(result);
    });
  }

  Future<void> deleteToken(int id) async {
    await isar.writeTxn(() async {
    
      await isar.results.delete(id);
    });
  }

  Future<void> deleteAll() async {
    await isar.writeTxn(() async {
      await isar.results.clear();
    });
  }

  /// ########################### TX HISTORY #################################
  ///
  ///

  Future<void> saveTxHistory(TransactionHistory history) async {
    await isar.writeTxn(() async {
      await isar.transactionHistorys.put(history);
    });
  }

  Future<void> saveAllTxHistory(List<TransactionHistory> history) async {
    await isar.writeTxn(() async {
      await isar.transactionHistorys.clear();
      await isar.transactionHistorys.putAll(history);
    });
  }

  Future<List<TransactionHistory>> getAllTxHistory() async {
    List<TransactionHistory> list = [];
    await isar.txn(() async {
      list = await isar.transactionHistorys
          .where(
            distinct: true,
          )
          .findAll();
    });

    return list;
  }

  Future<void> updateTx(TransactionHistory transactionHistory) async {
    await isar.writeTxn(() async {
      var items =
          await isar.transactionHistorys.where(distinct: true).findAll();
      var selectedTx = items.singleWhere(
          (element) => element.txHash == transactionHistory.txHash);

      final id = selectedTx.id;
      selectedTx.status == "confirmed";
      selectedTx.id = id;

      await isar.transactionHistorys.put(selectedTx);
    });
  }

  // Future<void> changeTxStatus(List<TransactionHistory> pendingList) async {
  //   List<int> indexList = [];
  //   for (var tx in pendingList) {
  //     indexList.add(tx.id!);
  //   }

  //   await isar.txn(() async {
  //     final listResult = await isar.transactionHistorys.getAll(indexList);

  //     for (var data in listResult) {
  //       data!.id = data.id;
  //       data.status = "confirmed";
  //       await isar.transactionHistorys.put(data);
  //     }
  //   });
  // }

  Future<void> resetWallet() async {
    await isar.writeTxn(() async {
      await isar.address.clear();
      await isar.passwords.clear();
      await isar.results.clear();
      await isar.recentAddress.clear();
      await isar.transactionHistorys.clear();
    });
  }

  Future<List<RecentAddress>> getRecentAddress() async {
    List<RecentAddress> list = [];
    await isar.txn(() async {
      list = await isar.recentAddress.where().findAll();
    });

    return list;
  }

  Future<void> saveRecentAddress(
    RecentAddress address,
  ) async {
    final list = await getRecentAddress();
    bool isExist = false;
    list.forEach((element) {
      if (element.address == address.address) {
        isExist = true;
      }
    });

    if (!isExist) {
      await isar.writeTxn(() async {
        await isar.recentAddress.put(address);
      });
    }
  }

  Future<List<DappsHistory>> getDappsHistory() async {
    List<DappsHistory> list = [];
    await isar.txn(() async {
      list = await isar.dappsHistorys.where().findAll();
    });

    return list;
  }

  Future<void> addHistoryDapps(DappsHistory history) async {
    await isar.writeTxn(() async {
      await isar.dappsHistorys.put(history);
    });
  }

  Future<void> deleteDappsHistory(int id) async {
    await isar.writeTxn(() async {
      await isar.dappsHistorys.delete(id);
    });
  }
}