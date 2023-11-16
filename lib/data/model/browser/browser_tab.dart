import 'package:isar/isar.dart';
part 'browser_tab.g.dart';

@Collection()
class BrowserTab {
  BrowserTab({this.id, this.name, this.url, this.isSelected = false, this.image});

  Id? id = Isar.autoIncrement;
  String? name;
  String? url;
  bool? isSelected;
  String? image;

  BrowserTab copyWith({String? name, String? url, bool? isSelected, String? image}) {
    return BrowserTab(
        id: id,
        isSelected: isSelected ?? this.isSelected,
        name: name ?? this.name,
        url: url ?? this.url,
        image: image ?? this.image
        );
  }
}
