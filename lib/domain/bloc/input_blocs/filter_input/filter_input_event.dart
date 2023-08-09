part of 'filter_input_bloc.dart';

abstract class FilterInputEvent extends Equatable {

  const FilterInputEvent();

  @override
  List<Object> get props => [];

}

class FilterInputClearEvent extends FilterInputEvent{

}

class FilterInputAddFilterEvent extends FilterInputEvent{
  
}


class FilterInputSetTagsEvent extends FilterInputEvent{

  List<Tag> tags;

  FilterInputSetTagsEvent(this.tags);

}

class FilterInputSetTextEvent extends FilterInputEvent{

  String caption;

  FilterInputSetTextEvent(this.caption);

}

class FilterInputSetTagsOperatorEvent extends FilterInputEvent{

  LogicalOperator operator;

  FilterInputSetTagsOperatorEvent(this.operator);
  
}

class FilterInputSetTypesEvent extends FilterInputEvent{

  List<NeuronType> types;

  FilterInputSetTypesEvent(this.types);
  
}

class FilterInputSetTimeEvent extends FilterInputEvent{

  DateOption dateOption;

  FilterInputSetTimeEvent(this.dateOption);

}