

import 'dart:developer';

import 'package:Caput/domain/entities/neuron/tag/tag.dart';

class TagController{

  TagSearchResult searchTags(String query){

    var cleanQuery = query.substring(1);
    log(cleanQuery);

    var tags = [
      Tag("id1", "caption", "body"),
      Tag("id2", "caption2", "body2"),
    ];

    var result = TagSearchResult(
      query, 
      Future(() => tags)
    );

    return result;

  }

}

class TagSearchResult{

  String query;
  Future<List<Tag>> tags;

  TagSearchResult(this.query, this.tags);

}