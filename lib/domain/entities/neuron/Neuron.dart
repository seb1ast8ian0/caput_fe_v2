import 'package:Caput/domain/entities/neuron/payload.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:uuid/uuid.dart';

class Neuron{

  String neuronId;
  String userId;
  Payload payload;
  DateTime creationTs;
  DateTime updateTs;
  List<Tag> tags;

  Neuron({
    required this.neuronId, 
    required this.userId,
    required this.payload, 
    required this.creationTs,
    required this.updateTs,
    required this.tags
  });

}