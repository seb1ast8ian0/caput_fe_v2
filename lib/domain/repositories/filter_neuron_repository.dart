abstract class FilterNeuronRepository{

  Future<void> addFilterNeuronRelation(String filterId, String neuronId);
  Future<void> deleteFilterNeuronRelation(String filterId, String neuronId);
  Future<void> deleteRelationFromFilterId(String filterId);
  Future<void> deleteRelationFromNeuronId(String neuronId);
  Future<List<String>> getNeuronIds(String filterId);


}