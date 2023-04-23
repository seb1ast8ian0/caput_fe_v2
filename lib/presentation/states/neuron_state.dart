import 'dart:developer';

import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/domain/entities/neuron/payload/payloads/Date.dart';
import 'package:Caput/domain/entities/neuron/payload/payloads/Note.dart';
import 'package:Caput/domain/entities/neuron/payload/payloads/Task.dart';
import 'package:Caput/domain/entities/neuron/tag/tag.dart';
import 'package:Caput/infrastructure/neuron_repository_hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:uuid/uuid.dart';

class NeuronState {

  List<Neuron> _neurons = [];
  final PublishSubject _listSubject = PublishSubject<List<Neuron>>();

  Stream get stream => _listSubject.stream;
  List<Neuron> get current => _neurons;
  int get length  => _neurons.length;

  

  cleanUp() async{
    NeuronRepository.deleteNeurons().then((success) {
      if(success){
        _neurons.removeRange(0, _neurons.length);
        _listSubject.add(_neurons);
      }
    });
  }
 
  invoke() async {

    //TODO: löschen, wenn nicht mehr in Entwicklung 
    //>>
    
    //<<

    //getNeuronsFromLocalStorages


    //TODO: löschen, wenn nicht mehr in Entwicklung 
    //>>

    List<Neuron> dummy = [];

    var tagHaushalt = Tag(const Uuid().v4(), "Privat", "Alle Neuronen für den Haushalt, etc");
    var tagArbeit = Tag(const Uuid().v4(), "Arbeit", "Alle Neuronen für die Arbeit");
    var tagUni = Tag(const Uuid().v4(), "Uni", "Alle Neuronen für die Uni");
    var tagWichtig = Tag(const Uuid().v4(), "Wichtig", "Alle wichtigen Neuronen");

    dummy.add(Neuron(const Uuid().v4(), const Uuid().v4(), Task("", false, DateTime.utc(2023, 10, 15), "task", "Saugen", 1), DateTime.now(), [], []));
    dummy.add(Neuron(const Uuid().v4(), const Uuid().v4(), Task("mit body", false, DateTime.now().add(const Duration(seconds: 10)), "task", "Saugen", 1), DateTime.now(), [], []));
    dummy.add(Neuron(const Uuid().v4(), const Uuid().v4(), Note("Ein etwas längerer Body einer Notiz, der auch gerne über mehrere Zeilen gehen darf, um zu testen, wie das ausschaut :)", "note", "Neue Notiz", 3), DateTime.now(), [], [tagWichtig]));
    dummy.add(Neuron(const Uuid().v4(), const Uuid().v4(), Date("Neuer Termin", DateTime.utc(2023, 07, 15), "date", "Prüfungsdatum Mathe", 4), DateTime.now(), [], [tagUni, tagWichtig]));
    dummy.add(Neuron(const Uuid().v4(), const Uuid().v4(), Task("", false, DateTime.now().add(const Duration(seconds: 30)), "task", "Geschirr", 1), DateTime.now(), [], [tagHaushalt]));
    dummy.add(Neuron(const Uuid().v4(), const Uuid().v4(), Note("Ein Body einer Notiz:)", "note", "Neue Notiz", 3), DateTime.now(), [], [tagArbeit]));
    dummy.add(Neuron(const Uuid().v4(), const Uuid().v4(), Note("", "note", "Neue Notiz ohne Body", 3), DateTime.now(), [], []));
    dummy.add(Neuron(const Uuid().v4(), const Uuid().v4(), Note("", "note", "M10\n13 d\nF4\nH12", 3), DateTime.now(), [], []));
    dummy.add(Neuron(const Uuid().v4(), const Uuid().v4(), Date("", DateTime.utc(2023, 07, 15), "date", "Arzttermin", 4), DateTime.now(), [], [tagHaushalt]));

    //<<

    NeuronRepository.addNeurons(dummy).then((success) {
      if(success){
        _neurons = dummy;
        _listSubject.add(_neurons);
      }
    });

    


  }

  add(Neuron neuron) async {
    NeuronRepository.addNeuron(neuron).then((success) {
      if(success){
        _neurons.add(neuron);
        _listSubject.add(_neurons);
      }
    });
  }

  remove(int index) async {

    log(index.toString());

    NeuronRepository.deleteNeuron(index).then((success) {
      if(success){
        _neurons.removeAt(index);
        _listSubject.add(_neurons);
      }
    });

  }

}