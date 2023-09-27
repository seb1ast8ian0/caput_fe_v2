import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/neuron.dart';
import 'package:Caput/domain/entities/neuron/payloads/note.dart';
import 'package:Caput/domain/entities/neuron/payloads/task.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {

  group("test filter.matches()", () {

    test("filter should match neuron with OR-tags", () {

      List<Tag> tags = _getTags();

      Filter filter = Filter(
        filterId: const Uuid().v4(), 
        userId: const Uuid().v4(), 
        caption: "test filter", 
        creationTs: DateTime.now(), 
        updateTs: DateTime.now(), 
        tags: tags, 
        tagsOperator: LogicalOperator.or, 
        neuronTypes: [NeuronType.note], 
        dateOption: DateOption.all
      );

      Neuron neuron = Neuron(
        neuronId: const Uuid().v4(), 
        userId: const Uuid().v4(), 
        payload: Note(type: "note", caption: "caption", priority: 1), 
        creationTs: DateTime.now(), 
        updateTs: DateTime.now(), 
        tags: [tags.first]
      );

      expect(true, filter.matches(neuron));

    });

    test("filter should match neuron with no tags", () {

      List<Tag> tags = [];

      Filter filter = Filter(
        filterId: const Uuid().v4(), 
        userId: const Uuid().v4(), 
        caption: "test filter", 
        creationTs: DateTime.now(), 
        updateTs: DateTime.now(), 
        tags: tags, 
        tagsOperator: LogicalOperator.or, 
        neuronTypes: [NeuronType.note], 
        dateOption: DateOption.all
      );

      Neuron neuron = Neuron(
        neuronId: const Uuid().v4(), 
        userId: const Uuid().v4(), 
        payload: Note(type: "note", caption: "caption", priority: 1), 
        creationTs: DateTime.now(), 
        updateTs: DateTime.now(), 
        tags: tags
      );

      expect(true, filter.matches(neuron));

    });

    test("filter should match neuron with AND-tags", () {

      List<Tag> tags = _getTags();

      Filter filter = Filter(
        filterId: const Uuid().v4(), 
        userId: const Uuid().v4(), 
        caption: "test filter", 
        creationTs: DateTime.now(), 
        updateTs: DateTime.now(), 
        tags: tags, 
        tagsOperator: LogicalOperator.and, 
        neuronTypes: [NeuronType.note], 
        dateOption: DateOption.all
      );

      Neuron neuron = Neuron(
        neuronId: const Uuid().v4(), 
        userId: const Uuid().v4(), 
        payload: Note(type: "note", caption: "caption", priority: 1), 
        creationTs: DateTime.now(), 
        updateTs: DateTime.now(), 
        tags: tags
      );

      expect(true, filter.matches(neuron));

    });

    test("filter should match neuron with neuronTypes", () {


      Filter filter = Filter(
        filterId: const Uuid().v4(), 
        userId: const Uuid().v4(), 
        caption: "test filter", 
        creationTs: DateTime.now(), 
        updateTs: DateTime.now(), 
        tags: [], 
        tagsOperator: LogicalOperator.and, 
        neuronTypes: [NeuronType.task], 
        dateOption: DateOption.all
      );

      Neuron neuron = Neuron(
        neuronId: const Uuid().v4(), 
        userId: const Uuid().v4(), 
        payload: Task(completed: false, deadlineTs: DateTime.now(), type: "task", caption: "caption", priority: 1), 
        creationTs: DateTime.now(), 
        updateTs: DateTime.now(), 
        tags: []
      );

      expect(true, filter.matches(neuron));

    });
    
    test("filter should match neuron with today", () {

      Filter filter = Filter(
        filterId: const Uuid().v4(), 
        userId: const Uuid().v4(), 
        caption: "test filter", 
        creationTs: DateTime.now(), 
        updateTs: DateTime.now(), 
        tags: [], 
        tagsOperator: LogicalOperator.and, 
        neuronTypes: [NeuronType.task], 
        dateOption: DateOption.today
      );

      Neuron neuron = Neuron(
        neuronId: const Uuid().v4(), 
        userId: const Uuid().v4(), 
        payload: Task(
          completed: false, 
          deadlineTs: DateTime.now().add(
            const Duration(hours: 2)
          ), 
          type: "task", 
          caption: "caption", 
          priority: 1
        ), 
        creationTs: DateTime.now(), 
        updateTs: DateTime.now(), 
        tags: []
      );

      expect(true, filter.matches(neuron));

    });

    test("filter should match neuron with tomorrow", () {

      Filter filter = Filter(
        filterId: const Uuid().v4(), 
        userId: const Uuid().v4(), 
        caption: "test filter", 
        creationTs: DateTime.now(), 
        updateTs: DateTime.now(), 
        tags: [], 
        tagsOperator: LogicalOperator.and, 
        neuronTypes: [NeuronType.task], 
        dateOption: DateOption.tomorrow
      );

      Neuron neuron = Neuron(
        neuronId: const Uuid().v4(), 
        userId: const Uuid().v4(), 
        payload: Task(
          completed: false, 
          deadlineTs: DateTime.now().add(
            const Duration(days: 1)
          ), 
          type: "task", 
          caption: "caption", 
          priority: 1
        ), 
        creationTs: DateTime.now(), 
        updateTs: DateTime.now(), 
        tags: []
      );

      expect(true, filter.matches(neuron));

    });
    
  
  });
  
}

List<Tag> _getTags(){

  return [
    Tag(
      tagId: const Uuid().v4(), 
      userId: const Uuid().v4(), 
      caption: "tag1", 
      body: "body1", 
      creationTs: DateTime.now(), 
      updateTs: DateTime.now()
    ),
    Tag(
      tagId: const Uuid().v4(), 
      userId: const Uuid().v4(), 
      caption: "tag2", 
      body: "body2", 
      creationTs: DateTime.now(), 
      updateTs: DateTime.now()
    )
  ];

}