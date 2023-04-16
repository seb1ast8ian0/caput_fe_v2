import 'package:Caput/caput_app.dart';
import 'package:Caput/domain/entities/Neuron.dart';
import 'package:Caput/domain/entities/Payload.dart';
import 'package:Caput/domain/entities/payloads/Date.dart';
import 'package:Caput/domain/entities/payloads/Link.dart';
import 'package:Caput/domain/entities/payloads/Note.dart';
import 'package:Caput/domain/entities/payloads/Task.dart';
import 'package:Caput/presentation/states/neuron_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

GetIt getIt = GetIt.instance;

void main() async {

  await Hive.initFlutter();
  _registerAdapters();
  getIt.registerSingleton<NeuronState>(NeuronState(), signalsReady: true);
  
  runApp(Caput());
  
}

void _registerAdapters(){

  Hive.registerAdapter(NeuronAdapter());
  Hive.registerAdapter(PayloadAdapter());
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(LinkAdapter());
  Hive.registerAdapter(DateAdapter());
  Hive.registerAdapter(NoteAdapter());

}