import 'package:isar/isar.dart';

part 'favourite.g.dart';

@Collection()
class Favourite {
  Id id = Isar.autoIncrement;
  late int newId;
  late String name;
  late String image;
}
