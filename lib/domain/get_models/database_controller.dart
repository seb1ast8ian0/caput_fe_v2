import 'package:Caput/infrastructure/database/neuron_database.dart';
import 'package:drift/drift.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class DatabaseController extends GetxController{

  late CaputDatabase database;

  DatabaseController(QueryExecutor e){

    database = CaputDatabase(e);

  }
  
}