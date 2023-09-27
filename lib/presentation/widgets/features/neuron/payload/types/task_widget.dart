import 'package:Caput/domain/entities/neuron/neuron.dart';
import 'package:Caput/domain/entities/neuron/payloads/task.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/util/time/time_formats.dart';
import 'package:Caput/presentation/widgets/features/neuron/neuron_button.dart';
import 'package:Caput/presentation/widgets/features/neuron/neuron_text.dart';
import 'package:Caput/presentation/widgets/features/neuron/status/status_widget.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget{

  final Neuron neuron;
  final int index;
  
  const TaskWidget({super.key, required this.index, required this.neuron});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {

  Color highlightColor = CaputColors.colorBlue;

  @override
  void initState() {
    
    super.initState();
    highlightColor = Colors.transparent;
    
  }


  @override
  Widget build(BuildContext context) {

  Task task;
  
  if(widget.neuron.payload is Task){
    task = widget.neuron.payload as Task;
  } else {
    return const Text("error");
  }

  String formatedDeadline = task.deadlineTs == null ? "" : TimeFormats.getNeuronDate(task.deadlineTs!);

  Color defaultColor = 
        Theme.of(context).brightness == Brightness.dark 
            ? CaputColors.colorLightGrey.withOpacity(0.4) 
            : CaputColors.colorLightGrey;

  Widget taskContent = IntrinsicHeight(
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DynamicStatusWidget(
          defaultColor: defaultColor,
          start: widget.neuron.creationTs, 
          end: task.deadlineTs, 
          onHighlightColorChanged: (color) {
            setState(() {
              highlightColor = color;
            });
          }
        ),
          
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
                    text: task.caption,
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
                        //TagListWidget(tags: widget.neuron.tags)
                      ],
                    ),
                  ),
                
              ],
            )
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: NeuronCheckButton(index: widget.index),
          )
        ),
      ],
    ),
  );

  return taskContent;

  }
}