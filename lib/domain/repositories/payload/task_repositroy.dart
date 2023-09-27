
import 'package:Caput/domain/entities/neuron/payloads/task.dart';


abstract class TaskRepository {

  Future<void> addTask(String neuronId, Task task);
  Future<void> deleteTask(String neuronId);
  Future<void> updateTask(String neuronId, Task updatedTask);
  Future<Task> getTask(String neuronId);

}