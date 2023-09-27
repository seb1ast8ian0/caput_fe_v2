import 'package:Caput/domain/repositories/filter_neuron_repository.dart';
import 'package:Caput/domain/repositories/filter_repository.dart';
import 'package:Caput/domain/repositories/filter_tag_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/filter_neuron_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/filter_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/filter_tag_repository.dart';

class DeleteFilterUsecase{

  late FilterRepository _filterRepository;
  late FilterTagRepository _filterTagRepository;
  late FilterNeuronRepository _filterNeuronRepository;

  DeleteFilterUsecase(){

    _filterRepository = FilterRepositoryDrift();
    _filterTagRepository = FilterTagRepositoryDrift();
    _filterNeuronRepository = FilterNeuronRepositoryDrift();

  }

  Future<void> execute(String filterId) async {

    await _filterRepository.deleteFilter(filterId);
    await _filterTagRepository.deleteRelationFromFilterId(filterId);
    await _filterNeuronRepository.deleteRelationFromFilterId(filterId);

  }

}