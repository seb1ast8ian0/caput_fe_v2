import 'package:hive_flutter/hive_flutter.dart';
part 'media.g.dart';

@HiveType(typeId: 7)
class Media extends HiveObject{

  @HiveField(1)
  String mediaId;

  @HiveField(2)
  String type;

  Media(this.mediaId, this.type);

  @override
  String toString() {
    return type.toString();
  }
  

}