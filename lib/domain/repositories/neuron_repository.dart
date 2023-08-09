import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/neuron.dart';

abstract class NeuronRepository{

  Future<void> addNeuron(Neuron neuron);
  Future<void> deleteNeuron(Neuron neuron);
  Future<Neuron> updateNeuron(Neuron neuron);
  Future<Neuron> getNeuron(String neuronId);
  Future<List<Neuron>> getNeurons(Filter? filter);

}