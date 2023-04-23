import 'package:Caput/domain/entities/neuron/payload/Payload.dart';
import 'package:Caput/domain/interfaces/payload_interface.dart';
import 'package:hive/hive.dart';
part 'Date.g.dart';

@HiveType(typeId: 4)
class Date extends Payload {

  @HiveField(4)
  late String body;
  @HiveField(5)
  late DateTime dateTs;

  Date(this.body, this.dateTs, super.type, super.caption, super.priority);

  Date.empty(): super.empty();

  @override
  String toString() {
    return dateTs.toString();
  }

  @override
  Payload copy(){
    return Date(body, dateTs, type, caption, priority);
  }


}