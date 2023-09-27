part of 'filters_bloc.dart';

abstract class FilterEvent extends Equatable {

  const FilterEvent();

  @override
  List<Object> get props => [];

}

class AddFilterEvent extends FilterEvent{

  final Filter filter;

  const AddFilterEvent(this.filter);

}

class DeleteFilterEvent extends FilterEvent{

  final String filterId;

  const DeleteFilterEvent(this.filterId);

}

class GetFiltersEvent extends FilterEvent{

  const GetFiltersEvent();

}
