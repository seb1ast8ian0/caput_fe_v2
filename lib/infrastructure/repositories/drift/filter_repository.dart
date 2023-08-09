import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/repositories/filter_repository.dart';

class FilterRepositoryDrift extends FilterRepository{

  @override
  Future<void> addFilter(Filter filter) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFilter(Filter filter) {
    throw UnimplementedError();
  }

  @override
  Future<Filter> getFilter(String filterId) {
    throw UnimplementedError();
  }

  @override
  Future<List<Filter>> getFilters() {
    throw UnimplementedError();
  }

  @override
  Future<Filter> updateFilter(Filter filter) {
    throw UnimplementedError();
  }

}