import 'package:Caput/domain/entities/neuron/payloads/task.dart';
import 'package:Caput/domain/get_models/database_controller.dart';
import 'package:Caput/domain/repositories/payload/task_repositroy.dart';
import 'package:Caput/infrastructure/database/neuron_database.dart';
import 'package:get/get.dart';

class TaskRepositoryDrift extends TaskRepository{

  late CaputDatabase database;

  TaskRepositoryDrift(){

    final DatabaseController c = Get.find();
    database = c.database;

  }

  @override
  Future<void> addTask(String neuronId, Task task) async {
    
    await database
      .into(database.tasks)
      .insert(
        TaskDBO(
          neuronId: neuronId, 
          completed: task.completed,
          dateTs: task.deadlineTs
        )
      );

  }

  @override
  Future<void> deleteTask(String neuronId) async {
    
    final query = database
      .delete(database.tasks)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );

    await query.go();

  }

  @override
  Future<Task> getTask(String neuronId) async {

    final query = database
      .select(database.tasks)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );

    final result = await query.getSingle();
    
    return Task(
      deadlineTs: result.dateTs,
      completed: result.completed,
      caption: "",
      priority: 1,
      type: "task"
    );

  }

  @override
  Future<void> updateTask(String neuronId, Task updatedTask) async {
    
    final query = database
      .update(database.tasks)
      ..where(
        (tbl) => tbl.neuronId.equals(neuronId)
      );
      
      await query.write(
      TaskDBO(
        neuronId: neuronId, 
        completed: updatedTask.completed,
        dateTs: updatedTask.deadlineTs
      )
    );
      
  }

}