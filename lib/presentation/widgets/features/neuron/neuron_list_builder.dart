import 'package:Caput/domain/entities/Neuron.dart';
import 'package:Caput/presentation/widgets/features/neuron/neuron_widget.dart';
import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.only(bottom: 8, top: kToolbarHeight * 2, left: 8, right: 8),
          itemBuilder: (context, index){
            bool last = neurons.length - 1  == index;
            int i = neurons.length - index - 1;
            return NeuronWidget(
              index: i,
              last: last,
              neuron: neurons[i]
            );
          } 
        ),
      ),
    );
  }
}