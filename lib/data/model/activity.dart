// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

import 'dart:convert';

List<Activity> activityFromJson(String str) =>
    List<Activity>.from(json.decode(str).map((x) => Activity.fromJson(x)));

String activityToJson(List<Activity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Activity {
  Activity({
    this.blockHash,
    this.blockNumber,
    this.confirmations,
    this.contractAddress,
    this.cumulativeGasUsed,
    this.from,
    this.gas,
    this.gasPrice,
    this.gasUsed,
    this.hash,
    this.input,
    this.isError,
    this.nonce,
    this.timeStamp,
    this.to,
    this.transactionIndex,
    this.txreceiptStatus,
    this.value,
    this.name,
    this.symbol,
    this.method,
    this.decimal,
  });

  String? blockHash;
  String? blockNumber;
  String? confirmations;
  String? contractAddress;
  String? cumulativeGasUsed;
  String? from;
  String? gas;
  String? gasPrice;
  String? gasUsed;
  String? hash;
  String? input;
  String? isError;
  String? nonce;
  String? timeStamp;
  String? to;
  String? transactionIndex;
  String? txreceiptStatus;
  String? value;
  String? name;
  String? symbol;
  String? method;
  String? decimal;

  Activity copyWith({
    String? blockHash,
    String? blockNumber,
    String? confirmations,
    String? contractAddress,
    String? cumulativeGasUsed,
    String? from,
    String? gas,
    String? gasPrice,
    String? gasUsed,
    String? hash,
    String? input,
    String? isError,
    String? nonce,
    String? timeStamp,
    String? to,
    String? transactionIndex,
    String? txreceiptStatus,
    String? value,
    String? name,
    String? symbol,
    String? method,
    String? decimal,
  }) =>
      Activity(
          blockHash: blockHash ?? this.blockHash,
          blockNumber: blockNumber ?? this.blockNumber,
          confirmations: confirmations ?? this.confirmations,
          contractAddress: contractAddress ?? this.contractAddress,
          cumulativeGasUsed: cumulativeGasUsed ?? this.cumulativeGasUsed,
          from: from ?? this.from,
          gas: gas ?? this.gas,
          gasPrice: gasPrice ?? this.gasPrice,
          gasUsed: gasUsed ?? this.gasUsed,
          hash: hash ?? this.hash,
          input: input ?? this.input,
          isError: isError ?? this.isError,
          nonce: nonce ?? this.nonce,
          timeStamp: timeStamp ?? this.timeStamp,
          to: to ?? this.to,
          transactionIndex: transactionIndex ?? this.transactionIndex,
          txreceiptStatus: txreceiptStatus ?? this.txreceiptStatus,
          value: value ?? this.value,
          name: name,
          method: method,
          symbol: symbol,
          decimal : decimal
          
          );

  factory Activity.fromJson(Map<String, dynamic> json) {

  
    return Activity(
    
        blockHash: json["blockHash"],
        blockNumber: json["blockNumber"],
        confirmations: json["confirmations"],
        contractAddress: json["contractAddress"],
        cumulativeGasUsed: json["cumulativeGasUsed"],
        from: json["from"],
        gas: json["gas"],
        gasPrice: json["gasPrice"],
        gasUsed: json["gasUsed"],
        hash: json["hash"],
        input: json["input"],
        isError: json["isError"],
        nonce: json["nonce"],
        timeStamp: json["timeStamp"],
        to: json["to"],
        transactionIndex: json["transactionIndex"],
        txreceiptStatus: json["txreceipt_status"] ?? "",
        value: json["value"],
        name: json['tokenName'] ?? "",
        symbol: json['tokenSymbol'] ?? "",
        decimal: json['tokenDecimal'] ?? ""
      );
  }

  Map<String, dynamic> toJson() => {
        "blockHash": blockHash,
        "blockNumber": blockNumber,
        "confirmations": confirmations,
        "contractAddress": contractAddress,
        "cumulativeGasUsed": cumulativeGasUsed,
        "from": from,
        "gas": gas,
        "gasPrice": gasPrice,
        "gasUsed": gasUsed,
        "hash": hash,
        "input": input,
        "isError": isError,
        "nonce": nonce,
        "timeStamp": timeStamp,
        "to": to,
        "transactionIndex": transactionIndex,
        "txreceipt_status": txreceiptStatus,
        "value": value,
      };
}
