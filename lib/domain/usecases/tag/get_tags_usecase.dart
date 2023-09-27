import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/domain/repositories/tag_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/tag_repository.dart';

class GetTagsUseCase {

  late TagRepository tagRepository;

  GetTagsUseCase(){

    tagRepository = TagRepositoryDrift();

  }

  Future<List<Tag>> execute() async {

    return await tagRepository.getTags();
    
  }

}