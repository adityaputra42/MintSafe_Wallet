import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/data.dart';

class DbHelper {
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();
  factory DbHelper() {
    return instance;
  }
  late Isar isar;

  void onInit() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        PasswordSchema,
        AddressSchema,
        ChainNetworkSchema,
        ResultSchema,
        TransactionHistorySchema,
        RecentAddressSchema,
        DappsHistorySchema,
        TokenSchema,
      ],
      inspector: true,
      directory: dir.path,
    );
  }

  Future<void> setPassword(Password password) async {
    await isar.writeTxn(() async {
      await isar.passwords.put(password);
    });
  }

  Future<Password> getPassword() async {
    var password = Password();
    await isar.txn(() async {
      final pass = await isar.passwords.where().findAll();
      password = pass.first;
    });
    return password;
  }

  Future<void> addAddress(Address address) async {
    await isar.writeTxn(() async {
      await isar.address.put(address);
    });
  }

  Future<List<Address>?> getAllAddress() async {
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
  }

  Future<void> unSelectWallet(int id) async {
    await isar.writeTxn(() async {
      final add = await isar.address.get(id);
      add!.selectedAddress = false;
      await isar.address.put(add);
    });
  }

  Future<Address?> getSelectedWallet() async {
    final address =
        await isar.address.filter().selectedAddressEqualTo(true).findFirst();
    return address;
  }

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

  Future<void> editChainNetwork(ChainNetwork network) async {
    await isar.writeTxn(() async {
      final item = await isar.chainNetworks.get(network.id!);
      item!.chainId = network.chainId;
      item.name = network.name;
      item.rpc = network.rpc;
      item.symbol = network.symbol;
      item.explorer = network.explorer;
      item.logo = network.logo;
      item.color = network.color;
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

  Future<void> updateWallet(int id, double balance) async {
    await isar.writeTxn(() async {
      final address = await isar.address.get(id);
      if (address != null) {
        address.balance = balance;
        await isar.address.put(address);
      }
    });
  }

  Future<List<Address>?> readAddressList() async {
    final List<Address> addressList = [];
    final allAddress =
        await isar.address.where(distinct: true, sort: Sort.asc).findAll();

    addressList.addAll(allAddress);

    return addressList;
  }

  Future<List<RecentAddress>> getRecentAddress() async {
    List<RecentAddress> list = [];
    await isar.txn(() async {
      list = await isar.recentAddress.where().findAll();
    });

    return list;
  }

  Future<void> setToken(List<Token> tokens) async {
    await isar.writeTxn(() async {
      await isar.tokens.putAll(tokens);
    });
  }

  Future<List<Token>> getAllTokens() async {
    List<Token> token = [];
    await isar.txn(() async {
      token = await isar.tokens.where().findAll();
    });
    return token;
  }

  Future<List<Token>> getSelectedListToken(String chainId) async {
    final tokens = await isar.tokens.filter().chainIdEqualTo(chainId).findAll();
    return tokens;
  }
}
