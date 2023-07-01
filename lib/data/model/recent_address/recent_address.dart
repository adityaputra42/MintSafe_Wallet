import 'package:isar/isar.dart';
part 'recent_address.g.dart';

@Collection()
class RecentAddress {
  Id? id = Isar.autoIncrement;
  String? address;

  RecentAddress({this.id, this.address});
}