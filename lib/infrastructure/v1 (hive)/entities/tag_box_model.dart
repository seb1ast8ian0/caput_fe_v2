import 'package:Caput/domain/entities/neuron/tag/tag.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'tag_box_model.g.dart';

@HiveType(typeId: 9)
class TagBox extends HiveObject {

  @HiveField(1)
  List<Tag> tags = [];

}