
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/domain/get_models/tags_list.dart';
import 'package:bloc/bloc.dart';
import 'package:get/instance_manager.dart';
import 'package:meta/meta.dart';

part 'tags_search_event.dart';
part 'tags_search_state.dart';

class TagsSearchBloc extends Bloc<TagsSearchEvent, TagsSearchState> {
  
  TagsSearchBloc() : super(TagsSearchHideState()) {

    on<TagsSearchShowEvent>((event, emit) {

      final query = event.query;
      TagsList tagsList = Get.find();

      final rankedTags = rankTags(tagsList.tags, query);

      //log(rankedTags.toString());

      emit(TagsSearchShowState(rankedTags, query));
      
    });

    on<TagsSearchHideEvent>((event, emit) {

      emit(TagsSearchHideState());

    });
  
    on<TagsSearchFeedbackEvent>((event, emit) {
      emit(TagsSearchFeedbackState(event.tag));
    });
  
  }

  //SEARCH

  static List<Tag> rankTags(List<Tag> tags, String query) {
  
    var rankedTags = tags
      .map((e) => rankTag(e, query))
      .toList();

    rankedTags = rankedTags
      .where((tag) => tag.rank > 50)
      .toList();

    rankedTags
      .sort((a, b) => a.rank.compareTo(b.rank));

    //log(rankedTags.toString());

    final sortedTags = rankedTags
      .map((e) => e.tag)
      .toList();

    return sortedTags.reversed.toList();

  }

  static TagRank rankTag(Tag tag, String q){

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

    return TagRank(tag, rank);

  }

  static int abs(int number){
    return number < 0 ? -number : number;
  }

}

class TagRank{

  Tag tag;
  double rank;

  TagRank(this.tag, this.rank);

  @override
  String toString() {
    return '${tag.caption}$rank';
  }

}

