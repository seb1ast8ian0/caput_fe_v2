// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Link.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LinkAdapter extends TypeAdapter<Link> {
  @override
  final int typeId = 3;

  @override
  Link read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Link(
      fields[4] as String,
      fields[5] as String,
      fields[7] as String,
      fields[6] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Link obj) {
    writer
      ..writeByte(7)
      ..writeByte(4)
      ..write(obj.body)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.urlTitle)
      ..writeByte(7)
      ..write(obj.urlDescription)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.caption)
      ..writeByte(3)
      ..write(obj.priority);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LinkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
