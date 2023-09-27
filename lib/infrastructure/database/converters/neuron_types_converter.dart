import 'dart:convert';

import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:drift/drift.dart';

class NeuronTypesConverter extends TypeConverter<List<NeuronType>, String> {

  @override
  List<NeuronType> fromSql(String fromDb) {
    
    var neuronTypes = <NeuronType>[];

    List<dynamic> jsonData = json.decode(fromDb);

    for (var name in jsonData) {
      final neuronType = NeuronType.values.firstWhere((element) => element.toString() == 'NeuronType.${name.toString()}');
      neuronTypes.add(neuronType);
    }

    return neuronTypes;

  }

  @override
  String toSql(List<NeuronType> value) {

    var data = <String>[];

    for (var v in value) {
      final strNeuronType = v.name;
      data.add(strNeuronType);
    }

    return json.encode(data);
  }



}