import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/neuron.dart';
import 'package:Caput/domain/entities/neuron/payloads/date.dart';
import 'package:Caput/domain/entities/neuron/payloads/note.dart';
import 'package:Caput/domain/entities/neuron/payloads/task.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/domain/repositories/filter_neuron_repository.dart';
import 'package:Caput/domain/repositories/neuron_repository.dart';
import 'package:Caput/domain/repositories/neuron_tag_repository.dart';
import 'package:Caput/domain/repositories/payload/date_repository.dart';
import 'package:Caput/domain/repositories/payload/note_repository.dart';
import 'package:Caput/domain/repositories/payload/payload_repository.dart';
import 'package:Caput/domain/repositories/payload/task_repositroy.dart';
import 'package:Caput/domain/repositories/tag_repository.dart';
import 'package:Caput/domain/usecases/filter/get_filters_usecase.dart';
import 'package:Caput/infrastructure/repositories/drift/filter_neuron_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/neuron_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/neuron_tag_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/payload/date_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/payload/note_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/payload/payload_repository.dart';
import 'package:Caput/infrastructure/repositories/drift/payload/task_repositroy.dart';
import 'package:Caput/infrastructure/repositories/drift/tag_repository.dart';
import 'package:uuid/uuid.dart';

class AddNeuronUseCase {

  late NeuronRepository _neuronRepository;
  late PayloadRepository _payloadRepository;
  late TaskRepository _taskRepository;
  late NoteRepository _noteRepository;
  late DateRepository _dateRepository;
  late TagRepository _tagRepository;
  late NeuronTagRepository _neuronTagRepository;
  late FilterNeuronRepository _filterNeuronRepository;
  late GetFiltersUsecase _getFiltersUsecase;

  AddNeuronUseCase() {
    _neuronRepository = NeuronRepositoryDrift();
    _payloadRepository = PayloadRepositoryDrift();
    _taskRepository = TaskRepositoryDrift();
    _noteRepository = NoteRepositoryDrift();
    _dateRepository = DateRepositoryDrift();
    _tagRepository = TagRepositoryDrift();
    _neuronTagRepository = NeuronTagRepositoryDrift();
    _filterNeuronRepository = FilterNeuronRepositoryDrift();
    _getFiltersUsecase = GetFiltersUsecase();
  }

  Future<void> execute(Neuron neuron, List<String> tagNames) async {

    final neuronId = neuron.neuronId;
    final payload = neuron.payload;

    await _neuronRepository.addNeuron(neuron);
    await _payloadRepository.addPayload(neuronId, payload);
  
    if (payload is Task) {
      await _taskRepository.addTask(
        neuronId, 
        payload
      );
    } else if (payload is Date) {
      await _dateRepository.addDate(
        neuronId, 
        payload
      );
    } else if (payload is Note) {
      await _noteRepository.addNote(
        neuronId, 
        payload
      );
    } else {
      throw Exception("unsupported payload-type");
    }

    await _addTags(
      tagNames,
      neuron
    );

    await _matchWithFilters(
      neuron
    );

  }

  Future<void> _addTags(List<String> tagNames, Neuron neuron) async {

    for(String tagName in tagNames){

      final cleanTag = tagName.startsWith("#") ? tagName.substring(1) : tagName;
      Tag? tag = await _tagRepository.getTagByCaption(cleanTag);

      if(tag == null){
        var now = DateTime.now();
        tag = Tag(
          tagId: const Uuid().v4(), 
          userId: neuron.userId, 
          caption: cleanTag, 
          body: "", 
          creationTs: now, 
          updateTs: now
        );
        await _tagRepository.addTag(tag);
      }

      await _neuronTagRepository.addNeuronTagRelation(neuron.neuronId, tag.tagId);
      
    }

  }
  
  Future<void> _matchWithFilters(Neuron neuron) async {

    List<Filter> allFilters = await _getFiltersUsecase.execute();

    for(Filter filter in allFilters){
      bool matches = filter.matches(neuron);
      if(matches){
        await _filterNeuronRepository.addFilterNeuronRelation(
          filter.filterId, 
          neuron.neuronId
        );
      }
    }

  }

}
