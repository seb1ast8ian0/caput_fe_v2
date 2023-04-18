import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/domain/entities/neuron/payload/payloads/Task.dart';
import 'package:Caput/presentation/util/consts/caput_colors.dart';
import 'package:Caput/presentation/widgets/features/neuron/neuron_button.dart';
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

  String formatedDeadline = "${task.deadlineTs.day}.${task.deadlineTs.month}.${task.deadlineTs.year}";

  Widget taskContent = IntrinsicHeight(
    child: Container(
      color: highlightColor.withOpacity(0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DynamicStatusWidget(
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
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      widget.neuron.payload.caption,
                      style: Theme.of(context).textTheme.titleSmall
                  ),
                  ),
                  
                  if(task.body != "")
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      child: Text(
                        task.body,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 1),
                    child: Text(
                      formatedDeadline,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: CaputColors.colorTextSecondaryLight
                      ),
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
          )
        ],
      ),
    ),
  );

  return taskContent;

  }
}