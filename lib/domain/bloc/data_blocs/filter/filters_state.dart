part of 'filters_bloc.dart';

enum FilterStateStatus{ loading, success, failure }

class FilterState extends Equatable{

  final FilterStateStatus status;
  final List<Filter> filters;

  const FilterState(this.status, this.filters);

  factory FilterState.loading(List<Filter> filters) =>
      FilterState(FilterStateStatus.failure, filters);

  factory FilterState.success(List<Filter> filters) =>
      FilterState(FilterStateStatus.success, filters);

  factory FilterState.failure(List<Filter> filters) =>
      FilterState(FilterStateStatus.failure, filters);
  
  @override
  List<Object?> get props => [status, filters];
  
}
