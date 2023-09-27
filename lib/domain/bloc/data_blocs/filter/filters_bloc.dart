import 'dart:developer';

import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/usecases/filter/add_filter_usecase.dart';
import 'package:Caput/domain/usecases/filter/delete_filter_usecase.dart';
import 'package:Caput/domain/usecases/filter/get_filters_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FilterEvent, FilterState> {
  FiltersBloc() : super(FilterState.loading(const [])) {
    
    on<FilterEvent>((event, emit) {
      
    });

    on<AddFilterEvent>((event, emit) async {

      emit(FilterState.loading(state.filters));

      AddFilterUsecase addFilterUsecase = AddFilterUsecase();
      List<Filter> updatedFilters = List.from(state.filters);

      final filter = event.filter;

      try{

        addFilterUsecase.execute(filter);
        updatedFilters.add(filter);
        emit(FilterState.success(updatedFilters));

      } catch (error, stackTrace) {

        log(error.toString(), stackTrace: stackTrace);
        emit(FilterState.failure(state.filters));

      }

    });

    on<GetFiltersEvent>((event, emit) async {
      
      emit(FilterState.loading(state.filters));

      GetFiltersUsecase getFilterUsecase = GetFiltersUsecase();

      
      try {

        final List<Filter> filters = await getFilterUsecase.execute();
        emit(FilterState.success(filters));     
            
      } catch (error, stackTrace) {
        
        log(error.toString(), stackTrace: stackTrace);
        emit(FilterState.failure(state.filters));

      }

    });
 
    on<DeleteFilterEvent>((event, emit) async {
      
      emit(FilterState.loading(state.filters));

      final filterId = event.filterId;
      List<Filter> updatedFilters = List.from(state.filters);
      DeleteFilterUsecase deleteFilterUsecase = DeleteFilterUsecase();

      try{

        await deleteFilterUsecase.execute(filterId);

        updatedFilters.removeWhere((filter) => filter.filterId == filterId);
        emit(FilterState.success(updatedFilters));

      } catch (error, stackTrace) {

        log(error.toString(), stackTrace: stackTrace);
        emit(FilterState.failure(state.filters));

      }

    });
 
  }
}
