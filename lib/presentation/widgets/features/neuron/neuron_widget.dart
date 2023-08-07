import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/domain/entities/neuron/payloads/date.dart';
import 'package:Caput/domain/entities/neuron/payloads/note.dart';
import 'package:Caput/domain/entities/neuron/payloads/task.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/features/neuron/payload/types/note_widget.dart';
import 'package:Caput/presentation/widgets/features/neuron/payload/types/date_widget.dart';
import 'package:Caput/presentation/widgets/features/neuron/payload/types/task_widget.dart';
import 'package:flutter/material.dart';

class NeuronWidget extends StatelessWidget{

  final bool last;
  final Neuron neuron;
  final int index;

  const NeuronWidget({super.key, required this.index, required this.last, required this.neuron});
  
  @override
  Widget build(BuildContext context) {
  
  Widget neuronWrapper = Padding(
  
    padding: const EdgeInsets.symmetric(vertical:0, horizontal: 0), //h: 16
    child: Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
        /*border: Border.all(
            color: CaputColors.colorLightGrey.withOpacity(0.4),
            width: 0.4,
        ),*/
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          
          
          if(last)
            const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0), 
                child: Text('...', style: TextStyle(fontSize: 24, color: Colors.grey),)
              )
            ),
    
          
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0), //v: 5 
              child: _getWidgetFromType(neuron)
            ),

        ],
      ),
    )
  
  );

  return neuronWrapper;

  }

  Widget _getWidgetFromType(Neuron neuron){

    var payload = neuron.payload;

    if (payload is Task) {
      return TaskWidget(index: index, neuron: neuron);
    } else if (payload is Note) {
      return NoteWidget(index: index, neuron: neuron);
    } else if (payload is Date) {
      return DateWidget(index: index, neuron: neuron);
    } else {
      return const Text("error");
    }

  }


}