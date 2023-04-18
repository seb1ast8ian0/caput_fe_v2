import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/domain/entities/neuron/payload/payloads/Note.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/features/neuron/status/status_widget.dart';
import 'package:Caput/presentation/widgets/features/neuron/tag/tag_list_widget.dart';
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

  String displayTime = neuron.getCreationDateAsString();
  Color highlightColor = 
        Theme.of(context).brightness == Brightness.dark 
            ? CaputColors.colorLightGrey.withOpacity(0.4) 
            : CaputColors.colorLightGrey;

  Widget noteContent = IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        
        StaticStatusWidget(highlightColor),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.caption,
                        style: Theme.of(context).textTheme.titleSmall
                      ),
                      Text(
                        displayTime,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: CaputColors.colorTextSecondaryLight
                        ),
                        )
                    ],
                  ),
                ),
                
                if(note.body != "")
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Text(
                      note.body,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 1),
                //   child: Text(
                //     note.body,
                //     style: const TextStyle(
                //       fontSize: 12,
                //       fontWeight: FontWeight.w400,
                //       color: CaputColors.colorTextSecondaryLight
                //     ),
                //   ),
                // ),
                const SizedBox(height: 2),
                TagListWidget(tags: neuron.tags)
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