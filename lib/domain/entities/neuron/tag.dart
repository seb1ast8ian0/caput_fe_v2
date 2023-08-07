class Tag{

  String tagId;
  String userId;
  String caption;
  String body;
  DateTime creationTs;
  DateTime updateTs;

  Tag({
    required this.tagId,
    required this.userId,
    required this.caption,
    required this.body,
    required this.creationTs,
    required this.updateTs
  });

  @override
  String toString() {
    return caption;
  }

}