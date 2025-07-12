import 'package:hive/hive.dart';

part 'favourite.g.dart';

@HiveType(typeId: 0)
class Favourite extends HiveObject {
  @HiveField(0)
  late int newId;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String image;
}
