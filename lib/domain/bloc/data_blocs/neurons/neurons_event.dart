import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/neuron.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class NeuronEvent {}

class AddNeuronEvent extends NeuronEvent {

  final Neuron neuron;
  final List<String> tagNames;

  AddNeuronEvent(this.neuron, this.tagNames);

}

class DeleteNeuronEvent extends NeuronEvent {

  final String neuronId;

  DeleteNeuronEvent(this.neuronId);

}

class GetNeuronsEvent extends NeuronEvent {

  final String? filterId;

  GetNeuronsEvent({
    required this.filterId
  });

}

class InitNeuronsEvent extends NeuronEvent{}
