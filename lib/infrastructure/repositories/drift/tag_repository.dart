import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/domain/repositories/tag_repository.dart';

class TagRepositoryDrift extends TagRepository{

  @override
  Future<void> addTag(Tag tag) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTag(Tag tag) {
    throw UnimplementedError();
  }

  @override
  Future<Tag> getTag(String tagId) {
    throw UnimplementedError();
  }

  @override
  Future<List<Tag>> getTags() {
    throw UnimplementedError();
  }

  @override
  Future<Tag> updateTag(Tag tag) {
    throw UnimplementedError();
  }

}