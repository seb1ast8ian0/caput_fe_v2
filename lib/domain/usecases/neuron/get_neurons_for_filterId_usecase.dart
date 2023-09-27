
import 'dart:developer';

import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/neuron.dart';
import 'package:Caput/domain/repositories/filter_neuron_repository.dart';
import 'package:Caput/domain/usecases/filter/get_filter_usecase.dart';
import 'package:Caput/domain/usecases/neuron/get_neurons_usecase.dart';
import 'package:Caput/infrastructure/repositories/drift/filter_neuron_repository.dart';

class GetNeuronsForFilterIdUseCase {

  late GetFilterUsecase _getFilterUsecase;
  late GetNeuronsUseCase _getNeuronsUseCase;
  late FilterNeuronRepository _filterNeuronRepository;

  GetNeuronsForFilterIdUseCase(){
    _getFilterUsecase = GetFilterUsecase();
    _getNeuronsUseCase = GetNeuronsUseCase();
    _filterNeuronRepository = FilterNeuronRepositoryDrift();
  }

  Future<List<Neuron>> execute(String filterId) async {

    List<Neuron> result = [];
    List<Neuron> allNeurons = await _getNeuronsUseCase.execute();
    Filter filter = await _getFilterUsecase.execute(filterId);

    log(filter.toString());

    await _filterNeuronRepository.deleteRelationFromFilterId(filterId);

    for(Neuron neuron in allNeurons){
      bool matches = filter.matches(neuron);
      if(matches){
        await _filterNeuronRepository.addFilterNeuronRelation(
          filterId, 
          neuron.neuronId
        );
        result.add(neuron);
      }
    }

    log(result.toString());

    return result;

  }

}