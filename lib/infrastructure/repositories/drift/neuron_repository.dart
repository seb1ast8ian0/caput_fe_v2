import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/neuron.dart';
import 'package:Caput/domain/repositories/neuron_repository.dart';

class NeuronRepositoryDrift extends NeuronRepository{

  @override
  Future<void> addNeuron(Neuron neuron) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteNeuron(Neuron neuron) {
    throw UnimplementedError();
  }

  @override
  Future<Neuron> getNeuron(String neuronId) {
    throw UnimplementedError();
  }

  @override
  Future<List<Neuron>> getNeurons(Filter? filter) {
    throw UnimplementedError();
  }

  @override
  Future<Neuron> updateNeuron(Neuron neuron) {
    throw UnimplementedError();
  }
  
}