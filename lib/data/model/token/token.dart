

import 'dart:convert';
import 'package:isar/isar.dart';
part 'token.g.dart';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

@Collection()
class Token {
  Token({
    this.id,
    this.name,
    this.contractAddress,
    this.addressWallet,
    this.tokenSymbol,
    this.decimal,
    this.balance,
    this.chainId
    
  });
  Id? id = Isar.autoIncrement;
  String? name;
  String? contractAddress;
  String? addressWallet;
  String? tokenSymbol;
  int? decimal;
  double? balance;
  String? chainId;

  Token copyWith({
    String? name,
    String? contractAddress,
    String? tokenSymbol,
    int? decimal,
    double? balance,
  }) =>
      Token(
        name: name ?? this.name,
        contractAddress: contractAddress ?? this.contractAddress,
        tokenSymbol: tokenSymbol ?? this.tokenSymbol,
        decimal: decimal ?? this.decimal,
        balance: balance ?? this.balance,
      );

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        name: json["name"],
        contractAddress: json["contractAddress"],
        tokenSymbol: json["tokenSymbol"],
        decimal: json["decimal"],
        balance: json["balance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contractAddress": contractAddress,
        "tokenSymbol": tokenSymbol,
        "decimal": decimal,
        "balance": balance,
      };
}