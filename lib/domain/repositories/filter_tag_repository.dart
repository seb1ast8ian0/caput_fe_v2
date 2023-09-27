abstract class FilterTagRepository{
  
  Future<void> addFilterTagRelation(String filterId, String tagId);
  Future<void> deleteFilterTagRelation(String filterId, String tagId);
  Future<void> deleteRelationFromFilterId(String filterId);
  Future<List<String>> getTagIds(String filterId);

}