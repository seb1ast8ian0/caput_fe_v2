import 'dart:developer';

import 'package:Caput/domain/bloc/neurons/neurons_bloc.dart';
import 'package:Caput/domain/bloc/neurons/neurons_event.dart';
import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/domain/entities/neuron/payload.dart';
import 'package:Caput/domain/entities/neuron/payloads/date.dart';
import 'package:Caput/domain/entities/neuron/payloads/note.dart';
import 'package:Caput/domain/entities/neuron/payloads/task.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/presentation/widgets/features/textfield/caput_text_field.dart';
import 'package:equatable/equatable.dart';
import 'package:faker/faker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'neuron_input_event.dart';
part 'neuron_input_state.dart';

class NeuronInputBloc extends Bloc<NeuronInputEvent, NeuronInputState> {

  NeuronsBloc neuronsBloc;
  DateTime? date;
  String text = "";
  String type = "note";
  List<String> tagNames = [];

  NeuronInputBloc({required this.neuronsBloc}) : super(NeuronInputInitial()) {

    on<NeuronInputEvent>((event, emit) {

    });

    on<NeuronInputSetTextEvent>((event, emit) {

      final words = CaputTextFieldController.parseText(event.text);
      final tags = CaputTextFieldController.getTagNames(words);

      text = event.text;
      tagNames = tags;
      
    });

    on<NeuronInputSetDateEvent>((event, emit) {

      date = event.date;

    });

    on<NeuronInputSetTypeEvent>((event, emit) {

      type = event.type;

    });

    on<NeuronInputSetTagsEvent>((event, emit) {
      
      tagNames = event.tagNames;

    });

    on<NeuronInputAddNeuronEvent>((event, emit) async {


      emit(NeuronInputLoading());

      String userId = "e70b1b88-0b56-4ddf-9319-82480e3c5db7";
      DateTime now = DateTime.now();

      Payload payload = Note(type: "note", caption: text, priority: 1);

      switch(type) {
        case "date":
          payload = Date(dateTs: date, type: type, caption: text, priority: 1);
          break;
        case "task":
          payload = Task(completed: false, deadlineTs: date, type: type, caption: text, priority: 1);
          break;
      }

      Neuron neuron = Neuron(
        neuronId: const Uuid().v4().toString(), 
        userId: userId,
        payload: payload,
        creationTs: now, 
        updateTs: now, 
        tags: []
      );

      try{

        neuronsBloc.add(AddNeuronEvent(neuron, tagNames));
        emit(NeuronInputSuccess(neuron));

      } catch (error){

        emit(NeuronInputError(error.toString()));

      }


    });

    on<NeuronInputCleanEvent>(((event, emit) async {

      date = null;
      text = "";
      type = "note";
      tagNames = [];

      emit(NeuronInputClean(DateTime.now()));

    }));

  }

  static List<Tag> getRandomTags(){

    //Random random = Random();
    String userId = "e70b1b88-0b56-4ddf-9319-82480e3c5db7";
    DateTime now = DateTime.now();

    List<Tag> seedTags = [];
    List<Tag> tags = [];

    seedTags.add(Tag(tagId: "69680318-a67d-46d2-b91b-4b2f30482cde", userId: userId, creationTs: now, updateTs: now, caption: "arbeit", body: "Tag für alles was Arbeit betrifft"));
    seedTags.add(Tag(tagId: "d4bcd044-eeb6-4122-8f91-2b9a6fc33d8a", userId: userId, creationTs: now, updateTs: now, caption: "uni", body: "Tag für alles was Uni betrifft"));
    seedTags.add(Tag(tagId: "e70b1b88-0b36-4ddf-9317-82480e3c5db6", userId: userId, creationTs: now, updateTs: now, caption: "work", body: "Tag für alles was Work betrifft"));
    seedTags.add(Tag(tagId: "64b7d436-4d70-44fe-b036-a3ed58ad544f", userId: userId, creationTs: now, updateTs: now, caption: "freizeit", body: "Tag für alles was Freizeit betrifft"));
    seedTags.add(Tag(tagId: "1798969e-6da0-4cf8-9aa7-ebdffa1d4532", userId: userId, creationTs: now, updateTs: now, caption: "dj", body: "Tag für alles was DJ betrifft"));

    
    /*for(int i = 0; i < random.nextInt(5); i++){
      tags.add(seedTags.elementAt(random.nextInt(seedTags.length)));
    }*/

    final faker = Faker();

    List<Payload> seedPayload = [];

    seedPayload.add(Note(type: "note", caption: faker.lorem.sentence(), priority: 1));
    seedPayload.add(Task(completed: false, deadlineTs: now.add(const Duration(days: 3)), type: "task", caption: faker.lorem.sentence(), priority: 1));
    seedPayload.add(Date(dateTs: now.add(const Duration(days: 20)), type: "date", caption: faker.lorem.sentence(), priority: 1));

    /*
    Neuron neuron = Neuron(
      neuronId: const Uuid().v4().toString(), 
      userId: userId,
      payload: seedPayload.elementAt(random.nextInt(3)),
      creationTs: DateTime.now(), 
      updateTs: DateTime.now(), 
      tags: tags
    );
    */

    return tags;
    
  }
 
}
