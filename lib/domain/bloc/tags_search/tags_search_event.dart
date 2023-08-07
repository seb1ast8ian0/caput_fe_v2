part of 'tags_search_bloc.dart';

@immutable
abstract class TagsSearchEvent {}

class TagsSearchShowEvent extends TagsSearchEvent{

  final String query;

  TagsSearchShowEvent(this.query);

}

class TagsSearchHideEvent extends TagsSearchEvent{

  TagsSearchHideEvent();

}

class TagsSearchFeedbackEvent extends TagsSearchEvent{

  final Tag tag;

  TagsSearchFeedbackEvent(this.tag);

}
