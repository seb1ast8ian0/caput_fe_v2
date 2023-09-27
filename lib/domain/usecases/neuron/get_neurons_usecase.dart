import 'package:Caput/domain/entities/neuron/neuron.dart';
import 'package:Caput/domain/entities/neuron/payload.dart';
import 'package:Caput/domain/entities/neuron/payloads/date.dart';
import 'package:Caput/domain/entities/neuron/payloads/note.dart';
import 'package:Caput/domain/entities/neuron/payloads/task.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/domain/repositories/neuron_repository.dart';
import 'package:Caput/domain/repositories/neuron_tag_repository.dart';
import 'package:Caput/domain/repositories/payload/date_repository.dart';
import 'package:Caput/domain/repositories/payload/note_repository.dart';
import 'package:Caput/domain/repositories/payload/payload_repository.dart';
import 'package:Caput/domain/repositories/payload/task_repositroy.dart';
import 'package:Caput/domain/repositories/tag_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/neuron_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/neuron_tag_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/payload/date_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/payload/note_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/payload/payload_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/payload/task_repositroy.dart';
import 'package:Caput/infrastructure/repositories/drift/tag_repository.dart';

class GetNeuronsUseCase {

  late NeuronRepository _neuronRepository;
  late TagRepository _tagRepository;
  late NeuronTagRepository _neuronTagRepository;
  late PayloadRepository _payloadRepository;
  late TaskRepository _taskRepository;
  late NoteRepository _noteRepository;
  late DateRepository _dateRepository;

  GetNeuronsUseCase(){

    _neuronRepository = NeuronRepositoryDrift();
    _tagRepository = TagRepositoryDrift();
    _neuronTagRepository = NeuronTagRepositoryDrift();
    _payloadRepository = PayloadRepositoryDrift();
    _taskRepository = TaskRepositoryDrift();
    _noteRepository = NoteRepositoryDrift();
    _dateRepository = DateRepositoryDrift();

  }

  Future<List<Neuron>> execute() async {

    List<Neuron> allNeurons = await _neuronRepository.getNeurons();

    for(Neuron neuron in allNeurons){
      neuron.payload = await _getPayload(neuron.neuronId);
      neuron.tags.addAll(
        await _getTags(neuron.neuronId)
      );
    }

    return allNeurons;

  }

  Future<Payload> _getPayload(String neuronId) async {

    Payload payload = await _payloadRepository.getPayload(neuronId);

    if(payload.type == "note"){

      final note = await _noteRepository.getNote(neuronId);

      return Note(type: "note", caption: payload.caption, priority: payload.priority);

    } else if (payload.type == "task"){

      final task = await _taskRepository.getTask(neuronId);

      DateTime? taskDate = task.deadlineTs?.toLocal();

      return Task(completed: task.completed, deadlineTs: taskDate, type: payload.type, caption: payload.caption, priority: payload.priority);
      
    } else if (payload.type == "date"){

      final date = await _dateRepository.getDate(neuronId);

      DateTime? dateDate = date.dateTs?.toLocal();

      return Date(dateTs: dateDate, type: payload.type, caption: payload.caption, priority: payload.priority);
      
    } else {

      throw Exception("unsupported payload type");

    }

  }

  Future<List<Tag>> _getTags(String neuronId) async {

    List<Tag> result = [];

    List<String> tagIds = await _neuronTagRepository.getTagIds(neuronId);
    for (String tagId in tagIds) {
      result.add(
        await _tagRepository.getTag(tagId)
      );
    }

    return result;
    
  }

}