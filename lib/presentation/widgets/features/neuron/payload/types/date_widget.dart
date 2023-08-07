import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/domain/entities/neuron/payloads/date.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/util/time/time_formats.dart';
import 'package:Caput/presentation/widgets/features/neuron/neuron_text.dart';
import 'package:Caput/presentation/widgets/features/neuron/status/status_widget.dart';
import 'package:Caput/presentation/widgets/features/neuron/tag/tag_list_widget.dart';
import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget{

  final Neuron neuron;
  final int index;

  const DateWidget({super.key, required this.index, required this.neuron});
  
  @override
  Widget build(BuildContext context) {

  Date date;
  Color highlightColor = CaputColors.colorBlue;
  
  if(neuron.payload is Date){
      date = neuron.payload as Date;
  } else {
    return const Text("error");
  }


  DynamicStatusWidget statusWidget = DynamicStatusWidget(
    defaultColor: CaputColors.colorBlue,
    start: neuron.creationTs, 
    end: date.dateTs, 
    color: CaputColors.colorBlue, 
    onHighlightColorChanged: (color) {
      highlightColor = color;
    }
  );


  String formatedDeadline = date.dateTs == null ? "" : TimeFormats.getNeuronDate(date.dateTs!);
  
  Widget dateContent = IntrinsicHeight(

    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        statusWidget,
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: NeuronText(
                    text: neuron.payload.caption,
                    style: Theme.of(context).textTheme.titleSmall,
                    overflow: TextOverflow.clip,
                ),
                ),
                
                if(formatedDeadline != "")
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatedDeadline,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).chipTheme.labelStyle?.color
                          ),
                        ),
                        //TagListWidget(tags: neuron.tags)
                      ],
                    ),
                  ),
              ],
            )
          ),
        )
      ],
    ),
  );

  return dateContent;

  }

}