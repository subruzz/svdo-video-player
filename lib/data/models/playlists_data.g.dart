// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlists_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayListModelsAdapter extends TypeAdapter<PlayListModels> {
  @override
  final int typeId = 1;

  @override
  PlayListModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListModels(
      pName: fields[0] as String,
      pVideos: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlayListModels obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.pName)
      ..writeByte(1)
      ..write(obj.pVideos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
