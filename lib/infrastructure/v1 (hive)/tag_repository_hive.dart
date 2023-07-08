import 'dart:developer';

import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/domain/entities/neuron/tag/tag.dart';
import 'package:Caput/infrastructure/v1%20(hive)/entities/tag_box_model.dart';
import 'package:Caput/infrastructure/v1%20(hive)/neuron_repository_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TagRepository{

  static const String _boxName = 'neurons';

  static Future<List<Tag>> getTags() async {

    List<Tag> result = [];

    NeuronRepository.getNeurons().then((neurons){
      for(var neuron in neurons){
        for(var tag in neuron.tags){
          if(!result.contains(tag)){
            result.add(tag);
          }
        }
      }
    });

    return result;

  }

  static Future<bool> addTags(List<Tag> tags) async {

  try{

    var box = Hive.box('tagBox');

    TagBox tagBox = box.getAt(0);

    List<Tag> result = tagBox.tags;
  
    for(var tag in tags){
      if(!result.contains(tag)){
        log("add");
        result.add(tag);
      }
    }

    tagBox.tags = result;

    box.deleteAt(0);
    box.add(tagBox);

    return true;

  } catch (e){

    log(e.toString());
    return Future.error(e);

  }

}

  static Future<List<Tag>> getAllTags() async {


    try{

      var box = Hive.box('tagBox');

      log(box.length.toString());

      TagBox tagBox = box.getAt(0);

      return tagBox.tags;

    } catch (e){

      log(e.toString());
      return Future.error(e);

    }

  }

}