import 'dart:developer';

import 'package:Caput/domain/bloc/data_blocs/neurons/neurons_event.dart';
import 'package:Caput/domain/bloc/data_blocs/neurons/neurons_state.dart';
import 'package:Caput/domain/bloc/data_blocs/tags/tags_bloc.dart';
import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/domain/entities/neuron/payload.dart';
import 'package:Caput/domain/entities/neuron/payloads/date.dart';
import 'package:Caput/domain/entities/neuron/payloads/note.dart';
import 'package:Caput/domain/entities/neuron/payloads/task.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/domain/get_models/database_controller.dart';
import 'package:Caput/domain/util/query_builder.dart';
import 'package:Caput/infrastructure/database/neuron_database.dart';
import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class NeuronsBloc extends Bloc<NeuronEvent, NeuronState> {

  NeuronsBloc() : super(NeuronState.loading(const [])) {

    on<AddNeuronEvent>((event, emit) async {

      emit(NeuronState.loading(state.neurons));

      final neuron = event.neuron;
      final tagNames = event.tagNames;

      try {

        await insertNeuron(event.neuron);
        final tags = await TagsBloc.insertTagsForNeuron(tagNames, neuron);
        
        List<Neuron> updatedNeurons = List.from(state.neurons);

        neuron.tags = tags;

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

      try{

        await deleteNeuron(neuronId).then((value) async {

          await deleteNeuronTagRelation(neuronId).then((value) {

            updatedNeurons.removeWhere((neuron) => neuron.neuronId == neuronId);
            emit(NeuronState.success(updatedNeurons));

          });

        });
        
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
      await database.close();
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      await file.delete();
      */

      
      try {

        final List<Neuron> neurons;

        if (event.filter == null) {
          neurons = await getNeurons();
        } else {
          neurons = await getNeuronsFromFilter(event.filter!);
        }
        
        emit(NeuronState.success(neurons));
          
            
      } catch (error, stackTrace) {
        
        log(error.toString(), stackTrace: stackTrace);
        emit(NeuronState.failure(state.neurons));

      }

    },);

  }

  //DATABASE

  static Future<void> insertNeuron(Neuron neuron) async {

    final DatabaseController c = Get.find();
    final database = c.database;

    await database
      .into(database.neurons)
      .insert(
        NeuronDBO(neuronId: neuron.neuronId, userId: neuron.userId, creationTs: neuron.creationTs, updateTs: neuron.updateTs)
      );

    await insertPayload(neuron.payload, neuron.neuronId);

  }

  static Future<void> insertPayload(Payload payload, String neuronId) async {

    final DatabaseController c = Get.find();
    final database = c.database;

    await database
      .into(database.payloads)
      .insert(PayloadDBO(
        neuronId: neuronId, 
        type: payload.type, 
        caption: payload.caption, 
        priority: payload.priority
      ));


    if(payload is Note){

      await database
        .into(database.notes)
        .insert(NoteDBO(neuronId: neuronId));

    } else if (payload is Date){

      DateTime? date = payload.dateTs?.toLocal();

      await database
        .into(database.dates)
        .insert(DateDBO(neuronId: neuronId, dateTs: getDateTimeWithOffset(date)));

    } else if(payload is Task){

      DateTime? date = payload.deadlineTs?.toLocal();

      await database
        .into(database.tasks)
        .insert(TaskDBO(neuronId: neuronId, dateTs: getDateTimeWithOffset(date), completed: payload.completed));

    }
  }

  static Future<void> deleteNeuron(String neuronId) async {

    final DatabaseController c = Get.find();
    final database = c.database;

    await (database.delete(database.neurons)..where((t) => t.neuronId.equals(neuronId))).go();

  }

  static Future<void> deleteNeuronTagRelation(String neuronId) async {

    final DatabaseController c = Get.find();
    final database = c.database;

    await (database.delete(database.neuronTagRelations)..where((t) => t.neuronId.equals(neuronId))).go();

  }

  static Future<List<Neuron>> getNeurons() async {

    final DatabaseController c = Get.find();
    final database = c.database;

    List<Neuron> neurons = [];

    final neuronDBOs = await database
      .select(database.neurons).get();
      
    for (var neuronDBO in neuronDBOs) {

      final tags = await getTagsForNeuron(neuronDBO.neuronId);
      final payload = await getPayloadForNeuron(neuronDBO.neuronId);
      final neuron = getNeuronFromDBO(neuronDBO);

      neuron.tags = tags;
      neuron.payload = payload;

      neurons.add(neuron);

    }

    return neurons;

  }

  static Future<List<Neuron>> getNeuronsFromFilter(Filter filter) async {

    List<Neuron> neurons = [];

    final queryRows = await _customSelect(filter);
    //logTest();
      
    for (var row in queryRows) {

      final neuron = getNeuronFromDBO(NeuronDBO(
        neuronId: row.data['neuron_id'], 
        userId: row.data['user_id'], 
        creationTs: getDateTimeFromInt(row.data['creation_ts']), 
        updateTs: getDateTimeFromInt(row.data['update_ts'])
      ));

      final tags = await getTagsForNeuron(neuron.neuronId);
      final payload = await getPayloadForNeuron(neuron.neuronId);
      
      neuron.tags = tags;
      neuron.payload = payload;

      neurons.add(neuron);

    }

    return neurons;

  }

  static Future<List<Tag>> getTagsForNeuron(String neuronId) async {

    final DatabaseController c = Get.find();
    final database = c.database;

    List<Tag> result = [];

    final relations = await (database.select(database.neuronTagRelations)
      ..where((t) => t.neuronId.equals(neuronId)))
      .get();

    for (var relation in relations) {

      final tags = await (database.select(database.tags)
        ..where((t) => t.tagId.equals(relation.tagId)))
        .get();

      for (var tag in tags) {
        result.add(TagsBloc.getTagFromDBO(tag));
      }

    }

    return result;

  }

  static Future<Payload> getPayloadForNeuron(String neuronId) async {

    final DatabaseController c = Get.find();
    final database = c.database;

    final payload = await (database.select(database.payloads)
      ..where((t) => t.neuronId.equals(neuronId)))
      .getSingle();

    if(payload.type == "note"){

      final note = await (database.select(database.notes)
        ..where((t) => t.neuronId.equals(neuronId)))
        .getSingle();

      return Note(type: "note", caption: payload.caption, priority: payload.priority);

    } else if (payload.type == "task"){

      final task = await (database.select(database.tasks)
        ..where((t) => t.neuronId.equals(neuronId)))
        .getSingle();

      DateTime? taskDate = task.dateTs?.toLocal();

      return Task(completed: task.completed, deadlineTs: taskDate, type: payload.type, caption: payload.caption, priority: payload.priority);
      
    } else if (payload.type == "date"){

      final date = await (database.select(database.dates)
        ..where((t) => t.neuronId.equals(neuronId)))
        .getSingle();

      DateTime? dateDate = date.dateTs?.toLocal();

      return Date(dateTs: dateDate, type: payload.type, caption: payload.caption, priority: payload.priority);
      
    } else {

      return Note(type: "note", caption: "", priority: 0);

    }

  }

  //MAPPING

  static Neuron getNeuronFromDBO(NeuronDBO dbo) {

    return Neuron(
      neuronId: dbo.neuronId, 
      userId: dbo.userId, 
      payload: Note(caption: "", priority: 0, type: ""), 
      creationTs: dbo.creationTs, 
      updateTs: dbo.updateTs,
      tags: []
    );

  }

  static DateTime getDateTimeFromInt(int time) {

    return DateTime.fromMillisecondsSinceEpoch(time * 1000);

  }

  static DateTime? getDateTimeWithOffset(DateTime? dateTime) {

    if(dateTime == null){
      return null;
    }

    Duration offset = dateTime.timeZoneOffset;
    return dateTime.subtract(offset);

  }

  //SELECT

  static Future<List<QueryRow>> _customSelect(Filter filter) {

  final DatabaseController c = Get.find();
  final db = c.database;

  Selectable<QueryRow> result = db.customSelect(

    QueryBuilder.buildQuery(filter),
    readsFrom: {
      db.neuronTagRelations, 
      db.neurons,
      db.payloads,
      db.tasks,
      db.dates
    }

  );

  return result.get();

}

  //TESTING

  static Future<void> logTest() async {

    final DatabaseController c = Get.find();
    final database = c.database;

    final relations = await (database.select(database.neuronTagRelations))
      .get();

    for (var relation in relations) {
      
      log("neuronId: ${relation.neuronId} \n"
          "w/ tagId: ${relation.tagId} \n"
          " - ");

    }

  }

}
