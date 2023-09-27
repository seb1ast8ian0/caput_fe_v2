import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class FilterRepository {

  Future<void> addFilter(Filter filter);
  Future<void> deleteFilter(String filterId);
  Future<void> updateFilter(Filter filter);
  Future<Filter> getFilter(String filterId);
  Future<List<Filter>> getFilters();

}
