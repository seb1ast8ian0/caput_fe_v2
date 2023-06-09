// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Neuron.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NeuronAdapter extends TypeAdapter<Neuron> {
  @override
  final int typeId = 1;

  @override
  Neuron read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Neuron(
      fields[1] as String,
      fields[2] as String,
      fields[3] as Payload,
      fields[4] as DateTime,
      (fields[5] as List).cast<Media>(),
      (fields[6] as List).cast<Tag>(),
    );
  }

  @override
  void write(BinaryWriter writer, Neuron obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.neuronId)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.payload)
      ..writeByte(4)
      ..write(obj.creationTs)
      ..writeByte(5)
      ..write(obj.media)
      ..writeByte(6)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NeuronAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
