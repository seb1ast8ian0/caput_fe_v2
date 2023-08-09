part of 'tags_bloc.dart';

enum TagsStateStatus{ loading, success, failure }

class TagsState extends Equatable{

  final TagsStateStatus status;

  const TagsState(this.status);

  factory TagsState.loading() =>
      const TagsState(TagsStateStatus.failure);

  factory TagsState.success() =>
      const TagsState(TagsStateStatus.success);

  factory TagsState.failure() =>
      const TagsState(TagsStateStatus.failure);
  
  @override
  List<Object?> get props => [status];
  
}