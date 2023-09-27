import 'package:Caput/domain/entities/neuron/payload.dart';

abstract class PayloadRepository {

  Future<void> addPayload(String neuronId, Payload payload);
  Future<void> deletePayload(String neuronId);
  Future<void> updatePayload(String neuronId,Payload updatedPayload);
  Future<Payload> getPayload(String neuronId);

}