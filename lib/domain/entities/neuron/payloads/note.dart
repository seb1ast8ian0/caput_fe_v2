import 'package:Caput/domain/entities/neuron/payload.dart';

class Note extends Payload {

  Note({
    required super.type, 
    required super.caption, 
    required super.priority
  });

}