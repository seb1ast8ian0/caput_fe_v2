import 'package:Caput/domain/entities/neuron/payload.dart';
import 'package:Caput/domain/entities/neuron/payloads/note.dart';
import 'package:Caput/domain/get_models/database_controller.dart';
import 'package:Caput/domain/repositories/payload/payload_repository.dart';
import 'package:Caput/infrastructure/database/neuron_database.dart';
import 'package:get/get.dart';

class PayloadRepositoryDrift extends PayloadRepository{

  late CaputDatabase database;

  PayloadRepositoryDrift(){

    final DatabaseController c = Get.find();
    database = c.database;

  }

  @override
  Future<void> addPayload(String neuronId, Payload payload) async {
    
    await database
      .into(database.payloads)
      .insert(
        PayloadDBO(
          neuronId: neuronId, 
          type: payload.type, 
          caption: payload.caption, 
          priority: payload.priority
        )
      );

  }

  @override
  Future<void> deletePayload(String neuronId) async {
    
    final query = database
      .delete(database.payloads)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );

    await query.go();
      
  }

  @override
  Future<Payload> getPayload(String neuronId) async {

    final query = database
      .select(database.payloads)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );

    final result = await query.getSingle();

    
    
    return Note(
      caption: result.caption,
      priority: result.priority,
      type: result.type
    );

  }

  @override
  Future<void> updatePayload(String neuronId, Payload updatedPayload) async {

    final query = database
      .update(database.payloads)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );
      
      await query.write(
      PayloadDBO(
        neuronId: neuronId, 
        type: updatedPayload.type, 
        caption: updatedPayload.caption, 
        priority: updatedPayload.priority
      )
    );

  }

}