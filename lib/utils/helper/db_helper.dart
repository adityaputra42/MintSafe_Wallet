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
        DappsHistorySchema
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
}
