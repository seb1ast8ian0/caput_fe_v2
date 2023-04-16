import 'package:Caput/main.dart';
import 'package:Caput/presentation/screens/main_screen/main_screen.dart';
import 'package:Caput/presentation/states/neuron_state.dart';
import 'package:flutter/material.dart';

class Caput extends StatelessWidget{

  Caput({super.key});

  final neuronState = getIt.get<NeuronState>();

  @override
  Widget build(BuildContext context) {

    neuronState.invoke();

    return const MaterialApp(
      title: 'Caput',
      home: MainScreen()
    );
  }
  
}