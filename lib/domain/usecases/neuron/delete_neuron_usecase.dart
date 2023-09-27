import 'package:Caput/domain/repositories/filter_neuron_repository.dart';
import 'package:Caput/domain/repositories/neuron_repository.dart';
import 'package:Caput/domain/repositories/neuron_tag_repository.dart';
import 'package:Caput/domain/repositories/payload/date_repository.dart';
import 'package:Caput/domain/repositories/payload/note_repository.dart';
import 'package:Caput/domain/repositories/payload/payload_repository.dart';
import 'package:Caput/domain/repositories/payload/task_repositroy.dart';
import 'package:Caput/infrastructure/repositories/drift/filter_neuron_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/neuron_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/neuron_tag_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/payload/date_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/payload/note_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/payload/payload_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/payload/task_repositroy.dart';

class DeleteNeuronUseCase {

  late NeuronRepository _neuronRepository;
  late PayloadRepository _payloadRepository;
  late TaskRepository _taskRepository;
  late NoteRepository _noteRepository;
  late DateRepository _dateRepository;
  late FilterNeuronRepository _filterNeuronRepository;
  late NeuronTagRepository _neuronTagRepository;

  DeleteNeuronUseCase(){

    _neuronRepository = NeuronRepositoryDrift();
    _payloadRepository = PayloadRepositoryDrift();
    _taskRepository = TaskRepositoryDrift();
    _noteRepository = NoteRepositoryDrift();
    _dateRepository = DateRepositoryDrift();
    _filterNeuronRepository = FilterNeuronRepositoryDrift();
    _neuronTagRepository = NeuronTagRepositoryDrift();

  }

  Future<void> execute(String neuronId) async {
    
    await _neuronRepository.deleteNeuron(neuronId);
    await _payloadRepository.deletePayload(neuronId);
    await _taskRepository.deleteTask(neuronId);
    await _noteRepository.deleteNote(neuronId);
    await _dateRepository.deleteDate(neuronId);
    await _filterNeuronRepository.deleteRelationFromNeuronId(neuronId);
    await _neuronTagRepository.deleteRelationFromNeuronId(neuronId);

  }

}