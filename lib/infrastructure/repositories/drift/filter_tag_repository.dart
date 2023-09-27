import 'package:Caput/domain/get_models/database_controller.dart';
import 'package:Caput/domain/repositories/filter_tag_repository.dart';
import 'package:Caput/infrastructure/database/neuron_database.dart';
import 'package:drift/drift.dart';
import 'package:get/instance_manager.dart';

class FilterTagRepositoryDrift extends FilterTagRepository{

  late CaputDatabase database;

  FilterTagRepositoryDrift(){

    final DatabaseController c = Get.find();
    database = c.database;

  }

  @override
  Future<void> addFilterTagRelation(String filterId, String tagId) async {

    await database
      .into(database.filterTagRelations)
      .insert(
        FilterTagRelation(
            filterId: filterId,
            tagId: tagId
        ),
        mode: InsertMode.insertOrIgnore
      );

  }

  @override
  Future<void> deleteFilterTagRelation(String filterId, String tagId) async {

    await (
      database
        .delete(database.filterTagRelations)
        ..where(
          (tbl) => (tbl.filterId.equals(filterId) & tbl.tagId.equals(tagId))
        )
    ).go();
      
  }
  
  @override
  Future<List<String>> getTagIds(String filterId) async {

    final query = database
      .select(database.filterTagRelations)
      ..where(
        (tbl) => tbl.filterId.equals(filterId)
      );

    final result = await query.get();
    final tagIds = result.map((e) => e.tagId);

    return tagIds.toList();
    
  }
  
  @override
  Future<void> deleteRelationFromFilterId(String filterId) async {
    
    await (
      database
        .delete(database.filterTagRelations)
        ..where(
          (tbl) => (tbl.filterId.equals(filterId))
        )
    ).go();

  }


}