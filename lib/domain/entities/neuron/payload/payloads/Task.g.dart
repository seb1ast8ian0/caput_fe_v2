// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 6;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      fields[4] as String,
      fields[5] as bool,
      fields[6] as DateTime?,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(6)
      ..writeByte(4)
      ..write(obj.body)
      ..writeByte(5)
      ..write(obj.completed)
      ..writeByte(6)
      ..write(obj.deadlineTs)
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
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
