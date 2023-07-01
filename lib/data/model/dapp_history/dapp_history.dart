import 'package:isar/isar.dart';
part 'dapp_history.g.dart';

@Collection()
class DappsHistory {
  Id? id = Isar.autoIncrement;
  String? title;
  String? url;
  String? image;

  DappsHistory({this.id, this.title, this.url, this.image});
}