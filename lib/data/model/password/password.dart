import 'package:isar/isar.dart';
part 'password.g.dart';

@Collection()
class Password {
  Id? id = Isar.autoIncrement;
  String? password;

  Password({this.id, this.password});
}