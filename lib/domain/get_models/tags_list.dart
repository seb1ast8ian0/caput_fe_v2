import 'package:Caput/domain/entities/neuron/tag.dart';

class TagsList{

  List<Tag> tags;

  TagsList(this.tags);

  void addTag(Tag tag){
    tags.add(tag);
  }

  void addTags(List<Tag> t){
    tags.addAll(t);
  }

  void deleteTag(String tagId){
    tags.removeWhere((tag) => tag.tagId == tagId);
  }

  List<Tag> getTags(){
    return tags;
  }

}