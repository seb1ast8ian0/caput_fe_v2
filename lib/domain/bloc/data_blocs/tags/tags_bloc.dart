import 'dart:developer';

import 'package:Caput/domain/entities/neuron/Neuron.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/domain/get_models/database_controller.dart';
import 'package:Caput/domain/get_models/tags_list.dart';
import 'package:Caput/infrastructure/database/neuron_database.dart';
import 'package:bloc/bloc.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:get/instance_manager.dart';
import 'package:uuid/uuid.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {

  TagsBloc() : super(TagsState.loading()) {

    on<AddTagsForNeuronEvent>((event, emit) async {

      emit(TagsState.loading());
      
      final tags = event.tags;
      final neuron = event.neuron;

      log(tags.toString());

      try{

        await insertTagsForNeuron(tags, neuron);
        
        emit(TagsState.success());

      } catch (error, stackTrace){

        log(error.toString(), stackTrace: stackTrace);
        emit(TagsState.failure());

      }

    });

    on<InitTagsEvent>((event, emit) async {

      emit(TagsState.loading());
      TagsList tagsList = Get.find();

      try{

        final tags = await getTags();
        tagsList.addTags(tags);
        emit(TagsState.success());

      } catch (error, stackTrace){

        log(error.toString(), stackTrace: stackTrace);
        emit(TagsState.failure());

      }
      
    });

  }

  //DATABASE

  static Future<List<Tag>> insertTagsForNeuron(List<String> tags, Neuron neuron) async {

    TagsList tagsList = Get.find();

    final DatabaseController c = Get.find();
    final database = c.database;
    final List<Tag> result = [];

    for(final tag in tags) {

      final cleanTag = tag.substring(1);

      final filteredTags = await (database
        .select(database.tags)
        ..where((tagRow) => tagRow.caption.equals(cleanTag)))
        .get();

      if(filteredTags.isNotEmpty){

        //Tag vorhanden
        //log(tag + " -> Tag vorhanden");

        var foundTag = filteredTags.first;
        insertNeuronTagRelation(neuron.neuronId, foundTag.tagId);
        result.add(getTagFromDBO(filteredTags.first));

      } else {

        //Tag nicht vorhanden
        //log(tag + " -> Tag nicht vorhanden");

        DateTime now = DateTime.now();
        final tagDBO = TagDBO(
          tagId: const Uuid().v4(), 
          userId: neuron.userId, 
          caption: cleanTag, 
          body: "", 
          creationTs: now, 
          updateTs: now
        );

        database
          .into(database.tags)
          .insert(
            tagDBO,
            mode: InsertMode.insertOrIgnore
          );

        insertNeuronTagRelation(neuron.neuronId, tagDBO.tagId);

        result.add(getTagFromDBO(tagDBO));

      }

    }

    tagsList.addTags(result);

    return result;

  }

  static Future<void> insertNeuronTagRelation(String neuronId, tagId) async {

    final DatabaseController c = Get.find();
    final database = c.database;

    database
      .into(database.neuronTagRelations)
      .insert(
        NeuronTagRelation(neuronId: neuronId, tagId: tagId),
        mode: InsertMode.insertOrIgnore
      );

  }

  static Future<List<Tag>> getTags() async {

    final DatabaseController c = Get.find();
    final database = c.database;

    final tagDBOs = await database
      .select(database.tags).get();

    return tagDBOs
      .map((tagDBO) => getTagFromDBO(tagDBO))
      .toList();

  }

  //MAPPING

  static Tag getTagFromDBO(TagDBO dbo){

    return Tag(tagId: dbo.tagId, caption: dbo.caption, body: dbo.body, updateTs: dbo.updateTs, creationTs: dbo.creationTs, userId: dbo.userId);

  }

}