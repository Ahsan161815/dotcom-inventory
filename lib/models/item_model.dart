import 'package:hive/hive.dart';
part 'item_model.g.dart';

@HiveType(typeId: 0)
class Item extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int qty;

  Item({required this.name, required this.qty});
}
