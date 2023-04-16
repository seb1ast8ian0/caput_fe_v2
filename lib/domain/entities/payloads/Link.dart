import 'package:Caput/domain/entities/Payload.dart';
import 'package:hive/hive.dart';
part 'Link.g.dart';

@HiveType(typeId: 3)
class Link extends Payload {

  @HiveField(4)
  String body;
  @HiveField(5)
  String url;
  @HiveField(6)
  String urlTitle;
  @HiveField(7)
  String urlDescription;

  Link(this.body, this.url, this.urlDescription, this.urlTitle, super.type, super.caption, super.priority);

  @override
  String toString() {
    return url;
  }


}