import 'package:Caput/domain/entities/neuron/tag.dart';

abstract class TagRepository{

  Future<void> addTag(Tag tag);
  Future<void> deleteTag(Tag tag);
  Future<Tag> updateTag(Tag tag);
  Future<Tag> getTag(String tagId);
  Future<List<Tag>> getTags();

}