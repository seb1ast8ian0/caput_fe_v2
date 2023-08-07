

import 'package:Caput/domain/entities/neuron/tag.dart';

enum LogicalOperator {
  and, or
}

enum NeuronType{
  note,
  task,
  date
}

enum DateOption{
  today,
  tomorrow,
  oneWeek,
  oneMonth,
  all
}

class Filter {

  String filterId;
  String userId;
  String caption;
  DateTime creationTs;
  DateTime updateTs;
  List<Tag> tags;
  LogicalOperator tagsOperator;
  List<NeuronType> neuronTypes;
  DateOption dateOption;

  Filter({
    required this.filterId,
    required this.userId,
    required this.caption,
    required this.creationTs,
    required this.updateTs,
    required this.tags,
    required this.tagsOperator,
    required this.neuronTypes,
    required this.dateOption
  });

}