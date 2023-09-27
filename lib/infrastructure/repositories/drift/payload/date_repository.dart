import 'package:Caput/domain/entities/neuron/payloads/date.dart';
import 'package:Caput/domain/get_models/database_controller.dart';
import 'package:Caput/domain/repositories/payload/date_repository.dart';
import 'package:Caput/infrastructure/database/neuron_database.dart';
import 'package:get/get.dart';

class DateRepositoryDrift extends DateRepository{

  late CaputDatabase database;

  DateRepositoryDrift(){

    final DatabaseController c = Get.find();
    database = c.database;

  }

  @override
  Future<void> addDate(String neuronId, Date date) async {

    await database
      .into(database.dates)
      .insert(
        DateDBO(
          neuronId: neuronId,
          dateTs: date.dateTs
        )
      );

  }

  @override
  Future<void> deleteDate(String neuronId) async {
    
    final query = database
      .delete(database.dates)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );

    await query.go();

  }

  @override
  Future<Date> getDate(String neuronId) async {

    final query = database
      .select(database.dates)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );

    final result = await query.getSingle();
    
    return Date(
      caption: "",
      priority: 1,
      type: "date",
      dateTs: result.dateTs
    );

  }

  @override
  Future<void> updateDate(String neuronId, Date updatedDate) async {
    
    final query = database
      .update(database.dates)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );
      
      await query.write(
      DateDBO(
        neuronId: neuronId
      )
    );

  }

}