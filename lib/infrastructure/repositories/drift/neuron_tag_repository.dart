import 'package:Caput/domain/repositories/neuron_tag_repository.dart';

class NeuronTagRepositoryDrift extends NeuronTagRepository{

  @override
  Future<void> addNeuronTagRelation(String neuronId, String tagId) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteNeuronTagRelation(String neuronId, String tagId) {
    throw UnimplementedError();
  }

}