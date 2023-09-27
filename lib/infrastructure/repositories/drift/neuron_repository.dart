
import 'package:Caput/domain/entities/neuron/neuron.dart';
import 'package:Caput/domain/entities/neuron/payloads/note.dart';
import 'package:Caput/domain/get_models/database_controller.dart';
import 'package:Caput/domain/repositories/neuron_repository.dart';
import 'package:Caput/infrastructure/database/neuron_database.dart';
import 'package:get/get.dart';

class NeuronRepositoryDrift extends NeuronRepository{

  late CaputDatabase database;

  NeuronRepositoryDrift(){

    final DatabaseController c = Get.find();
    database = c.database;

  }

  @override
  Future<void> addNeuron(Neuron neuron) async {

    await database
      .into(database.neurons)
      .insert(
        NeuronDBO(neuronId: neuron.neuronId, userId: neuron.userId, creationTs: neuron.creationTs, updateTs: neuron.updateTs)
      );

  }

  @override
  Future<void> deleteNeuron(String neuronId) async {

    final query = database
      .delete(database.neurons)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );

    await query.go();

  }
  
  @override
  Future<Neuron> getNeuron(String neuronId) async {

    final query = database
      .select(database.neurons)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );

    final result = await query.getSingle();
    
    return getNeuronFromDBO(result);
      
  }
  
  @override
  Future<List<Neuron>> getNeurons() async {

    final query = database
      .select(database.neurons);

    final result = await query.get();
    
    return result.map((e) => getNeuronFromDBO(e)).toList();
     
  }
  
  @override
  Future<void> updateNeuron(Neuron neuron) async {

    final query = database
      .update(database.neurons)
      ..where(
        (tbl) => tbl.neuronId.equals(neuron.neuronId)
      );
      
      await query.write(
      NeuronDBO(
        neuronId: neuron.neuronId, 
        userId: neuron.userId, 
        creationTs: neuron.creationTs, 
        updateTs: neuron.updateTs
      )
    );
      
  }

  Neuron getNeuronFromDBO(NeuronDBO neuronDBO){
    return Neuron(
      neuronId: neuronDBO.neuronId, 
      userId: neuronDBO.userId, 
      payload: Note(
        caption: '',
        priority: 1,
        type: 'note'
      ), 
      creationTs: neuronDBO.creationTs, 
      updateTs: neuronDBO.updateTs, 
      tags: []
    );
  }

  /*

  Future<void> _insertPayload(Payload payload, String neuronId) async {

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
  
  */
  
}