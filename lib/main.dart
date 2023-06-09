import 'package:Caput/caput_app.dart';
import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/domain/entities/neuron/media/media.dart';
import 'package:Caput/domain/entities/neuron/media/medias/link.dart';
import 'package:Caput/domain/entities/neuron/payload/payloads/Date.dart';
import 'package:Caput/domain/entities/neuron/payload/payloads/Note.dart';
import 'package:Caput/domain/entities/neuron/payload/payloads/Task.dart';
import 'package:Caput/domain/entities/neuron/tag/tag.dart';
import 'package:Caput/presentation/states/neuron_state.dart';
import 'package:Caput/presentation/states/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

GetIt getIt = GetIt.instance;

void main() async {

  await Hive.initFlutter();
  _registerAdapters();
  getIt.registerSingleton<NeuronState>(NeuronState(), signalsReady: true);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeState())
      ],
      child: Caput(),
    )
  );
  
}

void _registerAdapters(){

  Hive.registerAdapter(NeuronAdapter());
  //Hive.registerAdapter(PayloadAdapter());
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(DateAdapter());
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TagAdapter());
  Hive.registerAdapter(MediaAdapter());
  Hive.registerAdapter(LinkAdapter());

}