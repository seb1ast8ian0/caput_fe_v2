import 'package:Caput/domain/entities/neuron/payloads/date.dart';

abstract class DateRepository {

  Future<void> addDate(String neuronId, Date date);
  Future<void> deleteDate(String neuronId);
  Future<void> updateDate(String neuronId, Date date);
  Future<Date> getDate(String neuronId);

}