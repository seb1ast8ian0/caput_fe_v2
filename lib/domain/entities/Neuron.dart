import 'package:Caput/domain/entities/Payload.dart';
import 'package:hive/hive.dart';
part 'Neuron.g.dart';

@HiveType(typeId: 1)
class Neuron extends HiveObject{

  @HiveField(1)
  String neuronId;
  @HiveField(2)
  String userId;
  @HiveField(3)
  Payload payload;
  @HiveField(4)
  DateTime creationTs;

  Neuron(this.neuronId, this.userId, this.payload, this.creationTs);


  @override
  String toString() {
    return neuronId;
  }

  String getCreationDateAsString(){

    String minuteString;
    String hourString;
    int minute = creationTs.minute;
    int hour = creationTs.hour;

    if (minute > 9){
      minuteString = minute.toString();
    } else {
      minuteString = "0$minute";
    }

    if (hour > 9){
      hourString = hour.toString();
    } else {
      hourString = "0$hour";
    }
    
    return "$hourString:$minuteString";

  }


}
