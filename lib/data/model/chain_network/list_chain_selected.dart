import 'package:isar/isar.dart';
import 'dart:convert';
part 'list_chain_selected.g.dart';

List<ListChainSelected> listChainSelectedFromJson(String str) =>
    List<ListChainSelected>.from(
        json.decode(str).map((x) => ListChainSelected.fromJson(x)));

String listChainSelectedToJson(List<ListChainSelected> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@Collection()
class ListChainSelected {
  ListChainSelected({
    this.id,
    this.name,
    this.symbol,
    this.rpc,
    this.chainId,
    this.walletAddress,
    this.explorer,
    this.logo,
    this.color,
    this.isTestnet,
  });
  Id? id = Isar.autoIncrement;
  String? name;
  String? symbol;
  String? rpc;
  String? chainId;
  String? walletAddress;
  String? explorer;
  String? logo;
  String? color;
  bool? isTestnet;

  ListChainSelected copyWith({
    String? name,
    String? symbol,
    String? rpc,
    String? chainId,
    String? walletAddress,
    String? explorer,
    String? logo,
    String? color,
    bool? isTestnet,
  }) =>
      ListChainSelected(
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        rpc: rpc ?? this.rpc,
        chainId: chainId ?? this.chainId,
        walletAddress: walletAddress ?? this.walletAddress,
        explorer: explorer ?? this.explorer,
        logo: logo ?? this.logo,
        color: color ?? this.color,
        isTestnet: isTestnet ?? this.isTestnet,
      );

  factory ListChainSelected.fromJson(Map<String, dynamic> json) =>
      ListChainSelected(
        name: json["name"],
        symbol: json["symbol"],
        rpc: json["RPC"],
        chainId: json["chainId"],
        explorer: json["explorer"],
        logo: json["logo"],
        color: json["color"],
        isTestnet: json["isTestnet"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
        "RPC": rpc,
        "chainId": chainId,
        "explorer": explorer,
        "color": color,
        "logo": logo,
        "isTestnet": isTestnet,
      };
}
