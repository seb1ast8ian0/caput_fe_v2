import 'package:Caput/domain/get_models/database_controller.dart';
import 'package:Caput/domain/repositories/neuron_tag_repository.dart';
import 'package:Caput/infrastructure/database/neuron_database.dart';
import 'package:drift/drift.dart';
import 'package:get/instance_manager.dart';

class NeuronTagRepositoryDrift extends NeuronTagRepository{

  late CaputDatabase database;

  NeuronTagRepositoryDrift(){

    final DatabaseController c = Get.find();
    database = c.database;

  }

  @override
  Future<void> addNeuronTagRelation(String neuronId, String tagId) async {

    await database
      .into(database.neuronTagRelations)
      .insert(
        NeuronTagRelation(
          neuronId: neuronId, 
          tagId: tagId
        ),
        mode: InsertMode.insertOrIgnore
      );

  }

  @override
  Future<void> deleteNeuronTagRelation(String neuronId, String tagId) async {

    await (
      database
        .delete(database.neuronTagRelations)
        ..where(
          (tbl) => (tbl.neuronId.equals(neuronId) & tbl.tagId.equals(tagId))
        )
    ).go();

  }
  
  @override
  Future<List<String>> getTagIds(String neuronId) async {

    final query = database
      .select(database.neuronTagRelations)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );

    final result = await query.get();
    final tagIds = result.map((e) => e.tagId);

    return tagIds.toList();
    
  }
  
  @override
  Future<void> deleteRelationFromNeuronId(String neuronId) async {
    
    await (
      database
        .delete(database.neuronTagRelations)
        ..where(
          (tbl) => (tbl.neuronId.equals(neuronId))
        )
    ).go();

  }

}