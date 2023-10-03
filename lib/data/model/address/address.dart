import 'package:isar/isar.dart';
part 'address.g.dart';

@Collection()
class Address {
  Address(
      {this.id,
      this.name,
      this.address,
      this.mnemonic,
      this.privateKey,
      this.selectedAddress = false,
      this.balance});

  Id? id = Isar.autoIncrement;

  String? name;

  String? address;

  String? mnemonic;

  String? privateKey;

  bool? selectedAddress;

  double? balance;

  Address copyWith(
          {String? name,
          String? address,
          String? mnemonic,
          String? privateKey,
          double? balance,
          bool? selectedAddress}) =>
      Address(
          name: name ?? this.name,
          address: address ?? this.address,
          mnemonic: mnemonic ?? this.mnemonic,
          privateKey: privateKey ?? this.privateKey,
          selectedAddress: selectedAddress ?? this.selectedAddress,
          balance: this.balance);

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        name: json["name"],
        address: json["address"],
        mnemonic: json["mnemonic"],
        privateKey: json["privateKey"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "mnemonic": mnemonic,
        "privateKey": privateKey,
      };
}
