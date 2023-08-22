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
}
