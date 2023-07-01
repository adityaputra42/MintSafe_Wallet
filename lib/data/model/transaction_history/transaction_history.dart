import 'package:isar/isar.dart';
part 'transaction_history.g.dart';

@Collection()
class TransactionHistory {
  Id? id = Isar.autoIncrement;
  String? txHash;
  String? fromAddress;
  String? toAddress;
  int? nonce;
  double? amount;
  double? networkFee;
  DateTime? date;
  String? address;
  String? contractAddress;
  String? chainId;
  String? status;
  bool isContractInteraction;

  TransactionHistory({
    this.id,
    this.txHash,
    this.fromAddress,
    this.toAddress,
    this.nonce,
    this.amount,
    this.networkFee,
    this.date,
    this.address,
    this.contractAddress,
    this.chainId,
    this.status,
    this.isContractInteraction = false
  });
}