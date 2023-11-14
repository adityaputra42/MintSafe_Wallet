import 'package:isar/isar.dart';
part 'nft.g.dart';

@Collection()
class Nft {
  Id? id = Isar.autoIncrement;
  String? contractAddress;
  int? tokenId;
  String? chainId;
  String? owner;
  String? name;
  String? imageByte;
  String? description;

  Nft(
      {this.id,
      this.contractAddress,
      this.tokenId,
      this.chainId,
      this.owner,
      this.name,
      this.imageByte,
      this.description});
}
