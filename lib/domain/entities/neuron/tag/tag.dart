import 'package:hive_flutter/hive_flutter.dart';
part 'tag.g.dart';

@HiveType(typeId: 3)
class Tag extends HiveObject{

  @HiveField(1)
  String tagId;

  @HiveField(2)
  String caption;

  @HiveField(3)
  String body;

  Tag(this.tagId, this.caption, this.body);

  @override
  String toString() {
    return caption;
  }


}