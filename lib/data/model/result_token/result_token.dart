import 'package:isar/isar.dart';

import 'dart:convert';
part 'result_token.g.dart';

ResultToken resultTokenFromJson(String str) =>
    ResultToken.fromJson(json.decode(str));

String resultTokenToJson(ResultToken data) => json.encode(data.toJson());

class ResultToken {
  ResultToken({
    this.message,
    this.result,
    this.status,
  });

  String? message;
  List<Result>? result;
  String? status;

  ResultToken copyWith({
    String? message,
    List<Result>? result,
    String? status,
  }) =>
      ResultToken(
        message: message ?? this.message,
        result: result ?? this.result,
        status: status ?? this.status,
      );

  factory ResultToken.fromJson(Map<String, dynamic> json) => ResultToken(
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
        "status": status,
      };
}

@collection
class Result {
  Result(
      {this.id,
      this.balance,
      this.contractAddress,
      this.addressWallet,
      this.decimals,
      this.name,
      this.symbol,
      this.type,
      this.chainId, this.selected});

  Id? id = Isar.autoIncrement;
  double? balance;
  String? contractAddress;
  String? addressWallet;
  int? decimals;
  String? name;
  String? symbol;
  String? type;
  String? chainId;
  bool? selected;

  Result copyWith({
    double? balance,
    String? contractAddress,
    String? addressWallet,
    int? decimals,
    String? name,
    String? symbol,
    String? type,
    String? chainId,
    bool? selected
  }) =>
      Result(
          balance: balance ?? this.balance,
          contractAddress: contractAddress ?? this.contractAddress,
          addressWallet: addressWallet ?? this.addressWallet,
          decimals: decimals ?? this.decimals,
          name: name ?? this.name,
          symbol: symbol ?? this.symbol,
          type: type ?? this.type,
          chainId: chainId ?? this.chainId,
          selected: selected ?? this.selected
          );

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        balance: double.parse(json["balance"].toString()),
        contractAddress: json["contractAddress"],
        decimals: int.parse(json["decimals"].toString()),
        name: json["name"],
        symbol: json["symbol"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "contractAddress": contractAddress,
        "decimals": decimals,
        "name": name,
        "symbol": symbol,
        "type": type,
      };
}