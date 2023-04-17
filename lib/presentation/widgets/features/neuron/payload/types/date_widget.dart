import 'package:Caput/domain/entities/Neuron.dart';
import 'package:Caput/domain/entities/payloads/Date.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/features/neuron/status/status_widget.dart';
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
    start: neuron.creationTs, 
    end: date.dateTs, 
    color: CaputColors.colorBlue, 
    onHighlightColorChanged: (color) {
      highlightColor = color;
    }
  );



  String formatedDeadline = "${date.dateTs.day}.${date.dateTs.month}.${date.dateTs.year}";
  
  Widget dateContent = IntrinsicHeight(

    child: Container(
      color: highlightColor.withOpacity(0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          statusWidget,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      neuron.payload.caption,
                      style: Theme.of(context).textTheme.titleSmall
                  ),
                  ),
                  
                  if(date.body != "")
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      child: Text(
                        date.body,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      formatedDeadline,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: CaputColors.colorBlue
                      ),
                    ),
                  ),
                ],
              )
            ),
          )
        ],
      ),
    ),
  );

  return dateContent;

  }

}