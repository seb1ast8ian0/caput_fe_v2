import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterInitial()) {
    on<FilterEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
