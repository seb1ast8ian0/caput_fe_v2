import 'package:Caput/domain/entities/neuron/neuron.dart';

abstract class NeuronRepository{

  Future<void> addNeuron(Neuron neuron);
  Future<void> deleteNeuron(String neuronId);
  Future<void> updateNeuron(Neuron neuron);
  Future<Neuron> getNeuron(String neuronId);
  Future<List<Neuron>> getNeurons();

}