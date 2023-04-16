import 'package:Caput/domain/entities/neuron.dart';
import 'package:Caput/domain/entities/payloads/Note.dart';
import 'package:Caput/presentation/util/colors/caput_colors.dart';
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

  String displayTime = neuron.getCreationDateAsString();

  Widget noteContent = IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        
        StaticStatusWidget(CaputColors.colorLightGrey),

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
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: CaputColors.colorTextPrimaryLight
                        ),
                      ),
                      Text(
                        displayTime,
                        style: const TextStyle(
                          fontSize: 10,
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
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: CaputColors.colorTextSecondaryLight
                      ),
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