import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/domain/repositories/filter_repository.dart';
import 'package:Caput/domain/repositories/filter_tag_repository.dart';
import 'package:Caput/domain/repositories/tag_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/filter_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/filter_tag_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/tag_repository.dart';

class GetFilterUsecase{

  late FilterRepository _filterRepository;
  late FilterTagRepository _filterTagRepository;
  late TagRepository _tagRepository;

  GetFilterUsecase(){

    _filterRepository = FilterRepositoryDrift();
    _filterTagRepository = FilterTagRepositoryDrift();
    _tagRepository = TagRepositoryDrift();

  }

  Future<Filter> execute(String filterId) async {

    Filter filter = await _filterRepository.getFilter(filterId);
    List<String> tagIds = await _filterTagRepository.getTagIds(filterId);

    for(String tagId in tagIds){
      Tag tag = await _tagRepository.getTag(tagId);
      filter.tags.add(tag);
    }

    return filter;

  }

}