


import 'package:Caput/domain/entities/neuron/neuron.dart';
import 'package:Caput/domain/entities/neuron/payload.dart';
import 'package:Caput/domain/entities/neuron/payloads/date.dart';
import 'package:Caput/domain/entities/neuron/payloads/note.dart';
import 'package:Caput/domain/entities/neuron/payloads/task.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:equatable/equatable.dart';

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

class Filter extends Equatable{

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

  bool matches(Neuron neuron){

    if(!_matchesTags(neuron.tags)) return false;
    if(!_matchesTypes(neuron.payload.type)) return false;
    if(!_matchesDate(neuron.payload)) return false;

    return true;
    
  }

  bool _matchesTags(List<Tag> neuronTags){

    if(tagsOperator == LogicalOperator.and){

      //case: and
      //wenn neuron ALLE Tags des Filters enthält -> true

      for(final tag in tags){
        
        if(!neuronTags.any((element) => element.tagId == tag.tagId)) return false;

      }

      return true;

    } else if (tagsOperator == LogicalOperator.or){

      //case: or
      //wenn neuron EIN Tag des Filters enthält -> true

      if(tags.isEmpty){
        return true;
      }

      for(final tag in tags){
        
        if(neuronTags.any((neuronTag) => neuronTag.tagId == tag.tagId)) return true;

      }

      return false;

    } else {

      throw UnsupportedError("unknown LogicalOperator");

    }

  }

  bool _matchesTypes(String type){

    return neuronTypes.any((neuronType) {
      //log(neuronType.name + " " + type);
      return neuronType.name == type;
    });

  }

  bool _matchesDate(Payload payload){

    if(payload is Note || dateOption == DateOption.all) return true;

    DateTime? dateTime;

    if(payload is Task) dateTime = payload.deadlineTs;
    if(payload is Date) dateTime = payload.dateTs;

    if(dateTime == null) return false;

    Duration difference = dateTime.difference(DateTime.now());

    if(dateOption == DateOption.today){
      DateTime now = DateTime.now();
      return dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day;
    }

    if(dateOption == DateOption.tomorrow){
      DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
      return dateTime.year == tomorrow.year && dateTime.month == tomorrow.month && dateTime.day == tomorrow.day;
    }
    
    if(dateOption == DateOption.oneWeek) return difference.inDays <= 7;
    if(dateOption == DateOption.oneMonth) return difference.inDays <= 30;
    
    throw UnsupportedError("unknown DateOption");

  }
  
  @override
  List<Object?> get props => [filterId, userId, caption, tags, tagsOperator, neuronTypes, dateOption];

}