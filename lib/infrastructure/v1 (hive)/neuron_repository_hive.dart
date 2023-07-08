import 'dart:developer';

import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:hive/hive.dart';

class NeuronRepository{

  static const String _boxName = 'neurons';

  static Future<List<Neuron>> getNeurons() async {

    List<Neuron> result = [];

    try{

      var box = await Hive.openBox(_boxName);

      for(int i = 0; i < box.length; i++){
        result.add(box.getAt(i));
      }

    } catch (e){

      log(e.toString());

    }

    return result;
    
  }

  static Future<bool> addNeurons(List<Neuron> neurons) async {

    try{

      var box = await Hive.openBox(_boxName);

      for(Neuron neuron in neurons){
        //log("add all: ${neuron.payload.caption}");
        box.add(neuron);
      }

      return true;

    } catch (e){

      log(e.toString());
      return false;

    }

  }

  static Future<bool> addNeuron(Neuron neuron) async {

    try{

      var box = await Hive.openBox(_boxName);
      box.add(neuron);
      return true;

    } catch (e){

      log(e.toString());
      return false;

    }

  }

  static Future<bool> deleteNeuron(int index) async {

    try{

      var box = await Hive.openBox(_boxName);
      box.deleteAt(index);
      return true;

    } catch (e){

      log(e.toString());
      return false;

    }

  }

  static Future<bool> deleteNeurons() async {

    try{

      var box = await Hive.openBox(_boxName);
      box.deleteAll(box.keys);
      return true;

    } catch (e){

      log(e.toString());
      return false;

    }

  }

}