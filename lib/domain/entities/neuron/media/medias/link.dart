import 'package:Caput/domain/entities/neuron/media/media.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'link.g.dart';

@HiveType(typeId: 8)
class Link extends Media{

  @HiveField(3)
  String url;

  @HiveField(4)
  String urlCaption;

  @HiveField(5)
  String urlBody;

  Link(this.url, this.urlCaption, this.urlBody, super.mediaId, super.type);

  @override
  String toString() {
    return "type: $type url: $url";
  }
  

}