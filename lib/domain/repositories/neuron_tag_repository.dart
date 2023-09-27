abstract class NeuronTagRepository{

  Future<void> addNeuronTagRelation(String neuronId, String tagId);
  Future<void> deleteNeuronTagRelation(String neuronId, String tagId);
  Future<void> deleteRelationFromNeuronId(String neuronId);
  Future<List<String>> getTagIds(String neuronId);

}