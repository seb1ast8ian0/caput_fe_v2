part of 'tags_search_bloc.dart';

@immutable
abstract class TagsSearchState {}

class TagsSearchShowState extends TagsSearchState {

  final List<Tag> rankedTags;
  final String query;

  TagsSearchShowState(this.rankedTags, this.query);

}

class TagsSearchHideState extends TagsSearchState{

}

class TagsSearchFeedbackState extends TagsSearchState{

  final Tag tag;

  TagsSearchFeedbackState(this.tag);

}
