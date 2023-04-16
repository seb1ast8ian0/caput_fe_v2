import 'package:Caput/domain/entities/Payload.dart';
import 'package:hive/hive.dart';
part 'Task.g.dart';

@HiveType(typeId: 6)
class Task extends Payload {

  @HiveField(4)
  String body;
  @HiveField(5)
  bool completed;
  @HiveField(6)
  DateTime deadlineTs;


  Task(this.body, this.completed, this.deadlineTs, super.type, super.caption, super.priority);

  @override
  String toString() {
    return completed.toString();
  }


}