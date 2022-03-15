// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MusicModelAdapter extends TypeAdapter<MusicModel> {
  @override
  final int typeId = 0;

  @override
  MusicModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MusicModel(
      audioName: fields[0] as String,
      audioFile: fields[1] as String,
      imageFile: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MusicModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.audioName)
      ..writeByte(1)
      ..write(obj.audioFile)
      ..writeByte(2)
      ..write(obj.imageFile);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MusicModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
