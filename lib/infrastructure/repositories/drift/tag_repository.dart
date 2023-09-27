import 'dart:developer';

import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/domain/get_models/database_controller.dart';
import 'package:Caput/domain/repositories/tag_repository.dart';
import 'package:Caput/infrastructure/database/neuron_database.dart';
import 'package:drift/drift.dart';
import 'package:get/get.dart';

class TagRepositoryDrift extends TagRepository{

  late CaputDatabase database;

  TagRepositoryDrift(){

    final DatabaseController c = Get.find();
    database = c.database;

  }

  @override
  Future<void> addTag(Tag tag) async {

    await database
      .into(database.tags)
      .insert(
        mode: InsertMode.insertOrIgnore,
        TagDBO(
          tagId: tag.tagId, 
          userId: tag.userId, 
          caption: tag.caption, 
          body: tag.body, 
          creationTs: tag.creationTs, 
          updateTs: tag.updateTs
        )
      );
    
  }

  @override
  Future<void> deleteTag(String tagId) async {

    final query = database
      .delete(database.tags)
      ..where(
        (tbl) => tbl.tagId.equals(tagId)
      );

    await query.go();

  }
  
  @override
  Future<Tag> getTag(String tagId) async {

      final query = database
        .select(database.tags)
        ..where(
          (tbl) => tbl.tagId.equals(tagId)
        );

      final result = await query.getSingleOrNull();

      if(result == null){
        log("null");
        throw Error();
      }

      return Tag(
        tagId: tagId, 
        userId: result.userId, 
        caption: result.caption, 
        body: result.body, 
        creationTs: result.creationTs, 
        updateTs: result.updateTs
      );
 
  }
  
  @override
  Future<List<Tag>> getTags() async {

    final result = await database
      .select(database.tags).get();

    List<Tag> tags = [];

    for (final tagDBO in result){
      tags.add(
        getTagFromDBO(tagDBO)
      );
    }

    return tags;

  }
  
  @override
  Future<void> updateTag(Tag tag) async {

    final query = database
      .update(database.tags)
      ..where(
        (tbl) => tbl.tagId.equals(tag.tagId)
      );
      
      await query.write(
      TagDBO(
        tagId: tag.tagId, 
        userId: tag.userId, 
        caption: tag.caption, 
        body: tag.body, 
        creationTs: tag.creationTs, 
        updateTs: tag.updateTs
      )
    );
    
  }
  
  @override
  Future<Tag?> getTagByCaption(String caption) async {

    final query = database
      .select(database.tags)
      ..where(
        (tbl) => tbl.caption.equals(caption)
      );

    final result = await query.getSingleOrNull();

    if(result == null){
      return null;
    }
    
    return getTagFromDBO(result);
      
  }

  //MAPPING

  static Tag getTagFromDBO(TagDBO dbo){

    return Tag(tagId: dbo.tagId, caption: dbo.caption, body: dbo.body, updateTs: dbo.updateTs, creationTs: dbo.creationTs, userId: dbo.userId);

  }

}