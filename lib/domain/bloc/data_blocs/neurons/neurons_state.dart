import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:equatable/equatable.dart';

enum NeuronStateStatus{ loading, success, failure }

class NeuronState extends Equatable{

  final NeuronStateStatus status;
  final List<Neuron> neurons;

  const NeuronState(this.status, this.neurons);

  factory NeuronState.loading(List<Neuron> neurons) =>
      NeuronState(NeuronStateStatus.failure, neurons);

  factory NeuronState.success(List<Neuron> neurons) =>
      NeuronState(NeuronStateStatus.success, neurons);

  factory NeuronState.failure(List<Neuron> neurons) =>
      NeuronState(NeuronStateStatus.failure, neurons);
  
  @override
  List<Object?> get props => [status, neurons];
  
}