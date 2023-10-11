import 'package:isar/isar.dart';
part 'selected_chain.g.dart';

@Collection()
class SelectedChain {
  Id? id = Isar.autoIncrement;
  String? chainId;

  SelectedChain({this.id, this.chainId});
}