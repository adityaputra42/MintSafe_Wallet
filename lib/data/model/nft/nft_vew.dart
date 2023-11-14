import 'nft.dart';

class NftView {
  String? contract;
  String? name;
  int? length;
  String? image;
  String? chainID;
  List<Nft>? listNft;

  NftView({
    this.contract,
    this.name,
    this.image,
    this.chainID,
    this.length,
    this.listNft,
  });
}
