

import 'dart:developer';

import 'package:Caput/domain/entities/neuron/tag/tag.dart';
import 'package:Caput/infrastructure/v1%20(hive)/tag_repository_hive.dart';
import 'package:Caput/main.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';

class TagController{

  TagSearchEvent hide(){

    return TagSearchEvent(
      "",
      Future(() => [])
    );

  }

  TagSearchEvent searchTags(String query){

    var cleanQuery = query.substring(1);
    //log(cleanQuery);

    log("tag_controller");

    return TagSearchEvent(
      query, 
      rankTags(TagRepository.getTags(), cleanQuery)
    );

  }

}

Future<List<Tag>> rankTags(Future<List<Tag>> tags, String query) async {
  
  List<TagRank> rankedTags = [];

  for (var tag in await tags) {
    rankedTags.add(rankTag(tag, query));
  }

  rankedTags.sort((a, b) => a.rank.compareTo(b.rank));

  List<Tag> sortedTags = [];

  rankedTags.forEach((tag) {
    sortedTags.add(tag.tag);
  });

  return sortedTags.reversed.toList();

}

TagRank rankTag(Tag tag, String q){

  double rank = 0;
  String caption = tag.caption.toLowerCase();
  String query = q.toLowerCase();

  if(caption == query){
    rank += 100;
  }

  if(caption.startsWith(query)){
    rank += 25;
  }

  if(caption.contains(query)){
    rank += 50;
  }

  rank += (1/(abs(caption.length - query.length) + 1) * 50);

  //log('tag: ${tag.caption}/ rank: $rank');

  return TagRank(tag, rank);

}

int abs(int number){
  return number < 0 ? -number : number;
}

class TagRank{

  Tag tag;
  double rank;

  TagRank(this.tag, this.rank);

}

class TagSearchEvent{

  late bool isEmpty;
  String query;
  Future<List<Tag>> tags;

  TagSearchEvent(this.query, this.tags){
    isEmpty = query.isEmpty;
  }

}

class TagFeedbackEvent{
  
  late Tag tag;

  TagFeedbackEvent(this.tag);

}