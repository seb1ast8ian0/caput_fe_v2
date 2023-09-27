import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/neuron.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/domain/repositories/filter_neuron_repository.dart';
import 'package:Caput/domain/repositories/filter_repository.dart';
import 'package:Caput/domain/repositories/filter_tag_repository.dart';
import 'package:Caput/domain/usecases/neuron/get_neurons_usecase.dart';
import 'package:Caput/infrastructure/repositories/drift/filter_neuron_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/filter_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/filter_tag_repository.dart';

class AddFilterUsecase{

  late FilterRepository _filterRepository;
  late FilterTagRepository _filterTagRepository;
  late FilterNeuronRepository _filterNeuronRepository;
  late GetNeuronsUseCase _getNeuronsUseCase;

  AddFilterUsecase() {
    _filterRepository = FilterRepositoryDrift();
    _filterTagRepository = FilterTagRepositoryDrift();
    _filterNeuronRepository = FilterNeuronRepositoryDrift();
    _getNeuronsUseCase = GetNeuronsUseCase();
  }

  void execute(Filter filter) async {

    // Filter über FilterRepo hinzufügen
    _addFilterToFilterRepo(filter);
    
    // Tags über FilterTagRepo hinzufügen
    _addTagsToTagRepo(filter.filterId, filter.tags);

    // Alle Neuronen über Neuron Repo abrufen und durchiterieren. Über filter.match() prüfen, ob Neuron passt
    // Für passendes Neuron -> NeuronFilterRelation hinzufügen
    _matchWithNeurons(filter);

  }

  void _addFilterToFilterRepo(Filter filter) async {

    await _filterRepository.addFilter(filter);

  }

  _addTagsToTagRepo(String filterId, List<Tag> tags) async {

    for(Tag tag in tags){
      await _filterTagRepository.addFilterTagRelation(filterId, tag.tagId);
    }

  }

  void _matchWithNeurons(Filter filter) async {

    //match with neurons
    List<Neuron> allNeurons = await _getNeuronsUseCase.execute();

    for(Neuron neuron in allNeurons){
      bool matches = filter.matches(neuron);
      if(matches){
        _filterNeuronRepository.addFilterNeuronRelation(
          filter.filterId, 
          neuron.neuronId
        );
      }
    }

  }

}