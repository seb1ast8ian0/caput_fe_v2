import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/repositories/filter_repository.dart';
import 'package:Caput/domain/usecases/filter/get_filter_usecase.dart';
import 'package:Caput/infrastructure/repositories/drift/filter_repository.dart';

class GetFiltersUsecase{

  late FilterRepository _filterRepository;
  late GetFilterUsecase _getFilterUsecase;

  GetFiltersUsecase(){

    _filterRepository = FilterRepositoryDrift();
    _getFilterUsecase = GetFilterUsecase();

  }

  Future<List<Filter>> execute() async {

    List<Filter> filters = await _filterRepository.getFilters();
    List<Filter> result = [];

    for(Filter filter in filters){
      result.add(
        await _getFilterUsecase.execute(filter.filterId)
      );
    }

    return result;

  }

}