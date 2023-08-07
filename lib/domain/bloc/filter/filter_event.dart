part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {

  const FilterEvent();

  @override
  List<Object> get props => [];

}

class AddFilterEvent extends FilterEvent{

  Filter filter;

  AddFilterEvent(this.filter);

}

class DeleteFilterEvent extends FilterEvent{

  String filterId;

  DeleteFilterEvent(this.filterId);

}
