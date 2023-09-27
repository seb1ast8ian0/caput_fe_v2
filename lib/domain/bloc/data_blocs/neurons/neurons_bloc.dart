import 'dart:developer';
import 'dart:io';

import 'package:Caput/domain/bloc/data_blocs/neurons/neurons_event.dart';
import 'package:Caput/domain/bloc/data_blocs/neurons/neurons_state.dart';
import 'package:Caput/domain/bloc/data_blocs/tags/tags_bloc.dart';
import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/neuron.dart';
import 'package:Caput/domain/entities/neuron/payload.dart';
import 'package:Caput/domain/entities/neuron/payloads/date.dart';
import 'package:Caput/domain/entities/neuron/payloads/note.dart';
import 'package:Caput/domain/entities/neuron/payloads/task.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/domain/get_models/database_controller.dart';
import 'package:Caput/domain/usecases/neuron/add_neuron_usecase.dart';
import 'package:Caput/domain/usecases/neuron/delete_neuron_usecase.dart';
import 'package:Caput/domain/usecases/neuron/get_neurons_for_filterId_usecase.dart';
import 'package:Caput/domain/usecases/neuron/get_neurons_usecase.dart';
import 'package:Caput/domain/util/query_builder.dart';
import 'package:Caput/infrastructure/database/neuron_database.dart';
import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:path_provider/path_provider.dart';

class NeuronsBloc extends Bloc<NeuronEvent, NeuronState> {

  NeuronsBloc() : super(NeuronState.loading(const [])) {

    on<AddNeuronEvent>((event, emit) async {

      emit(NeuronState.loading(state.neurons));

      AddNeuronUseCase addNeuronUseCase = AddNeuronUseCase();
      List<Neuron> updatedNeurons = List.from(state.neurons);

      final neuron = event.neuron;
      final tagNames = event.tagNames;

      try{

        addNeuronUseCase.execute(neuron, tagNames);
        updatedNeurons.add(neuron);
        emit(NeuronState.success(updatedNeurons));

      } catch (error, stackTrace) {

        log(error.toString(), stackTrace: stackTrace);
        add(DeleteNeuronEvent(neuron.neuronId));
        emit(NeuronState.failure(state.neurons));

      }
      
    });

    on<DeleteNeuronEvent>((event, emit) async {

      emit(NeuronState.loading(state.neurons));

      final neuronId = event.neuronId;
      List<Neuron> updatedNeurons = List.from(state.neurons);
      DeleteNeuronUseCase deleteNeuronUseCase = DeleteNeuronUseCase();

      try{

        await deleteNeuronUseCase.execute(neuronId);

        updatedNeurons.removeWhere((neuron) => neuron.neuronId == neuronId);
        emit(NeuronState.success(updatedNeurons));

      } catch (error, stackTrace) {

        log(error.toString(), stackTrace: stackTrace);
        emit(NeuronState.failure(state.neurons));

      }

    });

    on<GetNeuronsEvent>((event, emit) async {

      emit(NeuronState.loading(state.neurons));

      final DatabaseController c = Get.find();
      final database = c.database;
      
      /** 
      //await database.close();
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File('${dbFolder.path}/db.sqlite');
      await file.delete();
      
      log('${dbFolder.path}/db.sqlite');
      
      */
      
      
      GetNeuronsUseCase getNeuronsUseCase = GetNeuronsUseCase();
      GetNeuronsForFilterIdUseCase getNeuronsForFilterIdUseCase = GetNeuronsForFilterIdUseCase();

      
      try {
        
        String? filterId = event.filterId;
        List<Neuron> neurons = [];

        if(filterId == null){
          neurons = await getNeuronsUseCase.execute();
        } else {
          neurons = await getNeuronsForFilterIdUseCase.execute(filterId);
        }

        emit(NeuronState.success(neurons));     
            
      } catch (error, stackTrace) {
        
        log(error.toString(), stackTrace: stackTrace);
        emit(NeuronState.failure(state.neurons));

      }

    });

  }

}
