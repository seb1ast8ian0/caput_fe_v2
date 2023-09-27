import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/get_models/database_controller.dart';
import 'package:Caput/domain/repositories/filter_repository.dart';
import 'package:Caput/infrastructure/database/neuron_database.dart';
import 'package:get/get.dart';

class FilterRepositoryDrift extends FilterRepository{

  late CaputDatabase database;

  FilterRepositoryDrift(){

    final DatabaseController c = Get.find();
    database = c.database;

  }

  @override
  Future<void> addFilter(Filter filter) async {
    
    await database
      .into(database.filters)
      .insert(
        FilterDBO(
          filterId: filter.filterId, 
          userId: filter.userId, 
          caption: filter.caption, 
          creationTs: filter.creationTs, 
          updateTs: filter.updateTs, 
          tagsOperator: filter.tagsOperator, 
          dateOption: filter.dateOption, 
          neuronTypes: filter.neuronTypes
        )
      );

  }

  @override
  Future<void> deleteFilter(String filterId) async {

    final query = database
      .delete(database.filters)
      ..where(
        (tbl) => tbl.filterId.equals(filterId)
      );

    await query.go();


  }

  @override
  Future<Filter> getFilter(String filterId) async {

    final query = database
      .select(database.filters)
      ..where(
        (tbl) => tbl.filterId.equals(filterId)
      );

    final result = await query.getSingle();

    return Filter(
      filterId: result.filterId, 
      userId: result.userId, 
      caption: result.caption, 
      creationTs: result.creationTs, 
      updateTs: result.updateTs, 
      tags: [], 
      tagsOperator: result.tagsOperator, 
      neuronTypes: result.neuronTypes, 
      dateOption: result.dateOption
    );

  }

  @override
  Future<List<Filter>> getFilters() async {
    
    final result = await database
      .select(database.filters).get();

    List<Filter> filters = [];

    for (final filterDBO in result){
      filters.add(
        getFilterFromDBO(filterDBO)
      );
    }

    return filters;

  }

  @override
  Future<void> updateFilter(Filter filter) async {

    final query = database
      .update(database.filters)
      ..where(
        (tbl) => tbl.filterId.equals(filter.filterId)
      );
      
    await query.write(
      FilterDBO(
        filterId: filter.filterId, 
        userId: filter.userId, 
        caption: filter.caption, 
        creationTs: filter.creationTs, 
        updateTs: filter.updateTs, 
        tagsOperator: filter.tagsOperator, 
        dateOption: filter.dateOption, 
        neuronTypes: filter.neuronTypes
      )
    );
  }


  Filter getFilterFromDBO(FilterDBO filter){

    return Filter(
      filterId: filter.filterId, 
      userId: filter.userId, 
      caption: filter.caption, 
      creationTs: filter.creationTs, 
      updateTs: filter.updateTs, 
      tags: [], 
      tagsOperator: filter.tagsOperator, 
      neuronTypes: filter.neuronTypes, 
      dateOption: filter.dateOption
    );

  }

}