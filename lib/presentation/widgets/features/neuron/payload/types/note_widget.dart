import 'package:Caput/domain/entities/neuron/neuron.dart';
import 'package:Caput/domain/entities/neuron/payloads/note.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/util/time/time_formats.dart';
import 'package:Caput/presentation/widgets/features/neuron/neuron_text.dart';
import 'package:Caput/presentation/widgets/features/neuron/status/status_widget.dart';
import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget{

  final Neuron neuron;
  final int index;
  

  const NoteWidget({super.key, required this.index, required this.neuron});
  
  @override
  Widget build(BuildContext context) {

  Note note;
  
  if(neuron.payload is Note){
      note = neuron.payload as Note;
  } else {
    return const Text("error");
  }

  String displayTime = TimeFormats.getNeuronDate(neuron.creationTs);
  Color highlightColor = 
        Theme.of(context).brightness == Brightness.dark 
            ? CaputColors.colorLightGrey.withOpacity(0.4) 
            : CaputColors.colorLightGrey;

  Widget noteContent = IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        
        StaticStatusWidget(highlightColor),
        
        const SizedBox(width: 4),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: NeuronText(
                        text: neuron.payload.caption,
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4
                ),
                Row(
                  children: [
                    Text(
                      displayTime,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: CaputColors.colorTextSecondaryLight
                      ),
                    ),
                  ],
                ),
              ],
            )
          ),
        )
        
      ],
    ),

  );


  return noteContent;

  }

}