import 'package:Caput/domain/entities/neuron/payload/Payload.dart';
import 'package:hive/hive.dart';
part 'Task.g.dart';

@HiveType(typeId: 6)
class Task extends Payload {

  @HiveField(4)
  late String body;
  @HiveField(5)
  late bool completed;
  @HiveField(6)
  late DateTime? deadlineTs;

  

  Task(this.body, this.completed, this.deadlineTs, super.type, super.caption, super.priority);

  Task.empty() : super.empty();
  
  @override
  String toString() {
    return completed.toString();
  }

  @override
  Payload copy(){
    return Task(body, completed, deadlineTs, type, caption, priority);
  }


}