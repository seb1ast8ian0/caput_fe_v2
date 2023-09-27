import 'package:Caput/domain/entities/filter/filter.dart';

abstract class FilterRepository {

  Future<void> addFilter(Filter filter);
  Future<void> deleteFilter(String filterId);
  Future<void> updateFilter(Filter filter);
  Future<Filter> getFilter(String filterId);
  Future<List<Filter>> getFilters();

}
