part of 'neuron_input_bloc.dart';

abstract class NeuronInputEvent extends Equatable {

  const NeuronInputEvent();

  @override
  List<Object> get props => [];
  
}

class NeuronInputAddNeuronEvent extends NeuronInputEvent{

}

class NeuronInputCleanEvent extends NeuronInputEvent{
  
}

class NeuronInputSetTextEvent extends NeuronInputEvent{

    final String text;

    const NeuronInputSetTextEvent(this.text);

}

class NeuronInputSetDateEvent extends NeuronInputEvent{

    final DateTime? date;

    const NeuronInputSetDateEvent(this.date);

}

class NeuronInputSetTypeEvent extends NeuronInputEvent{

    final String type;

    const NeuronInputSetTypeEvent(this.type);

}

class NeuronInputSetTagsEvent extends NeuronInputEvent{

    final List<String> tagNames;

    const NeuronInputSetTagsEvent(this.tagNames);

}



