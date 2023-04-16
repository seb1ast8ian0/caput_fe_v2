import 'package:Caput/domain/entities/Payload.dart';
import 'package:hive/hive.dart';
part 'Date.g.dart';

@HiveType(typeId: 4)
class Date extends Payload {

  @HiveField(4)
  String body;
  @HiveField(5)
  DateTime dateTs;

  Date(this.body, this.dateTs, super.type, super.caption, super.priority);

  @override
  String toString() {
    return dateTs.toString();
  }


}