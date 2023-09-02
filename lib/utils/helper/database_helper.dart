import 'package:isar/isar.dart';

import '../../data/data.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  factory DatabaseHelper() {
    return instance;
  }
  late Isar isar;

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
      inspector: true,
      directory: '',
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
}
