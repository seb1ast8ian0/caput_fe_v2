import 'package:Caput/domain/entities/neuron/payload.dart';

class Date extends Payload {

  DateTime? dateTs;

  Date({
    required this.dateTs, 
    required super.type, 
    required super.caption, 
    required super.priority
  });
  
}