import 'dart:convert';
import 'package:isar/isar.dart';
part 'token.g.dart';

List<Token> tokenFromJson(String str) =>
    List<Token>.from(json.decode(str).map((x) => Token.fromJson(x)));

String tokenToJson(List<Token> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@Collection()
class Token {
  Token({
    this.id,
    this.name,
    this.contractAddress,
    this.symbol,
    this.decimal,
    this.balance,
    this.logo,
    this.chainId,
  });
  Id? id = Isar.autoIncrement;
  String? name;
  String? contractAddress;
  String? symbol;
  int? decimal;
  double? balance;
  String? logo;
  String? chainId;

  Token copyWith({
    String? name,
    String? contractAddress,
    String? symbol,
    int? decimal,
    double? balance,
  }) =>
      Token(
        name: name ?? this.name,
        contractAddress: contractAddress ?? this.contractAddress,
        symbol: symbol ?? this.symbol,
        decimal: decimal ?? this.decimal,
        balance: balance ?? this.balance,
      );

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        name: json["name"],
        contractAddress: json["contract"],
        symbol: json["symbol"],
        chainId: json["chainId"],
        logo: json["logo"],
        decimal: int.parse(json["decimal"].toString()),
        balance: json["balance"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "chainId": chainId,
        "contract": contractAddress,
        "symbol": symbol,
        "decimal": decimal,
        "logo": logo,
        "balance": balance,
      };
}
