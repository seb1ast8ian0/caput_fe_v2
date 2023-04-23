import 'package:hive/hive.dart';

@HiveType(typeId: 2)
abstract class Payload extends HiveObject{

  @HiveField(1)
  late String type;
  @HiveField(2)
  late String caption;
  @HiveField(3)
  late int priority;

  Payload(this.type, this.caption, this.priority);

  Payload.empty() : super();

  @override
  String toString() {
    return type;
  }

  Payload copy();

}