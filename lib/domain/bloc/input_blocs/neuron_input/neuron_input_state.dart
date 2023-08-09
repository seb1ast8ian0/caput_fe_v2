part of 'neuron_input_bloc.dart';

abstract class NeuronInputState extends Equatable {

  const NeuronInputState();

  @override
  List<Object> get props => [];

}

class NeuronInputInitial extends NeuronInputState {
  // Zustand, wenn der Input-Bloc initialisiert wurde
}

class NeuronInputClean extends NeuronInputState {

  final DateTime date;

  const NeuronInputClean(this.date);

  @override
  List<Object> get props => [date];

}

class NeuronInputLoading extends NeuronInputState {
  // Zustand, wenn ein asynchroner Vorgang (z. B. Daten speichern) stattfindet
}

class NeuronInputSuccess extends NeuronInputState {

  final Neuron neuron;

  const NeuronInputSuccess(this.neuron);

}

class NeuronInputError extends NeuronInputState {

  final String errorMessage;

  const NeuronInputError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class NeuronInputStateWithData extends NeuronInputState {

  final String text;
  final DateTime? date;
  final String type;
  final List<String> tagNames;

  const NeuronInputStateWithData(this.text, this.date, this.type, this.tagNames);

  @override
  List<Object> get props => [text, type];
}

