// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Payload.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PayloadAdapter extends TypeAdapter<Payload> {
  @override
  final int typeId = 2;

  @override
  Payload read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Payload(
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Payload obj) {
    writer
      ..writeByte(3)
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
      other is PayloadAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
