part of 'tags_bloc.dart';

abstract class TagsEvent {}


class AddTagsForNeuronEvent extends TagsEvent{

  final List<String> tags;
  final Neuron neuron;

  AddTagsForNeuronEvent(this.tags, this.neuron);

}

class InitTagsEvent extends TagsEvent{

  InitTagsEvent();

}

