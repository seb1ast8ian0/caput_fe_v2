import 'dart:developer';

import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NeuronRepository{

  static const String _boxName = 'neurons';

  static Future<List<Neuron>> getNeurons() async {

    List<Neuron> result = [];

    try{

      var box = await Hive.openBox(_boxName);

      for(int i = 0; i < box.length - 1; i++){
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

      for(int i = 0; i < neurons.length - 1; i++){
        box.add(neurons[i]);
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
      box.deleteFromDisk();
      return true;

    } catch (e){

      log(e.toString());
      return false;

    }

  }

}