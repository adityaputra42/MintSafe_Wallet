import 'dart:convert';
import 'package:isar/isar.dart';

part 'selected_token.g.dart';

List<SelectedToken> selectedTokenFromJson(String str) =>
    List<SelectedToken>.from(
        json.decode(str).map((x) => SelectedToken.fromJson(x)));

String selectedTokenToJson(List<SelectedToken> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@Collection()
class SelectedToken {
  SelectedToken({
    this.id,
    this.name,
    this.contractAddress,
    this.symbol,
    this.walletAddress,
    this.decimal,
    this.balance,
    this.logo,
    this.chainId,
    this.selected,
  });
  Id? id = Isar.autoIncrement;
  String? name;
  String? contractAddress;
  String? walletAddress;
  String? symbol;
  int? decimal;
  double? balance;
  String? logo;
  String? chainId;
  bool? selected;

  SelectedToken copyWith(
          {String? name,
          String? contractAddress,
          String? walletAddress,
          String? symbol,
          int? decimal,
          double? balance,
          bool? selected}) =>
      SelectedToken(
          name: name ?? this.name,
          contractAddress: contractAddress ?? this.contractAddress,
          walletAddress: walletAddress ?? this.walletAddress,
          symbol: symbol ?? this.symbol,
          decimal: decimal ?? this.decimal,
          balance: balance ?? this.balance,
          selected: selected ?? this.selected);

  factory SelectedToken.fromJson(Map<String, dynamic> json) => SelectedToken(
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
