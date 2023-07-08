// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_box_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TagBoxAdapter extends TypeAdapter<TagBox> {
  @override
  final int typeId = 9;

  @override
  TagBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TagBox()..tags = (fields[1] as List).cast<Tag>();
  }

  @override
  void write(BinaryWriter writer, TagBox obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TagBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
