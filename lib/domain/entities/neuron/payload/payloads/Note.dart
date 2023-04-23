import 'package:Caput/domain/entities/neuron/payload/Payload.dart';
import 'package:hive/hive.dart';
part 'Note.g.dart';

@HiveType(typeId: 5)
class Note extends Payload {

  @HiveField(4)
  late String body;

  Note(this.body, super.type, super.caption, super.priority);

  Note.empty():super.empty();

  @override
  String toString() {
    return body.toString();
  }

  @override
  Payload copy(){
    return Note(body, type, caption, priority);
  }


}