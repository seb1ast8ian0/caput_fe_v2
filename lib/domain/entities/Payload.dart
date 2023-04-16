import 'package:hive/hive.dart';
part 'Payload.g.dart';

@HiveType(typeId: 2)
class Payload extends HiveObject{

  @HiveField(1)
  String type;
  @HiveField(2)
  String caption;
  @HiveField(3)
  int priority;

  Payload(this.type, this.caption, this.priority);

  @override
  String toString() {
    return type;
  }


}