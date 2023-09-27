import 'package:Caput/domain/get_models/database_controller.dart';
import 'package:Caput/domain/repositories/filter_neuron_repository.dart';
import 'package:Caput/infrastructure/database/neuron_database.dart';
import 'package:drift/drift.dart';
import 'package:get/get.dart';

class FilterNeuronRepositoryDrift extends FilterNeuronRepository{

  late CaputDatabase database;

  FilterNeuronRepositoryDrift(){

    final DatabaseController c = Get.find();
    database = c.database;

  }


  @override
  Future<void> addFilterNeuronRelation(String filterId, String neuronId) async {

    await database
      .into(database.filterNeuronRelations)
      .insert(
        FilterNeuronRelation(
          filterId: filterId, 
          neuronId: neuronId
        ),
        mode: InsertMode.insertOrIgnore
      );

  }

  @override
  Future<void> deleteFilterNeuronRelation(String filterId, String neuronId) async {

    await (
      database
        .delete(database.filterNeuronRelations)
        ..where(
          (tbl) => (tbl.filterId.equals(filterId) & tbl.neuronId.equals(neuronId))
        )
    ).go();
      
  }

  @override
  Future<List<String>> getNeuronIds(String filterId) async {
    
    final query = database
      .select(database.filterNeuronRelations)
      ..where(
        (tbl) => tbl.filterId.equals(filterId)
      );

    final result = await query.get();
    final neuronIds = result.map((e) => e.neuronId);

    return neuronIds.toList();

  }
  
  @override
  Future<void> deleteRelationFromFilterId(String filterId) async {

    await (
      database
        .delete(database.filterNeuronRelations)
        ..where(
          (tbl) => (tbl.filterId.equals(filterId))
        )
    ).go();
    
  }

  @override
  Future<void> deleteRelationFromNeuronId(String neuronId) async {

    await (
      database
        .delete(database.filterNeuronRelations)
        ..where(
          (tbl) => (tbl.neuronId.equals(neuronId))
        )
    ).go();
    
  }


  

}