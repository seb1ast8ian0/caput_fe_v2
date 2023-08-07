import 'package:Caput/domain/bloc/neurons/neurons_bloc.dart';
import 'package:Caput/domain/bloc/neurons/neurons_event.dart';
import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/presentation/widgets/features/neuron/neuron_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NeuronBuilder extends StatefulWidget{

  final List<Neuron> neurons;
  final ScrollController scrollController;

  const NeuronBuilder({super.key, required this.neurons, required this.scrollController});

  @override
  State<NeuronBuilder> createState() => _NeuronBuilderState();

}

class _NeuronBuilderState extends State<NeuronBuilder> {
  
  _NeuronBuilderState();

  @override
  Widget build(BuildContext context) {

    NeuronsBloc neuronsBloc = context.read<NeuronsBloc>();
    List<Neuron> neurons = widget.neurons;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scrollbar(
        controller: widget.scrollController,
        interactive: true,
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: widget.scrollController,
          reverse: true,
          itemCount: neurons.length,
          padding: const EdgeInsets.only(bottom: 8, top: kToolbarHeight * 2, left: 4, right: 0),
          itemBuilder: (context, index){
            bool last = neurons.length - 1  == index;
            int i = neurons.length - index - 1;
            return Dismissible(
              key: Key(neurons[i].neuronId),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                neuronsBloc.add(DeleteNeuronEvent(neurons[i].neuronId));
              },
              background: Container(
                  color: Colors.red,
                  child: Align(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children:[
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        Text(
                          " Löschen",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ),
              child: NeuronWidget(
                index: i,
                last: last,
                neuron: neurons[i]
              ),
            );
          } 
        ),
      ),
    );
  }
}