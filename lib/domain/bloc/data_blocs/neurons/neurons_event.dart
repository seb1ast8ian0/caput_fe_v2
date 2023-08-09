import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/Neuron.dart';
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

  final Filter? filter;

  GetNeuronsEvent({
    required this.filter
  });

}

class InitNeuronsEvent extends NeuronEvent{}
