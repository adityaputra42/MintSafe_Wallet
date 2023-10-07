import 'package:isar/isar.dart';
import 'dart:convert';
part 'chain_network.g.dart';

List<ChainNetwork> chainNetworkFromJson(String str) => List<ChainNetwork>.from(
    json.decode(str).map((x) => ChainNetwork.fromJson(x)));

String chainNetworkToJson(List<ChainNetwork> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@Collection()
class ChainNetwork {
  ChainNetwork({
    this.id,
    this.name,
    this.symbol,
    this.rpc,
    this.chainId,
    this.explorer,
    this.logo,
    this.color,
    this.selected = false,
    this.isTestnet,
    this.tokenRegistry,
  });
  Id? id = Isar.autoIncrement;
  String? name;
  String? symbol;
  String? rpc;
  String? chainId;
  String? explorer;
  String? logo;
  String? color;
  bool selected;
  bool? isTestnet;
  String? tokenRegistry;

  ChainNetwork copyWith({
    String? name,
    String? symbol,
    String? rpc,
    String? chainId,
    String? explorer,
    String? logo,
    String? color,
    bool? isTestnet,
  }) =>
      ChainNetwork(
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        rpc: rpc ?? this.rpc,
        chainId: chainId ?? this.chainId,
        explorer: explorer ?? this.explorer,
        logo: logo ?? this.logo,
        color: color ?? this.color,
        isTestnet: isTestnet ?? this.isTestnet,
      );

  factory ChainNetwork.fromJson(Map<String, dynamic> json) => ChainNetwork(
      name: json["name"],
      symbol: json["symbol"],
      rpc: json["RPC"],
      chainId: json["chainId"],
      explorer: json["explorer"],
      logo: json["logo"],
      color: json["color"],
      isTestnet: json["isTestnet"],
      tokenRegistry: json['token_registry']);

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
