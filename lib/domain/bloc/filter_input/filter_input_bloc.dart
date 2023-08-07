import 'dart:developer';

import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'filter_input_event.dart';
part 'filter_input_state.dart';

class FilterInputBloc extends Bloc<FilterInputEvent, FilterInputState> {

  String caption = "New Filter";
  List<Tag> tags = [];
  LogicalOperator tagsOperator = LogicalOperator.or;
  List<NeuronType> neuronTypes = [];
  DateOption dateOption = DateOption.all;

  FilterInputBloc() : super(FilterInputInitial()) {
    
    on<FilterInputEvent>((event, emit) {

    });

    on<FilterInputSetTextEvent>((event, emit) {

      caption = event.caption;

    });

    on<FilterInputClearEvent>((event, emit) {

      caption = "New Filter";
      tags = [];
      tagsOperator = LogicalOperator.or;
      neuronTypes = [];
      dateOption = DateOption.all;

    });

    on<FilterInputSetTagsEvent>((event, emit) {

      tags = event.tags;

    });

    on<FilterInputSetTagsOperatorEvent>((event, emit) {

      tagsOperator = event.operator;

    });

    on<FilterInputSetTypesEvent>((event, emit) {

      neuronTypes = event.types;

    });

    on<FilterInputSetTimeEvent>((event, emit) {

      dateOption = event.dateOption;

    });

    on<FilterInputAddFilterEvent>((event, emit){

      DateTime now = DateTime.now();
      
      Filter emptyFilter = Filter(
        filterId: const Uuid().v4(), 
        userId: "e70b1b88-0b56-4ddf-9319-82480e3c5db7", 
        caption: caption, 
        creationTs: now, 
        updateTs: now, 
        tags: tags, 
        tagsOperator: tagsOperator,
        neuronTypes: neuronTypes, 
        dateOption: dateOption
      );

      log("${emptyFilter.caption} \n" 
          "${emptyFilter.tags} \n"
          "${emptyFilter.tagsOperator} \n"
          "${emptyFilter.neuronTypes} \n"
          "${emptyFilter.dateOption} "
        );

    });
    
  }
}
