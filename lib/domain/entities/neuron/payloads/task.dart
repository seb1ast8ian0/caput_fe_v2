import 'package:Caput/domain/entities/neuron/payload.dart';

class Task extends Payload {

  bool completed;
  DateTime? deadlineTs;

  Task({
    required this.completed,
    required this.deadlineTs, 
    required super.type, 
    required super.caption, 
    required super.priority
  });

}